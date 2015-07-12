线程：
        进程拥有独立的内存和cpu 但线程共享内存 拥有独立的cpu
        线程是程序员可以操作的单个单元  把进程分为的几个独立的部分
        因而要考虑 多个线程之间的 互斥 同步 与 死锁。。。。。
        操作系统设计者要考虑 进程之间的 互斥 同步 与 死锁。。。。
    线程模型：
        内核模型： 1 : 1每个内核线程直接转化为用户的空间的线程
        用户模型： N： 1每n个用户空间的线程只会映射到一个内核进程
        混合模型： N：M
        系统程序：。。。。
    线程模式：
        就是一般是怎么使用线程的 使用模式
        1 每个链接对应一个线程
            一般设置线程的最多可以有几个 多了就不会再处理了
            比如：web服务器 每发送一个链接 就开启一个线程去负责全部的处理
                直到处理完成 中间不会分配给其他线程
        2 事件驱动的线程模式
            在每个连接对应一个线程的模式中 线程大部分时间在等待IO
            所以把线程的IO处理给抽出来  转而通过发送异步IO请求和使用IO多路
                复用来管理服务器中的控制流 在这种模式下 请求处理转换为
                一系列异步IO请求以及关联的回调函数。。。
    同步：
            和操作系统管理进程的同步一样
            互斥 也是一样的。。。。
            死锁。。。。。。也一样
            避免死锁：
                每个线程都按顺序 获得资源
    Pthread API
        提供了100多个接口  骂声不断。。。。
        在文件<pthread.h>中定义的
            函数可以分为两大组 
            线程管理：
                完成创建 销毁 链接 和 datach线程的函数
            同步：
                同步 互斥 条件变量 障碍
        链接Pthread   他是一个独立的库 需要连接
            gcc -Wall -Werror -pthread beard.c -o beard
        
        创建线程：
            <pthread.h>
            int pthread_create(pthread_t *thread,
                                const pthread_attr_t *attr,
                                void *(* start_routine)(void *),
                               void *arg );
                调用成功的时候 会创建一个新的线程 开始执行start_routine
                提供的函数 并可以传参 arg   函数会保存线程ID
            attr用于改变新创建线程的默认属性 如：栈大小 。。。。
                新创建的线程 共享内存资源 打开文件。。。
            出错时 会直接返回非零错误码 不使用errno
                pthread_t thread;
                int ret;
                
                ret = pthread_create(&thread,NULL,start_routine,NULL);
                if(!ret){
                    errno = ret;
                    perror("pthread_create");
                    return -1;
                }
        线程ID  TID
            类似于进程ID 但进程ID是linux内核分配的 TID是pthread库分配的
            获取TID
                    <pthread.h>
                    pthread_t pthread_self(void);
            比较ID
                    <pthread.h>
                    int pthread_equal(pthread_t t1,pthread_t t2);
                    不同返回0 非0
        终止线程：
            线程自杀：
                    <pthread.h>
                    void pthread_exit (void *retval);
            终止其他线程：
                     <pthread.h>
                     int pthread_cancel(pthread_t thread);
                调用成功的时候 会给TID发送取消请求 返回0
                错误：返回ESRCH
            线程是否可以取消 看线程的状态 允许 不允许
            修改线程状态：
                 <pthread.h>
                 int pthread_setcancelstate(int state,int *oldstate);
                 state:
                    PTHREAD_CANCEL_ENABLE
                    PTHREAD_CANCEL_DISABLE
                成功时 线程改变状态 将old状态保存到oldstate中
            线程的取消类型可以是异步的或则延迟的 默认后者
                可以改变
                <pthread.h>
                int pthread_setcanceltype(int type,int *oldtype);
                type:
                    PTHREAD_CANCEL_ASYNCHRONOUS
                    PTHREAD_CANCE_DEFERRED
        加入线程和datach分离线程
            join线程：
                 <pthread.h>
                 int pthread_join(pthread_t thread, void **retval);
                 调用成工 指定线程将会阻塞 知道指定线程 终止
                 如果 retval不为NULL 终止进程返回状态给他
                 出错：
                    返回非0 代码：
                    EDEADLK
                        检测到死锁
                    。。。
            datach 分离 join
                 <pthread.h>
                 int pthread_datach(pthread_t thread);
        线程编码实例： 详见：function/thread/thread.c

        线程互斥：
            初始化互斥：
                pthread_mutex_t mutex = PTHREAD_MUTEX_INITALIZER
            对互斥加锁：
                <pthread.h>  
                int pthread_mutex_lock(pthread_mutex_t *mutex);
                OK 阻塞调用线程 直到由mutex指向的互斥提变得可用的 线程
                就会唤醒  
            对互斥解锁：
                 <pthread.h>
                 int pthread_mutex_unlock(pthread_mutex_t *mutex);
                    OK 释放互斥体 返回0
