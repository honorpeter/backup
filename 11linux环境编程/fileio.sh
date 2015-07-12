概述：
    每个进程打开的文件是用上限的默认是1024 可以修改最大是1048567
    自进程会 复制父进程打开文件的列表 以及所在的文件位置
        子进程打开或关闭一个文件时 不影响父进程

打开文件：
    系统调用：
        <sys/type.h>
        <sys/stat.h>
        <fcntl.h>
        int open(const char *name, int flags);
        int open(const char *name,int flags, mode_t mode);
            成功返回文件描述符 失败-1  并设置相应的errno值
        flags参数： 
            O_RDONLY    O_WRONLY    O_RDWR 三种模式
            还以使用这三个模式和下面的几种模式 |
            O_APPEND    追加
            O_ASYNC     当指定文件可读可写的时候 产生一个信号默认 SIGIO
                            该标记不适用于不同的文件 其他文件可以
            O_CREAT     当name不存在的时候直接创建
            O_TRUNC      对于普通文件 如果存在 且有写权限 将文件截断为0
            O_NONBLOCK  非阻塞模式打开
            O_SYNC

            .。。。
    新建文件的所有者：
        新建文件的所有是 进程的有效uid
        所属组 是进程的有效uid所在的组
    新建文件的权限：
        mode：
            S_IRWXU     文件所有者  可读可写可执行
            S_IRUSR                 可读
            S_IWUSR                 WRITE
            S_IXUSR                 EXEC

            S_IRWXG     文件所属组  
            S_RGRP                  READ
            ....
            S_IRWXO     OTHER
            SIROTH                  READ
            .....
            这可mode可以 | 
            最终写入磁盘时文件的属性 是mode和umask与作用
            也可以在mode处直接写入数字
                int fd;
                fd = open("/hh",O_WRONLY | O_CREAT, 0664);
                if(fd==)
                    perror(....);
    creat()函数：
        <sys/type.h>
        <sys/stat.h>
        <fcntl.h>
        int creat(char const *name, mode_t mode);
            实现方式
                fd = open("/hh",O_WRONLY | O_CREAT | O_TRUNC, 0664);
    read()函数：
        <unistd.h>
            类型size_t       在32位系统 unsigned int
            ssize_t             32      int
        ssize_t read(int fd,void *buf, size_t len);
            成功时返回 读取字节数 失败-1
                unsigned long word;
                ssize_t nr;
                nr = read( fd, &word, sizeof(unsigned long));
            返回值：
                有很多错误情况；
                返回值 = len   正常
                0 < 返回值 < len    
                     文件中的字符 小于len   提前到达EOF
                返回值=0
                    1 表示EOF没有更多的读取数据
                    2 由于当前没有数据 zhu塞了  如网络 管道
                        可设置非zhu塞模式 不会发生这种情况
                返回值=-1
                    1 并把 errno设置成EINTR 表示在读取任何字节之前收到
                        信号 系统调用可以重新执行
                    2 并把errno设置 EAGAIN 表示当前没有数据 读取会
                        阻塞 请稍后再试 发生在非阻塞模式
                    3 把errno 设置 非上面的两个 表示严重错误 不会成功
                    其他错误代码：
                    errno = EBADF
                        给定的文件描述符非法 或 不是一个可读模式打开
                    FFAULT
                        buf指针不在调用的进程的地址空间
                    EINVAL
                        对象不允许读
                    EIO
                        底层io错误
            读取所有字节：
                ssize_t ret;
                while(len != 0 && (ret =read(fd,buf,len))!=0){
                    if(ret == -1){
                        if(errno == EINTR)
                            continue;
                        perror("read");
                        break;
                    }
                    len -= ret;
                    buf += ret;
                }
            非阻塞模式读取：
                char buf[BUFSIZ];
                ssize_t nr;

                start:
                    nr = read(fd , buf, BUFSIZ);
                    if(nr==-1){
                        if(errno == EINTR)
                            goto start;
                        if(errno == EAGAIN)
                            // resubmit later
                        else
                            // erro
                    }

    调用write
        <unistd.h>
        ssize_t write (int fd, const void *buf, size_t count)
                count字节数
            简单用法：
                const char *buf = "My ship is solid";
                ssize_t nr;
                nr = write(fd, buf, strlen(buf));
                if(nr == -1){
                    //error
                }
            复杂：检查各种错误：
                unsigned long word = 1720;
                size_t count;
                ssize_t nr;
                count = sizeof(word);
                nr = write(fd, &word,conut);
                if(nr==-1){
                    //errorfj
                }
                else if(nr!=count)
                    //possible error
            部分写：
                对于write来说一般 不会出现部分写 但是对于socket这类的
                文件 能会出现
                ssize_t ret, nr;
                while(len!=0 && (ret =write(fd,buf,len))!=0){
                    if(ret == -1){
                        if(errno==EINTR)
                            continue;
                            perror("write");
                            break;
                    }
                    len -=ret;
                    buf+=ret;

                }
    Append模式：
        当open函数 O_APPEND这个参数的时候 从文件 尾部开始读写
        对于写操作 内核会做很多事情。。。  延迟写 写操作 之后 内核不会立刻
            就写 它要做一些 优化 再写入   同步IO可以改变这种行为
同步IO
        fsync() fdatasync()
        <unistd.h>
        int fsync(int fd);
            将fd指向的脏数据 写到磁盘上
            文件必须以写的方式打开
            还会修改 数据的属性 创建的时间 。。。
        int fdatasync(int fd);
            一般 只把data写入磁盘 和 文件的大小 不会去修改一些其他的。。。
        返回值 和错误代码
            成功是返回0 失败是返回-1    并设置errno
                EBADF
                    不是以写的方式打开
                EINVAL
                    文件不支持同步
                EIO 
                    。。、
        在POSIX标准中 fsync是必须的 fdatasync是可选的
    O_SYNC标志位
        该文件的所有操作 都要 同步
        以后 每执行一次write变进行 同步 不会出现延迟写
            但这样 会带来很大的时间消耗
    O_DSYNC O_RSYNC
        O_DSYNC
            只同步 普通数据 不同步元数据
        O_RSYNC  在linux上和fsync函数一样
直接IO
        设置O_DIRECT    操作系统 不会进行缓冲。。。。
            一般数据库 需要这样做
关闭文件：
    <unistd.h>
    int close(int fd);
        失败-1  成功0
        fd文件描述失效
用lseek()查找
    <sys/types.h>
    <unistd.h>
    off_t lseek(int fd,off_t pos,int origin);
        origin:
            SEEK_CUR    
            SEEK_END
            SEEK_SET
        off_t 一般是 long
            linux 内核内部是 longlong
        例：
            off_t ret;
            ret= lseek(fd, (off_t)1825,SEEK_SET);
            if(ret == (off_t)-1)
                //error
        lseek支持在文件 之后进行查找
            int ret;
            ret = lseek(fd,(off_t)1688,SEEK_END)
            if(ret == (off_t)-1)
                //error
                文件尾部和指向的位置之间 会用0填充
    success 返回所在位置
        失败 -1；   errno
           EBADF
           EINVAL    参数有文件
           EOVERFLOW
                结果文件偏移 不能通过off_t表示
            ESPIPE
                不支持查找
定位读写：
        read write的变体
    #define _XOPEN_SOURCE 500
    <unistd.h>
        ssize_t pread(int fd, void *buf ,size_t count, off_t pos);
            从偏移pos的位置开始读取
        ssize_t write(int fd, const char *buf,size_t count, off_t pos);
            当他们调用完成的时候 不会更新指针的位置 还是处于开头
            read write也不会更新文件位置 但是当他们使用lseek并交替调用的
                时候会出现问题 还会出现进程之间的竞争
        出错吗：    和read write lseek一样
文件截短：
    <unistd.h>
    <sys/types.h>
    int ftruncate(int fd, off_t len);
    int truncate(const char *path,off_t len);
        把文件截成len长度
        失败-1 
IO多路复用：
    当进行读写操作的时候 如果是用的阻塞 如果当一个文件 一直没有数据
        那么进程在一直等待。。。。。所以有了IO多路复用
        作用：
            当任何一个文件就绪的时 通知
            没有可用的 一直处于 睡眠状态
            。。。
    select()    poll()  epoll()
    <sys/select.h>
    int select(
                int n,      //所有集合中最大文件描述符 +1
                fd_set *readfds,
                fd_set *writefds,
                fd_set *exceptfds,
                struct timeval *timeout);
                在给定的文件描述符 IO就绪之前并且还没有超出指定时间限制
                select就会阻塞
                集合是一个设置的变量
                fd_set readfds;
                fd_set writefds;
    FD_CLR(int fd, fd_set *set)
    FD_ISSET(int fd, fd_set *set);
        判断文件 是否存在集合中 
    FD_SET(int fd, fd_set *set);
        将一个文件添加到集合
    FD_ZERO(fd_set *set);
        将集合请0
    返回： 
        失败返回 -1  
            EBADF
            EINTR
            EINVAL  参数非法
            ENOMEN
                没有足够的内存
        如果时间超时返回 非0 
        其他  。。 会把可用的文件描述放在集合中  不可用的去除

        <sys/time.h>
        struct timeval{
            long tv_sec;
            long tv_usec;
        };
    
    POSIX:  pselect()
        #define _XOPEN_SOURCE 600
            <sys/select.h>
        int pselect(
                    int n,
                    fd_set *readfds ,
                    fd_set *writefds ,
                    fd_set *exceptfds,
                    const struct timespec *timeout,
                    const sigset_t *sigmask);
                    FD_CLR(int fd, fd_set *set)
                    FD_ISSET(int fd, fd_set *set);
                        判断文件 是否存在集合中 
                    FD_SET(int fd, fd_set *set);
                        将一个文件添加到集合
                    FD_ZERO(fd_set *set);
                        将集合请0
        <sys/time.h>
        struct timespec{
            long tv_sec;
            long tv_nsec;
        };
        区别：
            当超时返回时 不会修改time的值
            多了sigmask  解决信号问题
    poll（）
        <poll.h>
        int poll(struct pollfd *fd,nfds_t nfds,int timeout);
        <poll.h>
        struct pollfd{
            int fd;
            short events;
            short revents;
        }
            events是要监听文件描述符的位掩码
                POLLIN
                    有数据可读
                POLLRDNORM
                    有普通数据可读
                POLLRDBAND
                    有 优先数据可读
                POLLPRI
                    有 高级优先数据可读
                POLLOUT
                    写操作不会阻塞
                POLLWRNOTM 
                    普通写数据不会阻塞
                POLLBAND
                    写优先数据不会阻塞
                POLLMSG
                    消息可用
            revents变量可能返回 一下：
                POLLER
                    文件描述符 错误
                POLLHUP
                    给定的文件有挂起事件
                POLLNVAL    
                    文件描述符 非法
            timeout 负数表示 永远等待
        例：
            #include<stdio.h> 
            #include<unistd.h>
            #include<poll.h>

            #define TIMEOUT 4
            int main (){
                struct pllfd fds[2];
                int ret;

                //watch stdin for input
                fds[0].fd =STDIN_FILENO;
                fds[0].events=POLLIN;
                //watch stdout ablity to write
                fds[1]=STDOUT_FILENO;
                fds[1].events = POLLOUT;

                ret = poll(fds,2,TIMEOUT*1000);
                if(ret==-1){
                    perror("poll");
                    return 1;
                }
                if(!ret){
                    printf("%d seconds ",TIMEOUT);
                    return 0;
                }
                if(fds[0].revents & POLLIN){
                    printf("stdin is read");
                }
                if(fds[1].revents & POLLOUT)
                    printf("stdout si ok");
            return 0;
            }
    ppoll.....linux 特有的
    unix 不支持poll

缓冲IO  
        实际上 操作系统 每次都是读取几块为单位的进行读取
        如果用户每次 只是 使用一个字节 效率很低  
            读取是以块为单位的
    用户缓冲IO 不是内核
        块大小：
            一般是512字节 1024字节 整数倍。。。。
                这样可以保证 块对齐  因为一般内核和块设备交互的单位是块
    标准IO
        c语言提供了标准的IO库 实现了IO跨平台的缓冲方案
            详见 c和指针 文件操作函数

高级文件IO
    分散 聚集IO     
        可以从多个地址 读取数据写到同一个数据流
        也可以从一个数据流的内容写到多个缓冲区
        也可以成为向量IO 前面的成为线性IO
        实际上linux 内核实现的向量模型 线性IO只是段为1而已
    readv() writev()
        <sys/uio.h>
        ssize_t readv (int fd,
                        const struct iovec *iov,
                        int count);
                从文件描述符fd中读取conut个段的数据到 到iov指定的缓冲区
         ssize_t writev(int fd,
                        const struct iovec *iov,
                        conut);
                把多个缓冲区的内容写到 fd的文件描述符中
            结构体：
                struct iovec{
                    void *iov_base;//缓冲区的地址
                    size_t iov_len;//缓冲区的长度
                };
                    一个这样的结构体 成为段
                    一组段的集合成为 向量
        返回值：
            成功返回：
                字节数 count个段字节之和
                失败-1  设置errno的值  基本和read和write差不多
                count值必须大于0 小于IOV_MAX(<limit.h>) 
                    linux中IOV_MAX=1024
            例：详见    function/gaojiwenjianIO
    Event Epoll
        因为select poll的缺点 从而创建了这个函数
            当select poll监听的文件多了的时候 每次都要遍历所有的文件
             效率很低 所以有 epoll
        三部分组成：
            epoll_create1       创建epoll实例
            epoll_ctr           控制epoll实例
            epoll_wait          等待epoll事件

        <sys/epoll.h>
        int epoll_create1(int flags);
            flags:      只有EPOLL_CLOEXEC可用 表示进程替换时关闭文件描述符
            成功返回：实例
            失败 -1         设置errno
                EINTR 
                EMFILE
                    用户打开的文件数达到上限
                ENFILE
                    系统打开的文件数达到上限
                ENMEM
                    epoll_create()是linux的老版本 现在已经废弃
        控制：
            <sys/epoll.h>
            int epoll_ctr(
                            int epfd,
                            int op,
                            int fd,
                            struct epoll_event *event);

            <sys/epoll.h>
            struct epoll_event{
                _u32 events;
                union{
                    void *ptr;
                    int fd;
                    _u32 u32;
                    _u64 u64;
                }data;
            };
            
            op:
                EPOLL_CTL_ADD
                EPOLL_CTL_MOD
                EPOLL_CTL_DEL
            event事件 可以 使用 或运算
                EPOLLERR
                        文件出错 默认监听
                EPOLLET
                        边缘触发默认是条件触发
                EPOLLHUP
                        文件被挂起 默认监听
                EPOLLIN
                        文件未阻塞 可读
                EPOLLONESHOT
                        。。。
                EPOLLOUT    
                        文件可写
                EPOLLPRI
            当成功时 返回0 失败-1 设置errno
                EBADF
                    epoll不是有效的实例
                EEXIST
                    以存在
                EINVAL
                ENOENT
                        设置为修改 删除 但是 epoll每个和fd关联
            例：    在实例epfd添加一个fd文件
                struct epoll_event event;
                int ret;

                event.data.fd = fd;
                event.enents=EPOLLIN | EPOLLOUT;

                ret = epoll_ctr(epfd,EPOLL_CTL_ADD,fd,&event);
                if(!ret)
                    perror("epoll_ctl");

                modify..
                struct epoll_event event;
                int ret;

                event.data.fd = fd;
                event.enents=EPOLLIN ;

                ret = epoll_ctr(epfd,EPOLL_CTL_ADD,fd,&event);
                if(!ret)
                    perror("epoll_ctl");

                del...
                struct epoll_event event;
                int ret;

                ret = epoll_ctr(epfd,EPOLL_CTL_ADD,fd,&event);
                if(!ret)
                    perror("epoll_ctl");
        等待epoll事件：
            <sys/epoll.h>
            int epoll_wait(
                            int epfd,
                            struct opoll_event *events,
                            int maxevents;
                            int timeout);
                            timeout 为毫秒
            等待epoll实例中epfd中 文件fd上的事件    实现为timeout
            成功时 events指向 描述每个事件的epoll_event 结构体的内存 
            且最多可以有maxevents个事件 返回是事件数 失败-1
             errno：
                EBADF
                FAULT   进程对events指向的内存没有写权限
                。。。
            timeout -1  永远
            例：
                #define MAX_EVENTS 64
                struct epoll_event *events;
                int nr_events,i,epfd;
                events = malloc(sizeof(struct epoll_event)*MAX_EVENTS);
                if(!NULL){
                    perror("malloc");
                    return 1;
                }

                nr_events = epoll_wait(epfd,events,MAX_EVENTS,-1);
                if(nr_events <0){
                    perror("epoll_wait");
                    free(events);
                    return 1;
                }
                for(i=0,i<nr_events,i++){
                    printf("event=%ld on fd=%d\n",
                            events[i].events,
                            events[i].data.fd);
                }

        边缘触发事件： 是状态改变 便触发
        条件触发事件： 满足某个条件
    储存映射：
        <sys/nman.h>
        void *mmap(void *addr,
                    size_t len,
                    int prot,
                    int flags,
                    int fd,
                    off_t offset);
                请求内核将 文件描述符fd所指向的对象的len个字节 数据映射到
                内存中 起始位置从offset开始 如果指定了addr 表示优先使用
                addr作为内存中的起始位置
            prot：
                PROT_READ
                PROT_WRITE
                PROR_EXEC   可执行
                这个参数的设置 不能和open打开的参数 冲突
            flags：
                MAP_FIXED
                    必须使用addr作为起始地址
                MAP_PRIVATE
                    映射区 不共享  写时复制  进程对内存的修改不改变 文件
                MAP_SHARED
                    和其他进程 共享映射区   对内存的些操作 相当于写文件
            内存空间 示意图：
                进程地址空间

                环境变量

                栈

                映射文件

                堆

                以符合数据开头的块              bss区也是要先指定
                （BSS）

                文本区
            页大小：
                mmap系统调用的操作 单元是页 参数addr offset 必须按页大小
                    对齐
            获取页大小：
            <unistd.h>
                long sysconf(int name); 获取系统配置项 失败-1
                POSIX 定义 _SC_PAGESIZE 表示页大小
                long page_size = sysconf(_SC_PAGESIZE);
            linux提供了 getpagesize（）函数获得
                int getpagesize(void);
            也大小是由<arm/pages.h>定义的宏 PAGE_SIZE定义的
                int page_size = PAGE_SIZE;
        返回值和错误代码：
            成功返回 地址 失败返回MAP_FAILED
                errno 
            EACESS  指定的文件描述符不是普通文件 或则打开模式和prot 冲突
            EBADF
            ENFILE  打开文件达到系统上限
            EOVERFLOW   参数addr+len结果超过了地址空间
        相关信号：
            SIGBUS  当进程试图访问 一块已经失效的映射区域
            SIGSEGV 当进程 写一块只读的内存
        munmap() 取消mmap所创建的映射
            <sys/mman.h>
            int munmap(void *addr,size_t len);
            从addr地址开始的len长的映射
            失败-1 成功0
            详见： function/gaojiwenjianIO/map.c
        优点：
            不需要从用户缓冲区 读取数据 减少拷贝
            直接操作内存一样简单
            在映射对象中 只需要使用指针变可以操作 还可以多个进程 共享
        不足：
            映射区域 必须是页的整数倍
     调整页的大小：
        mremap()linux特有的
        #define _GUN_SOURCE 
        <sys/mman.h>
        void *mremap(void *addr,size_t old_size,size_t new_size,
                        unsigned long flags);
                将映射的区域[addr,addr+old_size)增加或扩大为new_size大小
                flags可以是0 或MREMAP_MAYMOVE内核 更具需要移动
        返回值 错误码：
            errno：
                EAGEIN  内存区域锁定不能重新调整大小
      改变映射的权限：
        <sys/mman.h>     
        int mprotect(const void *addr
                    size_t len,
                    int prot);
                    改变[addr,addr+len]权限
                失败-1 成功0
     通过映射同步文件：
        <sys/mman.h>
        int msync(void *addr,size_t len, int flags);
            将内存修改过的数据写会到内存  先修改内核缓冲区 再写回磁盘
            flags
                MS_SYNC
                    直到所有的页都写会到磁盘中 msync才返回
                MS_ASYNC
                    同步异步执行 立刻返回 
                这两个必须指定一个 仅一个
        返回值 错误码
            成功0 失败-1 errno：
      给出映射提示：
        即使不给提示 内核也会 选择最好的方式 执行 给提示之后 更好
        <sys/mman.h>
        int madvise(void *addr,
                    size_t len,
                    int advice);
                advice:
                    MADV_NORMAL     normal
                            linux不做处理
                    MADV_RANDOM     read random
                            linux不做预读 每次读取最小量的数据
                    MADV_SEQUENTIAL 应用从低到高读取
                            linux 做大量预读
                    MADV_WILLNEBD   应用期望访问指定范围的页
                            linux开始预读
                    MADV_DONTEED    应用在短期内不会访问
            返回值：错误码
                ok 0 失败-1

    普通文件IO提示：
        <fcntl.h>
        int posix_fadvise(int fd,
                            off_t offset,
                            off_t len,
                            int advice);
                和madvise类似
                POSIXFADV_NORMAL
                POSIX_FADV_SEQUENTIAL
                POSIX_FADV_WILLNEED
                POSIX_FADV_NOREUSE
                POSIX_FADV_DONTNEED     

    IO调度器功能
        合并 和 排序 让磁盘的读写速度加快
        1 哪一个文件 距离磁头最近 先写哪个  这样会有饿死现象
        2 Deadline IO调度器
            通过 最近排序 一个队列  每个还设置一个时间
            一旦时间到了 就写这个
        3 AnticipatoryIO 调度器
            针对 一个应用写 的  等待6ms秒 这样不用在寻址
        4 CFO
            每个进程都有一个列队 当处理完一个列队的时候等待10ms 没有下一个
        5 NOOp
            对 固态驱动器用的 
        选择和配置你的IO调度器
            内核命令参数iosched来指定默认的  as cfq deadline noop
            修改文件 /sys/block/device/queue/scheduler
        优化IO性能：
            按inode排序：
            得到inode
                int get_inode(int fd)
                {
                    struct stat buf;
                    int ret;
                    ret = fstat(fd,&buf);
                    if(ret<0){
                        perror("fstat");
                        return -1;
                    }
                    return buf.st_ino;

                }
            按物理块排序： 详见 function/gaojiwenjianIO/wuli.c
