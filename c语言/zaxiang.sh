printf常用格式：
    printf执行了一个系统调用 write的系统调用
    %d 以十进制形式打印一个整型值
    %o 以八进制形式打印一个整型值
    %x 以十六进制形式打印一个整形值
    %g 打印一个浮点值
    %c 打印一个字符
    %s 打印一个字符串
    \n 换行

scanf常用格式：
    函数的返回值：是 转化成功的个数  失败返回0 
    scanf执行了一个系统调用 read的系统调用
    %d 一个整形     int
    %ld             long
    %f              float
    %lf             double
    %c              char
    %s              char数组

c语言中的字符串：
    约定 以\0结尾 但\0不作为字符串的一部分  \0的名字为  NUL

    字符常量都会默认加上一个 NUL  '\0'


编译:
    gcc -c print.c -o print.o           不写-o默认也是 print.o
    gcc -c print.c hh.c  wuyu.c          编译多个文件

链接：
    gcc print.o                     链接一个 默认生成 a.out
    gcc print.o hh.o wuyu.o


字符：
        规定 字符集必须包括 英语所有大小写字母
        还有一些常用的符号

    三字母词：
        现在编译器 一般被忽略了 使用 -trigraphs 可以不让它忽略
        ??( [       ??< {       ??=  #
        ??) ]       ??> }       ??/  \
        ??! |       ??' ^       ??-  ~

K&R C:规定
    \a      警告字符
    \b      退格字符 
    \f      进纸字符
    \n      换行
    \r      回车
    \t      tab 水平制表字符
    \v      垂直制表符
    \ddd    ddd表示1～3个八进制数字。 所代表的字符  \101  所代表的字符
    \xddd   同理 十六进制


    

NULL是指向0的一个指针 在stdio.h中定义的   void * NULL;

c语言中 函数的局部变量 必须声明在函数的开头


错误报告：
     void perror(char const *message);
        这个函数会打印出 message指向的字符  还会打印 解释errno当前错误代码
        在stdio.h 中定义的

终止执行：
    void exit(int status);

IO: c语言操作：
        执行字符， 文本行   二进制I/O函数
    字符：  getchar         putchar
    文本行  gets            puts
            scanf           printf
    二进制  fread           fwrite
        这些字符文本行函数只能用于 stdin  stdio   文件
        如果想用于所有的文件  前面一般加 f   但不能对内存操作
            fgetc,getc      fputc ,putc
            fgets           fputs
            fscanf          fprintf
        操作内存中字符的函数：
            sscanf      sprintf
    
    流 ： 指的是对所有文件操作的字节流
    文件指针：  它和文件描述符一一对应的
    打开流：
        FILE *fopen(char const *name, char const *mode);
            mode :
                r       w       a   
                b表示二进制文件打开的是
                r   :流指针指向文件的开始
                r+  ：读写模式打开  流指针指向文件的开始
                w   ：如果文件存在 那么文件会被清空 如果不存在那么创建
                w+  ：读写模式打开 如果文件存在 清空 不存在 创建
                a   ：追加 如果文件不存在 创建
                a+  ：追加 读写模式打开
            失败返回NULL指针

        FILE *freopen(char const *name,char const *mode , FILE *stream);
                 该函数 先试图关闭 stream流 再以mode打开
        FILE *fdopen(int fd,const char *mode);
            将通过系统调用的打开的文件描述符 转化为流
            mode和fopen差不多
                但以w w+不会清空文件指向 文件描述符指向的位置
    关闭流：
        int fclose(FILE *f);
            这个函数 会刷新用户区内存缓冲区 如果执行成功返回0 失败EOF
        关闭所有流：
            #define _GUN_SOURCE
            #include<stdio.h>
            int fcloseall(void);
            关闭之前文件都会 写会到文件 始终返回0 linux特有的


    字符io
        int fgetc(FILE *stream);
            错误和结尾都会返回：EOF
        int getc(FILE *stream);
        int getchar(void);  getchar是stream=0
            

        int fputc(int character, FILE *stream);
            失败返回 EOF 成功返回字符
        int putc(int character, FILE *stream);
        int putchar(int character);

        io宏：
            getchar()   putchar()   putc    getc 都是通过 宏实现的函数
            就是调用 带f的函数实现的
        撤销字符：
            int ungetc(int character, FILE *stream);
                失败返回EOF 成功返回这个字符 先强制类型转化为unsigned char
                    再次访问时 会调出这个字符 如果中间使用了seek会丢失这个
                    字符
                把先前载入的字符返回到流中 这样可以以后载入
未格式化的行IO
        char *fgets(char *buffer,int buffer_size,FILE *stream);
             例：
                char buf[LINE_MAX];
                if(!fgets(buf,LINE_MAX,stream)){
                    //error
                }
        char *gets(char *buffer);
            fget函数 从stream文件处读取一行字符到EOF停止读取 或则
                buffer缓冲区已经满了 不在读取  但这样不会丢失数据 下一次
                读取的时候函数从下一个字符开始读取
            如果还没有读取 buffer就满了的话返回NULL指针
        int fputs(char const *buffer,FILE *stream);
        int puts(char const *buffer);
            fputs函数从buffer 中读取到stream 成功返回非负值 失败EOF
            
格式化的IO
    scanf家族：
        int fscanf(FILE *stream,char const *format,...);
        int scanf(char const *format,...);
        int sscanf(char const *string,char const *format,...);
            成功返回好像转化的个数 失败返回EOF 没有匹配到
        scanf格式化代码：
            %   可选的*     可选的宽度      可选的限定符    格式代码
             
            限定符：        h               I           L
                        short           long            long double
                目的是为了指定参数的长度

            格式码：
                c                   char
                i d                 int
                u o x               unsigned        u 十进制 o 八 x 16
                e f g               float           
                s
                [xxx]               当遇到第一个不在[]中便停止
                p
                n
        printf家族：
            int fprintf(FILE *stream, char const *format,...);
            int printf( char const *format,...);
            int spintf(char *buffer, char const *format,...);
            格式代码：
            %   零个或多个标志符    可选最小字段宽度    可选精度    可选修改符      转化类型

            转化类型：
                c       int         参数变为unsigned char打印
                d i     int         十进制打印 精度不够填0
                u o x,X unsigned int u 十进制 o八 x 16(小写)    X(大写)
                e E     double      使用指数模式打印 e
                f       double      小数打印
                g G     double      小数模式或指数模式 看小数点位数 4分界
                s
                p
                n
            格式标志：
            -                   左对齐 默认是右
            0                   精度不够0填充 有的不起作用
            +                   正变负 负变正
            空格
            #

            修改符：        用于            
            h           d i u o x X            short 型数
            h           n                   short整形的指针
            I           d i u o x X         long
            I           n                   long整形指针
            L           e E f g G           long double

            转化的其他形式：
            用于                #标志
            o                   以0开头
            x X                 加0x前缀
            e E f               确保有小数点
            g G
                

                        
            
二进制IO
    size_t fread(void *buffer, size_t size,size_t count,FILE *stream);
        size是每个元素的字节数 count读取或写入几个元素
        读取完之后 指针向后 一直移动 返回读到数据项的个数 不是字节的个数
        失败或文件结束 返回一个比conut小的数
        必须使用ferror（）和feof（）函数区分
            char buf[64];
            size_t nr;
            nf=fread(buf,sizeof(buf),1,stream);;
            if(nf==0)
                //error
    size_t fwrite(void *buffer, size_t size,size_t count,FILE *stream);
        成功返回conut数 失败返回一个比count小的数 
             
    
    刷新和定位函数：
        int fflush(FILE *stream);
            将用户缓冲区写入内核缓冲区
            失败返回EOF 成功0
        随机访问：
            long ftell(FILE *stream);
                返回流的当前位置 下一个要读取 写入的字符 距离起始位置偏移
                失败-1
            int fseek(FILE *stream,long offset, int from);
                from:
                    SEEK_SET        从起始位置 偏移offset个字节
                    SEEK_CUR
                    SEEK_EDN

            void rewind(FILE *stream);
                回到起始位置
            int fgetpos(FILE *stream, fpos_t *potion);
                失败-1  成功0
            int fsetpos(FILE *stream, fpos_t const *potion);
                失败返回-1

    改变缓冲方式：
        改变缓冲区的大小。。。。buffer区
        自定义 缓冲区 不在c库维护的缓冲区之中
        void setbuf (FILE *stream, char *buf);
             设置另一个数组 用于对流的缓冲 字节大小 为BUFSIZ 在stdio.h 中
                定义
        int setvbuf (FILE *stream, char *buf, int mode, size_t size);
                size 是buf多大字节
                mode:
                    _IOFBF  块缓冲  
                    _IOLBF  行缓冲区  每写入一行 就刷新缓冲区到内核
                    _IONBF  不缓冲区的流
             这个函数必须  在打开一个文件 还没有任何操作之前写
        标准默认： 对于stdout是行缓冲区
                    对于文件是 块缓冲区 块大小BUFSIZ在<stdio.h>定义
流错误函数：
        int feof(FILE *stream);
            当文件结尾 为真
        int ferror(FILE *stream);
            当发生任何 读写错误为真 
        void clearerr(FILE *stream);
            清除 errno的值

临时文件：
    FILE *tmpfile(void);
        这个函数 会创建一个文件  当程序执行完了之后 自动删除
            以 +wb  模式创建
            不需要的时候 使用 remove删除
    命名：
        char *tmpnam(char *name);
获取关联的文件描述符：
    通过文件描述符 可以进行系统调用
    <stdio.h>
    int fileno(FILE *stream);
    成功时 返回对应的文件描述符 失败-1
线程安全：
    当多个线程同时访问一个文件时  便会出现覆盖的情形
    所以需要安全机制  默认标准IO函数内部 都会对文件加锁 是安全的
    可以手动加锁：
        <stdio.h>
        void flockfile(FILE *stream);
            会等待stream解锁后 然后加上自己的锁计数  该函数的执行线程是
                流的拥有者
        void funlockfile(FILE *stream); 解锁    可以嵌套使用这连个函数
            函数会减少 和 stream关联的锁计数
        int ftrylockfile(* stream) 
            是lockfile函数 非阻塞函数       如果当前流已加锁 便会立刻返回
            一个非0的值 成功返回0
    对流操作解锁其他函数：
        #define _GUN_SOURCE
        <stdio.h>
        int fget_unlocked(FILE *stream);
        char *fgets_unlocked(char *str,int size ,FILE *stream);
        size_t fread_unlocked(void *str,size_t size, size_t nr, FILE *stream);
        int fputc_unlocked();
        int fputs_unlocked()
        size_t fwrite_unlocked()
        int  fflush_unlocked()
        int feof_unlocked();
        int ferror_unlocked();
        int fileno_unlocked();
        void clearerr_unlocked();
标准IO：
        最大的诟病是 两次复制
            当使用fgets读取数据的时候 先系统调用到IO缓冲区
            然后再从IO缓冲区复制到指定的位置
            可以使 用 直接传递IO缓冲的位置 避免第二次复制
            详见 ： 高级文件IO
文件操作函数：
    int remove(char const *filename);
    int rename(char const *oldername,char const *newname);
