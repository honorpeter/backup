整形数据：
    K&RC规定：
                signed                  unsigned 
    char                                                  一般为1个字节
    short int                                                   4
    int                                                         4
    long int                                                    8

    但是具体的每个类型的大小由 编译器决定   可以从limits.h中找点帮助
    limits.h  定义了 各种整形类型的特定
                    signed                  unsigned 
                最小值      最大值          最大值
    char        SCHAR_MIN   SCHAR_MAX       UCHAR_MAX  
    short int   SHRT_MIN    SHRT_MAX        USHRT_MAX         
    int         INT_MIN     INT_MAX         UINT_MAX            
    long int    LONG_MIN    LONG_MAX        ULONG_MAX

        MB_LEN_MAX规定了一个多字节字符最多允许的字符数量    
        每个机器对char 默认可能是signed 或 unsigned 所以一般用起交集或声明好
            对于 其他类型 默认都是 signed
const执行整形常量 初始化后 不允许改变

枚举类型：
    和结构类型一样  先定义类型 在声明类型 在声明变量
        定义类型： enum type { fish, dog, cat = 45, pig};
                                默认：fish = 0 dog = 1 .....
                                    可以改变  如上面 cat = 45 那么pig为46
        定义变量   enum type hh;    hh只能是 type其中的一个 不能出这个范围
                    

浮点类型：
    
        float           FLT_MAX     
        double          DBL_MAX
        long double     LDBL_MAX
    float.h中定义了 他们的大小  上面的几个常量便是
    固定至少 包含 10的正负37次方之间

字符串常量：
    可以包含空格  以 \0 为结尾 
    如：        "hello"         "line linue3"
        会生成一个 执行字符串常量的指针   可以访问他们
        char *message = "hello world";
    注意：这里重点注意   凡是char * 都是这个毛病
        *message = *message++ = h
        这里不知道为什么 前两个都是同一个字符
        printf("%c\n",*message);  // 打印出 ： h

指针：
    就是一个地址 
        int *a, *b ,*c;  声明  a b c三个指针
        int*a ,b ,c;        只声明了一个a指针
        int const *p;  
        int *const p;  指向常量的指针

    非法使用出现的错误
        当你使用的指针访问不存在的区域时 linux提示：
            segmenttation violation or memory fault
    NULL指针：
        标准定义了NULL指针：
            可以通过判断是否等于0来判断 指针变量是不是NULl指针
                作为一个特殊的指针变量 表示不指向任何东西
            指针常量：
                *(int *)100 = 25    将 位置是100 里面指向的地址的内容变25
                强制类型转换 将int型变为指针类型 
    指针的指针：
        声明： 
            int **a;  *几个这 表示几级指针  可以声明多级
            &去地址操作符 只能取内存的地址 不能去寄存器的地址
    指针运算：
        + - 运算用于数组的数据类型  malloc分配的内存可以...
        - 表示中间有几个 元素   
            两个指针相减的类型是 ptrdiff_t 一种有符号整型
        关系运算：
            <   <=  > >=
    对一个指针变量 声明时 不会自动分配内存 初始化的时候在分配
数组：
    数组名是一个常量指针 指向首地址  不能改变  不能使用++
        除了不能改变外 和 指针基本一样
    指针用法：  下标访问 和 指向改变
    声明数组参数：  char *a or int a[]        数组是个参数
    多维数组存储结构：
        使用指针访问时 注意：
        a[2][3] 先将内存分为2部分 再将这两部分 分成3分 
            指针++ 从最小分度开始移动       右值先动的原则
        数组名：执行第一个数组的地址
        声明数组参数：  int mat[3][10]
                        参数：  mat[][10]  or int (* mat)[]
    指针数组：
        先声明一个数组 int a[10];
        再把它变为指针形式  int * a[10]         
         char const *keyword[]={
                "do",
                "for",
                "if",
                "register"
            };      声明了4个指针  执行4个常字符串  同时指针也要存放空间

        char const keyword[][9]={
            "do",
            "for",
            "if",
            "register"
        };  声明一个矩阵 因为do不够9位 所以 0 补充  这两种方法看那个好。。
    函数指针：
        声明的时候 必须初始化函数指针  函数名不会分配内存空间 编译器会直接将
                    调用的地址写到程序上   函数名相当于 一个指针 
            初始化的时候  前面必须写了 函数的原型
        声明初始化：
            int (*p)(int a) = &f;       &可以省略 函数调用的时候 编译器...
            现在可以这样调用了：
                int b;
                b = f(2); 
                b = (*p)(2);
                b = p(2);
    void 类型指针：
        可以指向任何 类型 但是在使用的时候 必须先声明那种类型
    回调函数：
        使用函数指针 实现回调函数传递   详见：single_linked_list/search.c 
    转移表：
        代替switch很长的语句 详见       aboutunction/array_unction.c
    命令行参数：
        通过启动程序的时候传递的参数    例：
            cc -c -o main.c insert.c -o test
            在cc这个程序里面  main函数参数(int argc ,char const **argv)
                argc = 7 七个参数 空格分割
                agrv 指向一组指针的开始的第一个  
                                        cc
                                        -c
                                        -o
                                        main.c
                                        insert.c
                                        -o
                                        test
                **argv也可以写成 *argc[]    指针数组
字符串：
    函数：
        size_t strlen (char const *string)  size_t 无符号整型
             定义在stddef.h中
             strlen(x) - strlen(y) >= 0 因为是无符号整型 所以正确 比较注意
             strlen(x) >= strlen(y) 这样比较
        复制：
        char *strcpy(char *dst, char const *src);   返回*dst
            程序员要保证 dst的空间足够容纳src的内容 不然dst后面的内容被覆盖
        链接：
            char *strcat(char *dst, char const *src);   将src字符串放到dst后
                必须保证 dst空间足够 返回dst
        比较：
            int strcmp(char const* s1, char const *s2);
                如果 s1>s2 return great than 0   s1=s2 return 0 
                    s1<s2 return less than 0
                    如何比较 比较两个字符串 第一个不相同字符大小
        长度受限的字符串函数：
            char *strncpy(char *dst, char const *src ,size_t len);
                当src的内容小于len时 使用'\0'  填充
                当        大于时    在后面那么只有len个复制过去 后面没有'\0'
                    一定要注意这里没有 '\0'  
            char *strncat(char *dst , char const *src, size_t len);
                最后结果会自动 填一个 NUL字节
            int strncmp(char const *s1, char const *s2);
        字符查找：
        查找一个字符：
            char *strchr(char const *str, int ch);
                在str中找字符 ch 'h' 注意值一个整型 'a' 这样写就行
                找到返回第一个的指针 找不到返回NULL
            char *strrchr(char const *str, int ch); 返回最后一个
        查找任何几个字符：
            char *strpbrk(char const *str, char const *group);
                在str中寻找group中任意一个字符 第一次出现的位置
        查找一个字符串
            char *strstr(char const *str, char const *s2);
                如果s2是个空字符 返回str
            标准库中不存在strrstr   strrpbrk    strrstr.c中有实现
        高级查找：
            size_t strspn(char const *str, char const *group);
                    计数的 在str中 group中任一一个字符 出现次数和
                    空白字符。。。。。
            size_t strcspn(char const *str, char const *group);
        标记：
            char *strtok(char *str, char const *sep);
            用于 修改标记 在str中   出现 sep的任意一个字符 便会被 NUL替换
            返回这个标记的指针  如果没有返回NULL
        错误信息：
            char *strerror(int error_number);
                错误代码作为参数 返回指向错误代码信息的字符的指针
    字符串操作：
        在ctype.h中包含两组对单个字符串操作的函数原型
        字符串分类函数：
            iscntrl     任何控制字符
            isspace     空白字符： 空格 换页 \f 换行 \n \r \t \v
            isdigit         0~9
            isxdigit    0~9 a~z A~Z
            islower     a~z
            issupper    A~Z
            isalpha     a-z or A-z
            isalnum     a-z A-Z 0-9
            ispunct     任何 不属于数字或字母的图形字符
            isgraph     任何图形
            isprint     任何 可打印字符
        字符转换：
            int tolower(int ch);
            int toupper(int ch);


    内存操作；
        void *memcpy(void *dst, void const *src ,size_t len);
        void *memmove(void *dst, void const *src ,size_t len);
        void *memcmp(void const *a, void const *b ,size_t len);
        void *memchr(void const *a, int ch ,size_t len);
        void *memset (void *a, int ch ,size_t len);
        这几个函数和str不同的是 遇到NUL不会停止 函数继续
            sizeof
结构体：
    必须记住： struct hh 这是一种类型 相当于int 
    结构的自引用：
        struct self{
            int a;
            struct self b;
         }; 这样声明是非法的 包含自己 一直包含 有点先永远不会终止的递归程序
        struct self{
            int a;
            struct self *b;
         }; 这样声明是 合法的 因为是一个指针 指向这样的结构
    不完整的声明：
        声明一些相互依依赖的结构
        struct B;       先写一下 后面在声明
        struct A{
            struct B *partner;
            ....
        };
        struct B {
            int c;
            struct A *partner;
        };

        struct  B *po;
            po是指向整个结构的指针 虽然和第一项的地址一样 但是它们是不同的
             *po 不等于 c   可以这样    int *d = &po->c
    存储分配：
        按照字节最大的分配几个 小的填入
        struct a{
            char b;
            int c;
            char d;
        };      4b 4c 4d
        优化
        struct b{
            int c;
            char b;
            char d
        };      4c 4bd
        使用sizeof可以确定结构的存储空间包括 跳过的空间
        在stddef.h中的宏   size_t offsetof(type,member) 可以得出这个
            在结构type中 member成员在结构中的前一位地址 
    位段：
        里面的成员必须是 int unsigned signed这几种的类型之一
        :后面的整数 表示 占位的数目  
        声明类型：
            struct CHAR{
                unsigned ch :7;
                unsigned font :4;
                unsigned size :13;
            };

    联合：
        把struct改为 union便可
        它每次 声明变量的时候 只能声明 里面一个




定义：
    #define
    typeof

作用域：
    块作用域
    函数作用域
    文件作用域

    链接属性：
        external            在所有文件中    是同一个实体 公用
                默认 ：全局变量  还有 函数
                具有 external属性的值 可以接static变为 internal

        internal            在同一个文件中 是同一个

        none                每一个都是 一个独立的个体

        extern
                static int i;
                int func(){
                    extern int k; //这样便可以访问其他文件中的变量k
                    extern int i;  //i的作用域为这个文件 因为static
                                    //不改变 变量的作用域
                }
    存储类型：
        register
        static
