iomanip:
        头文件：
            #INCLUDE<IOMANIP>
            #include <iomanip>
        对cin,cout之类的一些操纵运算子：
            就像C里面的格式化输出一样.以下是一些常见的控制函数的:
                dec 置基数为10 相当于"%d"
                hex 置基数为16 相当于"%X"
                oct 置基数为8 相当于"%o"
                setfill(c) 设填充字符为c
                setprecision(n) 设显示小数精度为n位
                setw(n) 设域宽为n个字符
                    这个控制符的意思是保证输出宽度为n。如：
                    cout<<setw(3)<<1<<setw(3)<<10<<setw(3)<<100; 
                        输出结果为 1 10100 （默认是右对齐）当输出长度
                        大于3时(<<1000)，setw(3)不起作用。
                setioflags(ios::fixed) 固定的浮点显示
                setioflags(ios::scientific) 指数表示
                setiosflags(ios::left) 左对齐
                setiosflags(ios::right) 右对齐
                setiosflags(ios::skipws 忽略前导空白
                setiosflags(ios::uppercase) 16进制数大写输出
                setiosflags(ios::lowercase) 16进制小写输出
                setiosflags(ios::showpoint) 强制显示小数点
                setiosflags(ios::showpos) 强制显示符号 









