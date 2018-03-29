概念：
    时钟 clock  
        每个时钟函数都有一个now 函数 用来返回 当前时间点
        chrono::system_clock 代表系统时间，比如电脑上显示的当前时间
        chrono::steady_clock 其特点是时间是单调增长的
        chrono::process_real_cpu_clock 表示自进程启动以来使用的CPU时间
        chrono::thread_clock 返回基于线程统计的花费时间
    time_point 时间点
        chrono::time_point_cast转换函数，可以显式从高粒度向低粒度对time_point进行转换  
    duration 时长：
        chrono::nanoseconds、chrono::milliseconds、chrono::microseconds、chrono::seconds、chrono::minutes、chrono::hours，
        可以进行 加减 操作
        获取 duration：
    chrono::steady_clock::time_point start = chrono::steady_clock::now();
    chrono::duration<double> sec = chrono::steady_clock::now() - start;


#include <boost/chrono.hpp>
#include <iostream>

using namespace boost::chrono;

int main()
{
  std::cout << system_clock::now() << '\n';
#ifdef BOOST_CHRONO_HAS_CLOCK_STEADY
  std::cout << steady_clock::now() << '\n';
#endif
  std::cout << high_resolution_clock::now() << '\n';

#ifdef BOOST_CHRONO_HAS_PROCESS_CLOCKS
  std::cout << process_real_cpu_clock::now() << '\n';
  std::cout << process_user_cpu_clock::now() << '\n';
  std::cout << process_system_cpu_clock::now() << '\n';
  std::cout << process_cpu_clock::now() << '\n';
#endif

#ifdef BOOST_CHRONO_HAS_THREAD_CLOCK
  std::cout << thread_clock::now() << '\n';
  thread_clock::time_point p = thread_clock::now();
  std::cout << "hhhhhhhhhhh"<< std::endl;
  std::cout << p << '\n';
  std::cout << time_point_cast<milliseconds>(p) << '\n';
#endif
}

