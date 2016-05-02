函数：
    可变参数列表
        stdarg宏  这宏定义在 stdarg.h中
        例：
        #include<stdarg.h>
        float average(int n_value, ...) 这里的...必须写 必须是三个点
        {
            va_list var_arg;            声明一个va_list 的变量 用于取参
            int count;
            float sum = 0;
            va_start( var_arg , n_value);初始化 第一个参数是变量 第二个
                                        参数是 ... 前面的一个变量 
            for(count = 0; count < n_value; count++) {
                sum += va_arg(var_arg, int); 取参数 并告诉类型
            }
            va_end(var_arg);        结束
            return sum / n_value;

        }


