编程范式：
        面向过程编程：
            c语言:  过程式 操作数据
        面向对象编程：
            c++  :  将数据看做主题      先有数据在操作
        函数式语言：
            schme lisp
        其他：
            Python

c语言：
        数据类型的存储：
            整形：
                无符号：
                        char a;
                        short b;
                        如果把b赋值给a的话 因为a的字节长度不够 
                        所以只拷贝 前8个bite
                有符号
                        第一位是符号位  0 表示整数 1表示负数
                        当表示负数的时候 计算机是以他的 补码存储的

            浮点型：
                以flaot为例：
                    第一位表示符号位
                    第一位后面的8位表示一个数m      0<=m <=255
                    最后23位 分别为2的 -1 -2 -3 。。。-23次方
                    最后结果表示为：
                        1.xxx * 2的（m-127）次方
                        xxx为后23的值

                        7.0 = 7.0*（2的0次方）
                         = 3.5*（2的1次方）
                         = 1.25*（2的2次方）
                         便可以表示了  把他的范围放到 1-1.999之间 
                        
            C语言：数据 先确定 类型 再进行操作

    补码的说明：
            先确定位数
            再写补码
                    例如： 确定5位
                                    00101
                        取反        11010
                        相加再加1  100000
                        因为只有5位 结果为0     
                        所以负数相加就可以加他的补码了
                    
    结构：struct 
            struct student{
                int chinese;
                int math;
            }xiao;   
            内存从下到上是： 低地址 到 高地址
            变量xiao 的存储方式：
                    four bite：math
                    four bite: chinese
            If you say:
                double yan = (double *)&xiao ;
                it will copy(just copy) the content xiao
                        ( both math and chinese) to yan
                        that is because : double is 8 bites 
            If you say:
                    ((char *)&xiao + 1) = 1:
                    it changes the second byte of xiao to 1
                of course you can use any other types to operate the memory
            If you say:
                    int a;
                    double b = (double) a;
                        I don't know what will happen
                        will a change? b must be a doule type
        summary：
            each datatype is a way to operate the memory .
                you can mix them up 
                when give you a address, you can use different way to change
                    every part of it 

                

