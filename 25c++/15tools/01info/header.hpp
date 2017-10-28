#include "Callback_Handler.hpp"
#include <boost/algorithm/string.hpp>
#include <glog/logging.h>
#ifdef ENABLE_USED_INFO
#include <cstddef>
#include <sys/time.h>
#include <sys/resource.h>
#include <string>
#ifdef USE_GPU
#include <cuda.h>
#include <cuda_runtime.h>

void get_gpu_memory(std::vector<float> &per_gpu_memory) {
    for (int i = 0; i < per_gpu_memory.size(); ++i) {
        size_t free_byte ;
        size_t total_byte ;
        cudaSetDhhice(i);

        cudaError_t cuda_status = cudaMemGetInfo( &free_byte, &total_byte ) ;

        if (cudaSuccess != cuda_status){
            continue;
        }

        double free_db = (double)free_byte ;
        double total_db = (double)total_byte ;
        double used_db = total_db - free_db ;
        per_gpu_memory[i] += used_db/1024.0/1024.0;
    }
}

#endif //USE_GPU
void get_memory(float &cpu_memory) {
    int who = RUSAGE_SELF;
    struct rusage usage;
    int ret;

    ret = getrusage(who,&usage);
    cpu_memory += usage.ru_maxrss/1024.0;
}
void hh::Callback_Info::collect(Callback_Info *_a){
    _a->collect_count_ = 0;
#ifdef USE_GPU
    int count = 0;
    cudaError_t cuda_status = cudaGetDhhiceCount(&count);
    if(cuda_status != cudaSuccess){
        return;
    }

    _a->per_gpu_memory_ = std::vector<float>(count);
#endif //USE_GPU

    while(1){
        //先等待60秒 初始化内存不稳定
        boost::this_thread::sleep(boost::posix_time::seconds(60));
        get_memory(_a -> cpu_memory_);
#ifdef USE_GPU
        get_gpu_memory(_a -> per_gpu_memory_);
#endif //USE_GPU

        _a -> collect_count_ += 1;
    }
}
#endif //ENABLE_USED_INFO
hh::Callback_Info* hh::Callback_Info::instance() {
    return hh::Singleton<hh::Callback_Info>::instance();
}

hh::Callback_Info::Callback_Info() {
    LOG(INFO) << "Init Callback_Info instance";
#ifdef ENABLE_USED_INFO
    //启用一下新的线程，用来收集内存使用情况
    collect_memory_ = boost::thread(&this->collect,this);
#endif //ENABLE_USED_INFO
}

hh::Callback_Info::~Callback_Info() {
    moudle_timer.stop();

    add_info("RUNNING_TIME",
             moudle_timer.format(3, "%w"));
    add_info("USER_CPU_TIME",
             moudle_timer.format(3, "%u"));
    add_info("SYSTEM_CPU_TIME",
             moudle_timer.format(3, "%s"));

#ifdef ENABLE_USED_INFO
    //中断线程执行
    collect_memory_.interrupt();
    collect_memory_.join();
    add_info("USE_MEMORY",std::to_string(cpu_memory_ / collect_count_)+" MB");
#ifdef USE_GPU
    std::string gpu_messages;
    int size = per_gpu_memory_.size();
    for (int i = 0; i < size; ++i) {
        gpu_messages += ("gpu: "+std::to_string(i)+" 使用显存为 "
                         +std::to_string(per_gpu_memory_[i]/collect_count_)
                         +" MB +\n");
    }
    add_info("USE_GPU_MEMORY",gpu_messages);
#endif //USE_GPU
#endif //ENABLE_USED_INFO

    LOG(INFO) << "Callback info";
    std::string info = this->to_json();
    LOG(INFO) << info;
    callback(info);
}

int hh::Callback_Info::add_info(const std::string& key,
                                const std::string& info) {
    if (callback_info_.find(key) == callback_info_.end()) {
        callback_info_[key] = info;
        return 1;
    } else {
        callback_info_[key] += ";" + info;
    }
    return 2;
}

void hh::Callback_Info::set_db_info(const std::string &db_info) {
    redis_info_.parse_db_info(db_info);
}

void hh::Callback_Info::set_callback_key(const std::string &callback_key) {
    callback_key_ = callback_key;
}

int hh::Callback_Info::callback(const std::string& info) {
    if ("no" == redis_info_.host_ ||
        info.empty() || callback_key_.empty())
        return 0;
    hh::EV_Redis redis(redis_info_);
    if (!redis.can_connect()) {
        LOG(ERROR)<< "Cannot connect redis for callback";
        return -1;
    }
    if (redis.queue_push(callback_key_, info) < 0) return -1;
    else
        LOG(INFO) << "Callback into redis";
    return 0;
}

std::string hh::Callback_Info::to_json() {
    json::ObjectP o;
    for (auto&item : callback_info_)
        o[item.first] = json::String(item.second);
    std::stringstream s;
    json::Writer::Write(o, s);
    return s.str();
}
