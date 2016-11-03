Function Overloading:
        参数 数量 类型不同 便会重载
    
Function Templates:
        template <typename AnyType>     template指定要使用模板 
        void Swap(AnyType &a, AnyType &b)
        {
            AnyType temp;
            temp = a;
            a = b;
            b = temp;
        }
            typename 可以被class代替 基本一样功能


Overloaded Templates:
            #include <iostream>
            template <typename T>
            // original template
            void Swap(T &a, T &b);
            template <typename T>
            // new template
            void Swap(T *a, T *b, int n);
The decltype Keyword (C++11):
            int x;
            decltype(x) y;      
            // make y the same type as x    当使用模板的时候有用









