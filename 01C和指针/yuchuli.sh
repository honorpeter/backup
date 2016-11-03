预处理器：
    编译器处理的程序的时候 先 进行 预处理
预定义符号：
    __FILE__      进行编译的文件名
    __LINE__      文件当前行
    __DATE__      文件被编译的日期
    __TIME__      文件被编译的时间
    __STDC__      如果编译器支持ANSI C其值为1

#define
    #define name stuff  进行预处理的时候 直接使用stuff 原封不动的替换name
    如果 stuff非常长的话 分行来写  每行的末尾 加  \
        #define DEBUG_PRINT printf("File %s line %d " \
                            "x=%d, y=%d, z=%d", \
                            __FILE__, __LINE__, \
                            x,y,z);

宏： 宏定义  实际就是 #define进行传参
        #define name(x)  ((x)+(x))      这里注意：  里外层都加 括号 防止。。
                                    每个参数自己加括号 整体加括号
                        这样使用name就可以传递个参数了 直接替换

    宏内不能存在递归  预处理的时候 是通过一遍又一遍的处理的 第一次检查
            一下 有没有宏 如果有替换 再检查 知道没有为止。。。
            进行预处理的时候 字符常量不进行检查 参数插入字符中间方法；
                1 使用双引号 将字符分割开来 将参数放入中间
                    #define PRINT(value) printf("the "value "is a good");
                2 使用 #argument    编译器会把翻译为 argument 参数
                    #define PRINT(value) printf("the" #value "is a good " );

    宏与函数：
            宏简单快捷  每次都是一分拷贝 增加程序空间 一般使用比较小的宏
            宏的重要一点：  无类型之分 函数只能实现固定类型
            #define MAX(x,y) ( (x)>(y)?(x):(y)) 没有类型之分 函数则不同
                                    注意这里没有下分号  写程序的时候写分号
    带副作用的宏参数：
        a++ a--
        .....   
    命名约定：
        因为宏和函数很难区分 
            就约定 宏名： 全部大写
            函数名 ： 小写
    #undef      
        移除一个宏定义
            #undef name
    命令行定义：
        -D选项
        cc -Dname=stuff ....
        cc -DARRAY_SIZE=100 hh.c
条件编译：
            调试代码：
            #if DEBUG 
                printf("the line...eror")
            #endif
            关闭调试：
                #define DEBUG 0     开启:  #define DEBUG 1

        #if condition
            .....
        #elif constion
            ...
        #else
            ,,,,
        #endif
    是否被定义：
        #if defined(name)
            .....
        #ifdef name
            ...
        #if !defined(name)
        ....
        #ifndef name
    可以嵌套 if语句
文件包含：
    #include <>      函数库  只在 特定目录寻找
    #include""      本地头文件  先当前目录里面寻找 再去寻库 
嵌套 包含 多重包含
    嵌套包含：
        一个文件包含一个文件 然而那个文件还包含文件。。。。。
        这样 对 make这样的需要知道依赖关系的软件 不利
    还会导致 重复包含：
        解决方案：
            #ifndef _HEADERERROR.H
            #define _HEADERERROR.H 1
                ....
            #endif
其他指令：
        #error  text of error for message
         当程序打印完之后 打印错误信息

         #line number "string"
            string 可选  编译器会把number当做 下一行输入的行号
            string 改为文件名字  
            这样会改变 __LINE__  __FILE__
        

        #和##的作用是：
            前者将宏定义的变量转化为字符串；后者将其前后的两个宏定义中的
                两个变量无缝拼接在一起转化为字符串。

                #： 在宏定义中，将其后的变量，转化为字符串。
                    eg：  #define  str(s)      #s
                    输出： helloworld ， 就可以通过这样的的调用， 
                                    printf( str(helloworld) );

                ## ： 在宏定义中，将其前后的两个变量拼接在一起。
                    eg： #define v(a,b,c,d)       0xa##b##c##d             
                //将四个字节的十六进制的数据转化为一个十六进制的整型数据
                    int    a  =  v(CF,AB,B0,BC);   // 即 a = 0xCFABB0BC
            两者的共性： 能够阻止宏定义的递归展开。可以通过中间的转
                    换的宏，来实现参数宏的展开
            
