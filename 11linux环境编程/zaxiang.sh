错误处理：
    系统调用：
        变量errno用于定位错误的原因：   
            在多线程的情况下 每一个线程都有 自己的errno变量
            错误文本放在固定的内存 因此后来的错误 会覆盖前面的错误

        在<errno.h> 定义如下：
            extern int errno;       不同值表示不同的错误选项

            errno的值可以修改 
            可以通过c库中的预处理#define直接修改errno的值
                #define EACCES  1           权限不足
                E2BIG           参数列表太长
                EAGAIN          重试
                EBADF           文件号错误
                EBUSY           设备或资源忙
                ECHILD          无子进程
                EDOM            。。
                EEXIST          文件以存在
                EFAULT          地址错误
                EFBIG           文件太大
                EINTR           系统调用被中断
                EINVAL          参数无效
                。。。。。。。
        c库提供了函数可以把值变为对应的文本
            <stdio.h>
            void perror(const char *str);
                该函数向标准输入stderr 打印 str指向的字符窜： errno错误字符
            <string.h>
            char *strerror(int errnum);
            int strerror_r(int errnum, char *buf ,size_t len);  
                成功时返回1 失败返回-1
                将错误文件 写入buf缓冲区    这个是最底层的其他是通过这个实现


        
