进程管理：
    进程ID
        每个进程都有一个 ID 简称pid 用于内核识别
        空闲进程：  没有进程运行的时候 内核运行的进程 pid=0
        init进程：  第一个进程 pid=1
            linux内核尝试4的地方寻找init进程
                /sbin/init  这里是都有可能 最希望的地方
                /etc/init
                /bin/init
                /bin/sh
        分配ID：
            默认 内核将进程最大的ID设置为32768 int
            可以修改/proc/sys/kernel/pid_max
                分配的时候 按最大值加1分配 直到到pid_max再从头开始
        pid_t:
            进程ID的数据类型是pid_t <sys/type.h>    通常是int类型
        获取ID:
            <sys/type.h>
            <unistd.h>
            pid_t getpid(void); 返回进程ID
            pid_t getppid(void);    返回父进程ID
                这两个系统调用不会返回错误
    运行新的进程：
        exec系统调用：  直接取代当前进程的映像  继承某些属性：  pid 父进程的
                        pid 优先级  所属的用户 打开的文件描述符也  一般都会
                        关闭这些文件描述符
            <unistd.h>
            int execl(const char *path,const char *arg,...);
                    ...表示 可以加很多参数
            int ret;
            ret = execl("/bin/vi","vi","~/hhh",NULL);
            if(ret == -1)
                perror("execl");
                        vi  是第一个参数
                        ～/hhh  是第二个参数
                        NULL     表示结束参数
            int execlp(const char *file,
                        const char *arg,
                        ...);
            int execle(const char *path,
                        const char *arg,
                        ...,
                        char *const envp[]);
            int execv(const char *path,char *const argv[]);
            int execvp(const char *file,char *const argv[]);
            int execve(const char *filename,
                        char *const argv[],
                        char *const envp[]);
            l 表示参数使用列表  v表示参数使用数组
            p 表示使用绝对路径path下查找可执行文件  e表示提供新的环境变量
            使用这些调用 shell会产生安全漏洞    路径注入
                const char *args[]={"vi","/home/xiaolong/hhh",NULL};
                            这里也要使用NULL结尾
                int ret;
                ret = execv("/bin/vi",args);
                if(ret == -1)
                    perror("execv");
                在linux中 execve是唯一的系统调用 其他都是用这个封装的
            错误返回值：
                成功没有返回值      失败-1
                errno
                    E2BIG   参数过长
                    ELOOP   遇到太多的 符号链接
        fork系统调用：子进程和父进程基本一样
                    子进程pid 是新分配的
                    ppid。。。
                    子进程的资源统计信息为0
                    所有挂起的信号 清除 
                    所有文件锁也不会 被子进程继承
                写时复制：
                    以前时 每当一个子进程创建的时候就会复制 父进程的一份
                        给子进程 现在共享这一分 需要修改的时候再复制
            <sys/type.h>
            <unistd.h>
            pid_t fork(void);
                OK return 0     然后还会返回 子进程pid  
                出错-1
                pid_t pid;
                pid = fork();
                if(pid >0)
                    printf("I am the parent of pdi = %d\n",pdi);
                else if(!pid)
                    printf("I am the child");
                else if(pid == -1)
                    perror("fork");
    终止进程：
        <stdlib.h>
        void exit(int status);
            EXIT_SUCCESS    EXIT_FAILURE    定义成功和失败的两个宏
            可移植  linux 0 成功 1 -1失败
            成功退出：
            exit (EXIT_SUCCESS);
            在进程终止之前 c库会执行一下 关闭进程的步骤
                1 调用atexit（）或on_exit()注册的函数 和注册的顺序相反
                2 清空打开的文件
                3 删除tmpfile创建的文件
                4 调用 系统调用_exit();
                <unistd.h>
                void _exit(int status);
                这个函数 让内核做一下 清理:
                     分配的内存 打开de文件 System V的信号量 僵尸进程
                使用vfork创建的进程 必须_exit()
                <stdlib.h>
                void _Exit(int status);
        其他进程的终止方法：
            return      编译器会在 后面插入隐式的exit调用
            信号：      SIGTERM     SIGKILL
        atexit():
            <stdlib.h>
            int atexit(void (*function)(void));
                当进程exit终止的时候便会 调用这个注册的函数
                 使用的栈的形式注册的 执行顺序相反
                指定函数必须是无参数的没有返回值
                注册的最大值：  sysyconf(_SC_ATEXIT_MAX);
            OK 0  failed -1
     等待子进程终止：   
        父进程需要知道 子进程的状态
        wait():
            <sys/type.h>
            <sys/wait.h>
            pid_t wait(int *status);
            OK  返回终止进程的pid 错误-1 如果没有进程终止 阻塞
                errno：
                    ECHILD      没有子进程
                    EINTR       收到结束信号
            status参数的解释：
                宏定义：
                <sys/wait.h>
                int WIFEXITED(status);
                        正常结束返回 真
                int WIFSIGNALED(status);
                        如果信号导致结束 返回真
                int WIFSTOPPEN(status);
                        当进程 停止 返回真 
                int WIFCONTINUED(status);
                        进程继续执行的时候返回真
                int WEXITSTATUS(status);
                int WTEMSIG(status);
                        会返回导致进程结束的编号 
                int WSTOPSIG(status);
                int WCOREOUMP(status);
                    详见 function/program/wait.c
    等待特定进程：
            一个进程 一般有很多的子进程 所以。。。
            <sys/types.h>
            <sys/wait.h>
            pid_t waitpid(pid_t pid, int *status,int options);
                pid可以指定一个或多个pid
                    <-1
                        :等待一个进程组中的任何子进程退出 进程组pid=绝对值
                    -1
                        ：等待任何一个子进程退出    行为和wait一样
                    0
                        ：等待同一个进程组中的任何子进程
                    >0
                        ：等待pid等于pid的子进程
                options： 下面的一个 多个 或运算
                    WNOHANG：
                        不要阻塞 如果等待的进程没有停止立刻返回
                    WUNTRACED
                    WCONTINUED
                返回值：
                    成功时返回等待改变的进程的pid   如果设置了WNOHANG
                        进程还在 执行 返回0  错误 -1
                    errno：
                        ECHILD
        等待子进程的其他方法：
            waitid
                <sys/wait.h>
                int waitid(idtype_t idtype,
                            id_t id,
                            siginfo_t *info,
                            int options);
                    idtype:
                        P_PID
                        P_GID   等待进程组id是id的那些进程
                        P_ALL   等待所有子进程 参数id忽略
                    options:
                        WEXITED
                            调用进程会等待结束的子进程
                        WSTOPPED
                            调用进程会等待因收到信号而停止执行的子进程
                        WCONTINUED
                        WNOHANG
                        WNOWAIT
                    成功时 会填充infop参数
                        si_pid
                        si_uid
                        si_code 子进程的状态 分别为：
                            CLD_EXITED CLD_KILLED CLD_STOPPED  CLD_CONTINUED
                        si_signo    SIGCHLD
                        si_status
                    返回0 failed -1

        创建并等待新进程：
            #define _XOPEN_SOURCE
            <stdlib.h>
            int system(const char *command);
                执行command命令 把命令交给shell执行可以加参数
                和exec一样存在安全漏洞
            实现system：
                int my_system(const char *cmd)
                {
                    int status;
                    pid_t pid;

                    pid = fork();
                    if(pid == -1)
                        return -1;
                    else if(pid==0){
                        const char *argv[4];

                        argv[0]="sh";
                        argv[1]="-c";
                        argv[2]="cmd";
                        argv[3]="NULL";
                        execv("/bin/sh",argv);
                        exit(-1);
                    }
                    if(wait(pid,&status,0)==-1)
                        return -1;
                    else if(WIFEXITED(status))
                        return WEXITSTATUS(status);
                    return -1
                }
    用户和组：
        进程和用户关联：
            关联四个用户：
                实际用户 ：
                    运行这个程序的用户 子进程继承父进程
                有效用户：
                    如passwd进程 有效用户为root 用于权限认证的
                    一般进程的有效用户 就是实际用户
                保留用户：
                    一般也是 直接继承 有效用户
                文件系统用户：
                    文件的所有者
        改变实际用户/组ID 和保留用户的id
            <sys/types.h>
            <unistd.h>

            int setuid(uid_t uid);
            int setgid(gid_t gid);
                OK 0    failed -1
        改变有效用户ＩＤ或组ｉｄ
            <sys/types.h>
            <unistd.h>
            int seteuid(uid_t euid);
            int setegid(gid_t egid)
        获取用户ID和组ID
            实际用户
            <unistd.h>
            <sys/types.h>
            uid_t getuid(void);
            gid_t getgid();
            有效用户：
            <unistd.h> 
            <sys/types.h>
            uid_t geteuid();
            gid_t getegid();
    会话和进程组：
        每登陆一个终端 terminal 便打开一个会话
            会话由 一个或几个进程组 组成   会话id便是第一个 进程组的id
            进程组 一个或几个进程组成   进程组id是第一个进程的id
                    cat hh | more 便是一个进程组
                    可以对 进程组 同一个放松消息。。。。同一操作
        与会话相关的系统调用：
            <unistd.h>
            pid_t setsid(void);
                假设 当前不是会话的首进程 调用这个函数
                使用当前进程 创建一个会话 还会创建一个进程组
                成功时 返回会话 ID  失败　-1
        获得会话ID
            #define _XOPEN_SOURCE 500
            <unistd.h>
            pid_t getsid(pid_t pid);
        与进程组有关的系统调用：
            #define _XOPEN_SOURCE 500
            <unistd.h>
            int setpgid(pid_t pid,pid_t pgid);
                把pid的进程的进程组id设置为pgid
                为0 表示当前进程/组
            OK 0 failed -1
        获得进程的进程组id
            #define _XOPEN_SOURCE 500
            <unistd.h>
            pid_t getpgid(pid_t pid);
    守护进程：
            守护进程运行在 后台 不与任何 终端关联
            一般都是 d结尾的
            守护进程创建过程：
                1 调用fork 创建新的进程 这个进程将会成为守护进程
                2 在守护进程的父进程中调用exit
                    保证了守护进程不是首进程
                3 调用setsid  创建一个新的会话
                4 调用chdir 改变为根目录 守护进程继承了父进程的。。
                5 关闭文件描述符
                6 打开文件描述符 1 2 0 重定向到/dev/null
                详见：function/program/daemon.c
            c库
            <unistd.h>
            int daemon(int nochdir,int noclose);
            OK 0 failed -1

高级进程管理：
    进程调度器：
        是内核的一个组件 负责分配cpu给进程使用  抢占式 linux
        当一个程序在执行的时候可以 抢占 

        进程可以分为 cpu约束型和IO约束型    
            依据是 进程的时间花在了哪里 
    调度算法：
        抢占式调度：
            每个进程分配一个时间片 当一个进程的时间片用的话 内核会挂起
            执行下一个 就绪进程 直到所有进程执行了一遍 从新分配时间片
            优先级高的先执行 当时间片没了挂起
        完全公平调度：
            每个进程 在固定时间的占得比例来分   优先级越高比例越大
            固定时间 成为延迟时间 一般为20ms
                最小颗粒： 如果一个进程的所得时间比最小可以还小
                这运行这个进程 最小颗粒的时间
    让出处理器;
            <sched.h>
            int sched_vield(void);
                OK 0 failed -1
    进程优先级：
        范围（-20,19]默认是0
        nice()
            <unistd.h>
            int nice(int inc);
                将当前进程+inc  只有用户CAP_SYS_NICE权限的人才可使inc负值
                也就是roo权限
            返回进程设置后的大小 优先级
            Failed -1  返回也可以返回-1  所以事先 将errno清零
                int ret ;
                errno = 0;
                ret = nice(10);
                if(ret == -1&&errno!=0)
                    perror("nice");
                else
                    printf("nice value is %d",ret);
                errno:
                    EPERM   进程没有权限提高优先级
        getpriority() setpriority()
            <sys/time.h>
            <sys/resource>

            int getpriority(int which,int who);
                failed -1  所以也要判断是否是-1 errno清零
            int setpriority(int which, int who ,int prio);
                OK 0 failed -1
                which指定那种类型：
                    PRIO_PROCESS
                    PRIO_PGRP
                    PRIO_USER
                who：指定那个
                    进程id 进程组id 用户id
                    0表示当前的
                prio:    优先级 root权限
        IO优先级：
            一般IO优先级是和进程优先级关联的 进程优先级越高 IO越高
            可以改变：
                int ioprio_get(int which,int who);
                int ioprio_set(int which,int who,intioprio);
    处理器亲和力：
        多核cpu而言的
        每个cpu控制的内存不同 当一个程序在一个 cpu上运行的时候
        一个进程一直在一个cpu上运行的可能性 为亲和力
        
        sched_getaffinity() sched_setaffinty()
        #define _GUN_SOURCE

        typedef struct cpu_set_t;
        size_t CPU_SETSIZE;
        void CUP_SET(unsigned long cpu,cpu_set_t *set);
        void CUP_CLR(unsigned long cpu,cpu_set_t *set);
        void CUP_ISSET(unsigned long cpu,cpu_set_t *set);
        void CUP_ZERO(cpu_set_t *set);

        int sched_setaffinty(pid_t pid,size_t setsize,
                            const cpu_set_t *set);
        int sched_getaffinity(pid_t pid,size_t setsize,
                            cpu_set_t *set);
                ................
    实时系统：
        硬实时系统和软实时系统：
            硬： 军用武器
            软： 视频处理
        linux实时系统的支持 调度策略：
            每一个进程都有一个静态的优先级 和 nice value值无关
            对于普通的应用 其值为0 对于实时应用 其值为1～99
            linux调度器总之寻找 静态值高的进程先执行 直接抢占 
            当有duo个进程的静态值一样的时候 便有一下调度算法：
                轮询策略：每个一定的时间片执行
                普通调度算法：
                批调度算法；

            设置linux调度策略：
                <sched.h>
                struct sched_param{
                    int sched_priority;

                };
                int sched_getscheduler(pid_t pid);
                int sched_setscheduler(pid_t pid,
                                        int policy,
                                        const struct sched_param *sp);
                policy:
                    SCHED_FIFO
                            先进先出
                    SCHED_RR
                            轮询策略
                    SCHED_OTHER
                            普通策略
        设置调度参数：
            <sched.h> 
            struct sched_param{
                int sched_priority;
            };

            int sched_getparam(pid_t pid,struct sched_param *sp);
            int sched_setparam(pid_t pid,const struct sched_param *sp);
        确定每种算法的优先级范围：
            <sched.h>
            int sched_get_priority_min(int policy);
            int sched_get_priority_max(int policy);
        指定轮询策略的时间片时间大小：
            <sched.h>
            struct timespec{
                time_t tv_sec;
                long    tv_nsec;
            };
            int sched_rr_get_interval(pid_t pid,struct timespec *tp);
    资源限制：
        linux内核对进程有资源限制   明确规定了内存的上限 打开文件的上限
        获取和设置限制：
            <sys/time.h>
            <sys/resource.h>
            struct rlimit{
            rlim_t rlim_cur;//软限制
            rlim_t rlim_max;//硬限制
            };

            int getrlimit(int resource,struct rlimit *rlim);
            int setrlimit(int resource,const struct rlimit *rlim);
                不具有root权限 只能调低硬限制  软限制可以调0到应限制之间
            限制项：
                RLIMIT_AS
                    地址空间的上限值
                RLIMIT_CORE
                    core文件大小的最大值
                RLIMIT_CPU
                    进程使用cpu的时间限制
                RLIMIT_DATA
                    进程数据段和堆的大小  字节
                RLIMIT_FSIZE
                    文件可以创建的最大值 字节
                RLIMIT_LOCKS
                    进程可以拥有的最大锁的数量
                RLIMIT_MEMLOCK
                    最多可以锁定多少内存字节
                RLIMIT_MSGQUEU
                    可以在消息队列中分配多少字节
                RLIMIT_NICE
                    进程可以降低的最大值
                RLIMIT_NOFILE
                RLIMIT_NPROC
                    指定用户在任意时刻 可以运行最大的进程数
                RLIMIT_RSS
                    指定进程可以在内存中流的最大页数
                RLIMIT_RTIME
                    一个实时进程可以最多使用cpu时间
                RLIMIT_RTPRIO
                RLIMIT_SIGPENDING
                    指定用户消息队列中共最多信号数
                RLIMIT_STACK
                    指定栈的最大字节长度    RLIM_INFINITY
            默认限制值：
                。。。。。。
            内核会在init中设置这些值 后面的进程便会 继承
