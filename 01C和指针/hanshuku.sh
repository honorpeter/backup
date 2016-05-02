位置：
        /usr/include/
        系统调用
        /usr/include/x86_64-linux-gnu/sys/
整型函数：
    算数：  <stdlib.h>
        int abs(int value);
        long int labs(long ing value);
            返回一个数的绝对值 如果不是整型是未定义的

        div_t div(int numerator, int denominatior);
        div_t ldiv(long int numerator, long int denominatior);
            div_t是一个结构 里面包含：
                int quot;       商
                int rem;         余数
    随机数：    <stdlib.h>
        int rand(void);
            返回一个在 0和RAND_MAX（至少为32767）之间内个一个数
        void srand(unsigned int seed);
            放入一个种子  对随机数发生器初始化 这样就不会产生相同的随机数
            常用时间作为种子srand((unsigned int) time(0));
    字符串转化：<stdlib.h>
        int atoi(char cosnt *string);
        long int atol(char const *string);
            跳过前面的空白字符 和最后的空白 把字符串转化为整型
        long int strtol(char const *string ,char **unused, int base);
        unsigned long int strtoul(char const *string ,char **unused, 
                                                    int base);
                
    浮点型函数：
                <math.h>
            sqrt();     定义域错误  范围错误
    三角函数：
        double sin(double angle);
        double cos(double angle);
        double tan(double angle);
            angle使用弧度表示的角   
        double asin(double value);
        double asin(double value);
        double asin(double value);
        double atan2(double x,double y);
            返回 y/x反正切值
    双曲函数：  <math.h>
        double sinh(double angle);
        double conh(double angle);
        double tanh(double angle);
        
    对数和指数函数：
        <math.h>
        double exp(double x);
        double log(double x);
        double log10(double x);
    浮点表示形式  math.h
        double frexp(double value, int *exponent);  
        double ldexp(double frastion, int exponent);  
        double modf(double value, int *exponent);  
    幂  math.h
        double pow(double x ,double y);
        double sqrt(double x);
    底数 顶数 绝对值 和余数
        <math.h> 
        double floor(double x); 
        double ceil(double x); 
        double fabs(double x); 
        double fmod(double x,double y); 
字符转化函数：
        <stdlib.h>
    double atof(char cosnt *string);
    double stdtod(char cosnt *string, char **unused );
时间和日期函数：
    <time.h>
    处理器时间：
        clock_t clock(void);
            返回从程序开始执行 起处理器消耗的时间
            错误返回 -1     这是一个近视值 如要获得精确值 可以在main开始的
            时候 设置一次  相减便可
        返回值是 处理器时钟滴答的次数  除以常量 CLOCKS_PER_SEC 转化为秒

    当天时间：
        time_t time(time_t *returned_value); 
            错误返回-1
            返回  1970 1 1 00：00:00到现在的秒数
            不能使用两次时间相减 得到时间流失 difftime函数
        日期和时间转换：
            char *ctime(time_t const *time_value);
                返回一个字符串 格式如下：
                Sun Jul 4 04:02:34 1977\n\0
                下一次 再调用的时候 会覆盖第一次的值
            double difftime(time_t time1, time_t time2);
                计算time1-time2  把其结果转化为   秒

            struct tm *gmtime(time_t const *time_value );
                gm是UTC时间
            struct tm *localtime(time_t const *time_value );
                转化为当地时间
            tm结构：
                int tm_sec  0-61
                int tm_min  0-59
                int tm_hour 0-23
                int tm_mday 1-31
                int tm_mon  1-11
                int tm_year 0-      1900年之后的年数  相加啊
                int tm_wday 0-6
                int tm_yday 0-365
                int tm_isdat        夏令时的标志
        使用tm结构 转换：
            char *asctime(struct tm const *tm_ptr);
                这个函数 便可以得到 ctime函数的格式 ctime就是这样实现的
            size_t strftime(char *string ,size_t maxsize, char cosnt *format
                struct tm const *tm_ptr);
            strftime格式代码：
                %%          %
                %a          一个星期的某一天
                %A          一个星期的某一天    全称 Sunday
                %b          月份
                %B          月份        May
                %c          日期和时间  使用%x %X
                %d          一个月的第几天 01-31
                %H          0-23
                %I          00-12
                %J          一年的第几天    001-366
                %m          月份 01-12
                %M          分钟00-59
                %P          AM PM
                %S          00-61
                %U          一年的第几个星期    00-53
                %w          一个星期的第几天      星期日为0
                %W          一年的第几个星期    00-53
                %x          日期 使用本地的日期格式
                %X          时间 使用本地的时间格式
                %y          当前世纪的年份00-99
                %Y          年份的全写形式 1978
                %Z          时区的缩写
                time_t mktime(struct tm const *tm_ptr);
                将tm转化为 time_t

非本地跳转：  <setjmp.h>
    int setjmp(jmp_buf state);
    void longjmp(jmp_buf state,int value);
        一种类似于goto语句的机制    
        详见 function/16/setjmp.c

信号：
    信号名：    <signal.h>
    SIGABRT         程序请求异常终止
    SIGFPE          发生一个算数错误
    SIGILL          检测到非法指令
    SIGSEGV         检测到对内存的非法访问
    SIGINT          收到一个交互性注意信号
    SIGTERM         收到一个终止程序的请求
    处理信号：  <signal.h>
        int raise(int sig);
            引发指定的信号
        当一个信号发生时 我们有三种 范式对他 做出反应 默认是 编译器定义的
                一般是终止程序
            可以自己定制：
            void (*signal (int sig,void (*handler))(int))
                参数是一个信号 和 一个处理函数
            signal.h中还定义了两个宏 SIG_DEL SIG_IGN        他们可以作为
                signal的参数 SIG_IGN忽略信号    SIG_DEL 回复默认
        volatile    sig_atomic_t 静态变量。。。。。。。？？？？
打印可变参数列表：
    <stdarg.h>
    int vprintf(char const *format, va_list arg);
    int vfprintf(FILE *stream, char cosnt *format,va_list arg);
    int vsprintf(char *buffer, char cosnt *format,va_list arg);

执行环境
    终止执行：
    <stdlib.h>
    void abort(void);
         不正常的终止 引发 SIGABRT信号  你可以为这个信号 写一个处理函数
    void atexit(void (func)(void));
        当程序实行完了 或 exit  便会执行这里面的传的function
    void exit();
    
    断言：
        <assert.h>
        void assert(int expression);
        可以是用 
            #define NDEBUG          让编译器 消除所有断言
    环境：
        <stdlib.h>
        char *getenv(char const *naem);
            获得系统中的环境变量
    执行系统命令：
        <stdlib.h>
        void system(char const *command);

排序和查找：
    <stdlib.h>
    void qsort(void *base, size_t n_elements,size_t el_size, 
        int (*compare)(void cosnt *,void const *));
        升序排序        第一个参数 要排序的数组
                          2         元素个数
                          3         每个元素的长度 字符为单位
                          4         函数指针 用于数据比较
                                    返回整型 1 0 -1
                                    这个函数 需要使用强制类型转换
                                    详见function/16/qsort.c
    bsearch函数用于在一个已经排序好的数组中用二分法 查找
        void *bsearch(void const *key, void const *base, size_t n_elements
        size_t el_size ,int (* compare )(void cosnt *,void const *));
            详见 fucntion/16/bsearch.c
locale:
    char *setlocale(int category, char const *locale);
    category:
        LC_ALL          整个locate可以修改
        LC_COLLATE      对照序列 影响： strcoll strxfrm函数行为
        LC_CTYPE        ctype.h中函数 所有字符分类函数
        LC_MONETARY     在格式化 货币值使用的字符
        LC_MUMERIC      格式化飞货币值修改字符转换函数格式化输入输出 小数点
        LC_TIME         strftime函数的行为
    数值或货币格式：
        <locale.h>
        struct lconv *localeconv(void);
            struct lconv:   包含 字符和字符指针
        数值格式话：
            char *decimal_point
            char *thousands_sep
            char *grouping
        货币格式化：
            char *currency_symbol
            char *mon_decimal_point
            char *mon_thousands_sep
            char *mon_grouping
            char *positive_sign
            char *negative_sign
            char frac_digits
            .
            .
            .
            .
    字符串和locale
        字符集的对照序列表
            int strcoll(char const *s1, char const *s2);
            size_t strxfrm(char *s1,char cosnt *s2,size_t size);
                
