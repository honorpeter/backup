C++ Boost Thread:
    创建线程:
            线程对象可以方便使用==和!=进行比较来确定它们是否是代表同一个线程
            调用boost::thread::join来等待线程执行完毕
            #include <boost/thread/thread.hpp>
            #include <iostream>

            void hello()
            {
                    std::cout <<
                    "Hello world, I'm a thread!"
                    << std::endl;
            }

            int main(int argc, char* argv[])
            {
                    boost::thread thrd(&hello); //传递普通函数或者类静态函数
                    thrd.join();
                    return 0;

    中断线程执行：
        可以调用：t.interupt() 中断执行
            }
    互斥体:
            Boost线程库提供了6中互斥体类型，下面是按照效率进行排序：
                boost::mutex,
                boost::try_mutex,
                boost::timed_mutex,
                boost::recursive_mutex,
                boost::recursive_try_mutex,
                boost::recursive_timed_mutex

                #include <boost/thread/thread.hpp>
                #include <boost/thread/mutex.hpp>
                #include <iostream>

                boost::mutex io_mutex;

                struct count
                {
                        count(int id) : id(id) { }
        
                        void operator()()
                        {
                                for (int i = 0; i < 10; ++i)
                                {
                                        boost::mutex::scoped_lock
                                        lock(io_mutex);
                                        std::cout << id << ": "
                                        << i << std::endl;
                                }
                        }
                        
                        int id;
                };

                int main(int argc, char* argv[])
                {
                        boost::thread thrd1(count(1));
                        boost::thread thrd2(count(2));
                        thrd1.join();
                        thrd2.join();
                        return 0;
                }
            









