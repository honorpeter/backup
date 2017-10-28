#ifndef Callback_Handler_hpp
#define Callback_Handler_hpp

#include <string>
#include <unordered_map>
#include <boost/assign/list_of.hpp>
#include <boost/timer/timer.hpp>
#include <boost/thread/thread.hpp>

#include "DB_Service.hpp"
namespace hh {
    /**
     @brief 运行时信息
     **/
    enum class Running_Statu {
        UNKNOWN = 0,    ///< 无
        INFO = 1,   ///< 普通信息
        WARNING = 2,    ///< 警告信息
        ERROR = 4,  ///< 错误信息
        FATAL = 5  ///< 致命错误信息
    };
    /**
     @brief 计时信息
     **/
    enum class Timer_Info {
        UNKNOWN = 0,
        RUNNING_TIME = 1,   ///< 总共运行时间
        USER_CPU_TIME = 2,  ///< 程序占用的cpu时间
        SYSTEM_CPU_TIME = 3,  ///< 程序调用系统资源占用的cpu时间
        USE_MEMORY = 4,     ///< 程序占用主机内存多少
        USE_GPU_MEMORY = 5     ///< 程序占用程序占用多少显存
    };

    static std::unordered_map<int, std::string> Timer_Info_Str = {
        {0, "UNKNOWN"},
        {1, "RUNNING_TIME"},
        {2, "USER_CPU_TIME"},
        {3, "SYSTEM_CPU_TIME"},
        {4, "USE_MEMORY"},
        {5, "USE_GPU_MEMORY"}
    };

    /**
     @brief 回调的信息
     **/
    struct Callback_Info {
     public:
        /**
         @brief 增加一条callback info
         @return 1表示新增的info，2表示在已有的key上增加
         **/
        int add_info(const std::string& key, const std::string& info);
        void set_db_info(const std::string& db_info);
        void set_callback_key(const std::string& callback_key);
        static Callback_Info * instance();
        Callback_Info();
        ~Callback_Info();
     private:
        int callback(const std::string& info);
        /**
         @brief 把回调信息转成json字符串
         **/
#ifdef ENABLE_USED_INFO
        /**
         @brief 开启新的线程，运行这个函数，每隔一分钟来搜集一次内存使用信息
         **/
        static void collect(Callback_Info *_a);
        int collect_count_; ///< 记录collect收集的次数
        float cpu_memory_;
#ifdef USE_GPU
        std::vector<float> per_gpu_memory_;
#endif //USE_GPU
        boost::thread collect_memory_;

#endif //ENABLE_USED_INFO
        std::string to_json();
        std::unordered_map<std::string, std::string>  callback_info_;   ///< 回调信息存储
        boost::timer::cpu_timer moudle_timer;
        hh::DB_Info redis_info_;
        std::string callback_key_;
    };
}  // namespace hh
#endif /* Callback_Handler_hpp */
