时间：
        内核通过三种方式 来衡量时间：
            墙钟时间    wall time
                    日常生活所用的时间
            进程时间
                    进程在处理器上消耗的时间    既包括用户空间代码本身消耗的
                    时间 也包括该进程在内核上所消耗的时间
            单调时间
                    严格线性递增的  从系统重启开始

        还可从另一种维度看时间：
            相对时间
                    单调时间对于计算相对时间很有用
            绝对时间
                    一般使用墙钟时间来计算

        操作系统通过软件时钟 来获取时间的变化   软件时钟 是内核维护的
            内核启动一个周期性的计时器  称为系统计数器  当计数器完成一个
            周期的话 墙钟时间就增加一个单位
            可以获得系统计数器的频率    
                long hz;
                hz = sysconf(_SC_CLK_TCK);
                if(hz==-1)
                    perror("sysconf");
    时间的数据结构：
        原始表示：
            typedef long time_t;
        微妙级精度
            <sys/time.h>
            struct timeval{
                time_t tv_sec;
                suseconds_t tv_usec;
            };
        纳秒级精度：
            <time.h>
            struct timespec{
                time_t tv_sec;   //seconds
                long tv_nsec;   //nanoseconds
            };
        POSIX时钟：
                一种实现和表示时间原的标准
            clockid_t 类型表示了特定的POSIX时钟
            
            CLOCK_MONOTONIC
                    单调时间 任何进程都无法修改
            CLOCK_MONOTONIC_RAW
                
            CLOCK_PROCESS_CUPTIME_ID
                
            CLOCK_THREAD_CPUTIME_ID
            
            CLOCK_REALTIME
                    wall time
        时间源精度：
            获取时间源精度：
                <time.h>
                int clock_getres(clock_t clock_id,
                                    struct timespec *res);
                        OK 将结果保存到res中
                        failed -1   如果res为NULL 返回0
            例：
                clockid_t clocks[] = {
                    CLOCK_MONOTONIC,
                    CLOCK_MONOTONIC_RAW,
                    CLOCK_PROCESS_CUPTIME_ID,
                    CLOCK_REALTIME,
                    CLOCK_THREAD_CPUTIME_ID,
                    (clockid_t) -1
                };

                int i;
                for (i = 0; clocks[i] != (clockid_t) -1;i++){
                    struct timespec res;

                    int ret;

                    ret = clock_getres(clocks[i],&res);
                    if(ret)
                        perror("clock_getres");
                    else
                        printf("clock = %d sec =%ld nesc = %ld\n",
                                clocks[i],res.tv_sec,res.tv_nsec);
                }
                编译：
                    gcc -Wall -w -02 -lrt -g -o hh hh.

    获取当前时间：
        <time.h> 
        time_t time(time_t *t);
            返回当前的时间 如果t不为NULL那么也把时间写入 指针指向
                1970 1 1 早上 00:00:00 到现在的时间

        更好的接口：
            <sys/time.h>
            int gettimeofday(struct timeval *tv,
                                struct timezone *tz);
                    把时间放入到tv中 tz已经停止使用了 直接写NULL
        高级接口：
            <time.h> 
            int clock_gettime(clockid_t clock_id,
                                struct timespec *ts);
                        OK  0   将指定时间源的当前时间存储到ts中
                        failed -1
            
        获取进程时间：
            <sys/times.h>
            struct tms{
                clock_t tms_utime;      //user time consumed
                clock_t tms_stime;      //system time consumed
                clock_t tms_cutime;      //user time consumed by children
                clock_t tms_cstime;      //system time consumed by children
            };

            clock_t times(struct tms *buf);
    设置当前时间：
            #define _SVID_SOURCE
            <time.h> 
            int stime(time_t *t); 
                OK 0    fialed -1
            只有root权限才可以设置
        设置支持高精度的时间：
            <sys/time.h>
            int settimeofday(const struct timeval *tv,
                            const struct tiezone *tv);
                OK 0    fialed -1
        设置时间的高级接口：
            <time.h> 
            int clock_settime(clockid_t clock_id,
                             const struct timespec *ts);
                OK 0 failed -1
                为指定的时间源设置指定的时间
    玩转时间：
            <time.h>
            char *asctime(const struct tm *tm);
                它不是线程安全的
            char *asctime_r(const struct tm *tm,char *buf);
                把时间存储到buf 线程安全了  buf至少为26个字符长度

            time_t mktime(struct tm *tm);
                将tm转为time_t型

            将time_t转为 ASCII表示方式
            char *ctime (const time_t *timep);
            char *ctime_r (const time_t *timep,char *buf);
                failed NULL
            
            将time_t转为 UTC时区格式的
            struct tm *gtime(const time_t *timep);
            struct tm *gtime_r(const time_t *timep,struct tm* result);

            类似gtime但表示为用户时区
            struct tm *localtime(const time_t *timep);
            struct tm *localtime_r(const time_t *timep,struct tm *result);

            计算时间的差值
            double difftime(time_t ,time_t time0);

    调校系统时钟：
            如果wall time突然变化 会对其他应用程序产生很大影响
            所以 提供个一种 可让内核 渐变 直到最后 正确的方法
            #define _BSD_SOURCE
            <sys/time.h>
            int adjtime(const struct timeval *delta,
                            struct timeval *olddelta);
                Ok  内核会使用增量delta来逐渐调整时间 然后返回0
                delta为正 内核加速时间 修改
                        负      减缓时间

            还有一个更复杂的 。。 adjtimex()
            RFC定义的。。。
    睡眠和等待：
            <unistd.h>
            unsigned int sleep(unsigned int seconds);
            会返回 未睡眠的秒数 所以成功0
        以微妙级精度睡眠
            <unistd.h>
            void usleep(unsigned long usec);

            #define _XOPEN_SOURCE 500
            <unistd.h>
            int usleep(useconds_t usec);
            不同的标准。。。。

            一般为了移植  这样用
                unsigned inu usecs = 200;
                usleep(usecs);
        以纳秒级定都睡眠：
            #define _POSIX_C_SOURCE 199309
            <time.h> 
            int nanosleep(const struct timespec *req,
                            struct timespec *rem);
                OK 0 failed -1
                函数执行 req的时间
                如果当中被信号打断 如果rem不为NULL那么将剩余时间存储到rem中
                然后重新调用这个函数 将rem传递给req
                
                struct timespec req = {.tv_sec = 0,
                                        .tv_nsec = 1693};
                struct timespec rem;
                int ret;

                retry:
                    ret = nanosleep(&req,&rem);
                    if(ret){
                        if(errno == EINTR){
                            //retry with the provided time remainting
                            req.tv_sec = rem.tv_sec;
                            req.tv_nsec = rem.tv_nsec;
                            goto retry;
                        }
                        perror("nanaosleep");
                    }

        实现睡眠的高级方法：
            <time.h>
            int clock_nanosleep(clockid_t clock_id,
                                int flags,
                                const stuct timespec *req,
                                struct timespec *rem);
                和nanosleep函数类似
                这个函数可以指定时间源
                flags： 
                        TIMER_ABSTIME
                            req指定为一个绝对的时间值
                        0
        sleep的可移植实现
            使用select  
            select(0,NULL,NULL,NULL,&tv);
    超时：
            各种系统调度。。。
    简单的闹钟：
            <unistd.h> 
            unsigned int alarm(unsigned int seconds);
                    函数会在real time几秒之后将SIGALRM信号发给调用的进程

            void alarm_handler(int signum){
                printf("five second passed\n");
            }
            void func(void)
            {
                signal(SIGALRM,alarm_handler);
                alram(5);
                pause();
            }
    计时器
        <sys/time.h>
        int getitimer(int which,
                        struct itimerval *value);

        int setitiimer(int which,
                        const struct itimerval *value,
                       struct itimerval *ovalue,
                        );
            which:
                ITIMER_REAL
                    当设定的时间 过了 真是时间之后 发送SIGALRM信号
                ITIMER_VIRTUAL
                    只在进程用户空间的代码执行减少 当指定的进程时间过去后
                    发送SIGVIRTUAL给进程
                ITIMER_PROF
                    。。。。SIGPROF
    高级定时器：
            创建定时器；    timer_create
            初始化定时器    timer_settime
            销毁            timer_delete
       创建定时器：
            <signal.h> 
            <time.h>

            int timer_create(clockid_t clockid,
                            struct sigevent *evp,
                            timer_t *timerid);
                                OK 0 failed -1
                        定时器和 timerid关联
                evp：
                    struct sigevent{
                        union sigval sigev_value;
                        int sigev_signo;
                        int sigev_notify;
                        void (*sigev_notify_fucntion)(union sigval);
                        pthread_attr_t *sigev_notify_attributes;
                    };
                    union sigval{
                        int sival_int;
                        void *sival_ptr;
                    };
            int timer_setime(timer_t timerid,
                            int flags,
                            const struct itimerspec *value,
                            struct itimerspec *ovalue);

            struct itimerspec {
                struct timespec it_interval;
                struct timespe it_value;
            };
            。。。。。
            timer_gettime
            timer_getoverrun

            int timer_delete(timer_t timerid);

















