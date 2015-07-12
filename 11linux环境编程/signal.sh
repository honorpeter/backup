信号：
        信号是一种软件中断
        具有声明周期：
            产生信号
            内核存储信号
                一旦有空闲 内核就会处理信号：
                    1   忽略信号
                        但SIGKILL   SIGSTOP不可忽略
                    2   捕获并处理信号 
                        内核会停止 正在执行的代码 跳转到先前注册过的 函数
                    3   执行信号默认的操作
        信号表识符：
            在  signal.h中定义的
            linux支持的信号：
                
                SIGABRT
                        abort函数将信号发送给它调用的进程 然后终止程序
                        并产生一个内核转存文件 linux assert为假调用这个函数
                SIGALRM
                        函数在报警信号超时 时调用它
                SIGBUS
                        当进程发生了 出内存保护的外的硬件错误产生
                SIGCHLD
                        当进程终止 或 停止的时候 发送给父进程   默认忽略
                        不过可以使用wait
                SIGCONT
                        当进程 停止 又恢复执行的时候 默认忽略
                SIGFPE
                        所有算数异常
                SIGHUP
                        当会话终端断开时 内核会该会话首进程发送这个信号
                        前台进程也会发送     默认终止进程
                SIGILL
                        当进程试图执行一条非法机械指令时 内核会发送 
                        默认终止进程 
                SIGINT
                        当用户输入中断符 一般ctrl+c 默认终止
                SIGIO
                        当一个BSD风格的IO事件发生时
                SIGKILL
                        kill系统调用发出的 结果总是 终止进程
                SIGPIPE
                        当一个进程向一个管道里面写 但管道已经终止了 就会发送
                SIGPROF
                        超时 默认终止     
                SIGWR
                        低电量的条件    断电
                SIGQUIT
                        当用户输入终端退出符的时候 
                SIGSEGV
                        当进行非法访问的时候 段错误 默认终止进程      
                SIGSTKFLT
                        
                SIGSTOP
                        只有kill发出 无条件 停止一个进程     
                SIGSYS
                        调用一个无效的系统调用的时候
                SIGTERM
                        只有kill发出 它允许用户优雅的终止进行 
                        可以清理一下文件
                SIGTRAP
                        当进程通过一个断点时
                SIGSTP
                        当用户数据挂起符时  ctrl+z
                SIGTTIN
                        当一个后台进程 试图从她控制的终端读取数据时 默认停止
                SIGTTOU
                        当一个后台进程。。。。。。。。。。写。。。。。。
                SIGURG
                        当带外数据 抵达套接字
                SIGUSR1
                    
                SIGUSR2
                        这写信号是给用户自定义的    默认终止
                SIGVTARM
                        定时器 
                SIGWINCH
                        当终端窗口大小改变时
                SIGXCPU
                        当进程超过其 软处理器限制时 内核会一秒一次持续发送
                            信号 一旦超过 硬限制 直接结束
                SIGXFSZ
                        当进程超过他的文件大小限制 默认终止
    基本信号管理：
            <signal.h>
            typedef void(*sighandler_t)(int);
            sighandler_t signal(int signo, sighandler_t handler);
                signo的处理函数 handler
        等待信号：
            <unistd.h>
            int pause(void);
                只有在接收到可捕获的信号时 才返回
                例 function/signal/sigal.c
        执行和继承：
            fork() 子进程会继承父进程的所有信号处理 不会继承父进程挂起的信号
            exec()  新进程中所有的信号恢复默认  会继承挂起的信号

        把信号编号映射为字符串
            extern const char *const sys_siglist[];
                sys_siglist是一个保存系统支持的信号名称字符串数组 可以使用
                    信号编号进行索引
            <signal.h>
            void psignal(int signo,const char *msg);

            #define _GUN_SOURCE
            <string.h>
            char *strsignal(int signo);
                返回一个指针 指向signo指定的信号

            例：
                static void signal_handler(int signo)
                {
                    printf("caught %s",sys_siglist[signo]);
                }
        发送信号：
            <sys/types.h>
            <signal.h>
                int kill(pid_t pid, int signo);
                pid > 0  就是给pid的进程发送信号
                pid = 0 会给调用进程的进程组中的每个进程发送洗好
                pid = -1 会发给进行 有权限发送进程的进程
                pdi 《 -1   发送给进程组
                OK 0    failed -1
            还可以通过raise给自己发送信号
                int raise (int signo);
            给进程组发送信号：
                还可以使用 
                int killpg(int pgrp,int signo); pgrp是整数
    重入：
            程序和信号处理函数 左这同样的时间 会很麻烦。。。。
        确保可重入的函数：
            POSIX定义了很多 系统调用函数 可以重入 不会发生意外
    信号集：
        <signal.h>
        int sigemptyset(sigset_t *set);
            初始化  空 
        int sigfillset(sigset_t *set);
            初始化 全部信号都有
        int sigaddset(sigset_t *set,int signo);
        int sigdelset(sigset_t *set,int signo);
        int sigismember(const sigset_t *set,int signo);
    更多的信号集函数：
            #define _GUN_SOURCE
            <signal.h>

            int sigisemptyset(sigset_t *set);
                如果信号集为空 返回 1 or 0
            int sigorset(sigset_t *dest,sigset_t *left,sigset_t *right);
                并
            int sigandset(sigset_t *dest,sigset_t *left,sigset_t *right);
                和
        阻塞信号：
            <signal.h>
            int sigprocmask(int how,
                            const sigset_t *set,
                            sigset_t *oldset);
                how:
                    SIG_SETMASK
                        将调用进程的信号掩码编程set
                    SIG_BLOCK
                        set中的信号 加入到进程的信号掩码中 和集
                    SIG_UNBLOCK
                        去除set
        获取等待信号：
             <signal.h>
             int sigpending(sigset_t *set);
             成功 时 将会把set设置为待处理的信号集 返回0 失败-1
        等待信号集：
            <signal.h>
            int sigsuspend(const sigset_t *set);
    高级信号管理：
            sigaction()提供了强大的信号管理。。。
        <signal.h>
        int sigacton(int signo,
                        const struct sigaction *act,
                        struct sigaction *oldact);
                    struct sigaction{
                        void (*sa_handler)(int);//signal hander or action
                                该信号处理函数
                        void (*sa_sigaction)(int ,siginfo_t *,void);
                        sigset_t sa_mask;   //signals to block
                        int sa_flags;   
                        void (*sa_restorer)(void);
                    };

                flags：
                    SA_NOCLDSTOP
                        如果signo是SIGCHLD 。。。
                    SA_NOCLDWAIT
                        如果signo是SIGCHLD 。。。
                    SA_ONSTACK
                        ...
                    SA_RESTART
                    SA_SIGINFO
                        使用sigaction作为操作函数
            结构体：
                typedef struct siginfo_t{
                    int si_signo;   
                    int si_errno;    //errno value
                    int si_code;    //signal code
                    pid_t si_pid;   //sending process's pid
                    uid_t si_uid;   //sending process's real uid
                    int si_status;  //exit value or signal
                    clock_t si_utime;
                    clock_t si_stime;
                    sigval_t si_value;
                    int si_int;
                    void *si_ptr;
                    void *si_addr;
                    int si_bang;
                    int si_fd;
                };
                si_code:
                    SI_ASYNCIO
                    SI_KERNEL
                    SI_MESGQ
                    SI_QUEUE
                    SI_TIMER
                    SI_TKILL
                    .......
                    ...
    发送附加信息的信号：
            <signal.h>
            int sigqueue(pid_t pid,
                            int signo,
                            const union sigval value);
                成功时 添加到 进程 信号列队中
                    union sigval{
                         int sival_int;
                         void *sival_ptr;
                    };
        

