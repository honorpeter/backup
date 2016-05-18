Function templates:
        Function templates enable you to define a function in terms of 
                some arbitrary type
                    //specifies that you are setting up a template
                template <typename AnyType>
                void Swap(AnyType &a, AnyType &b)
                {
                    AnyType temp;
                    temp = a;
                    a = b;
                    b = temp;
                }
                you can use the keyword class instead of typename
        声明:
                template <typename T> // or class T
                void Swap(T &a, T &b);
    Overloaded Templates:
            template <typename T>
            // original template
            void Swap(T &a, T &b);
            template <typename T>
            // new template
            void Swap(T *a, T *b, int n);
    Template Limitations:
            template <class T>
            void f(T a, T b)                  
            {...}
            the code makes assumptions about what operations are possible 
                    for the type.
                For instance, the following statement assumes that 
                assignment is defined, and this would not be
                true if type T is a built-in array type:
                a = b;

Explicit Specializations:
        For a given function name, you can have a non template function, 
            a template function, and an explicit specialization template 
            function, along with overloaded versions of all of these.
        The prototype and definition for an explicit specialization should 
            be preceded by template <> and should mention the 
            specialized type by name.
        A specialization overrides the regular template, and a non 
            template function overrides both.

            // non template function prototype
            void Swap(job &, job &);

            // template prototype
            template <typename T>
            void Swap(T &, T &);

            // explicit specialization for the job type
            template <> void Swap<job>(job &, job &);
                            The <job> in Swap<job> is optional
                            template <> void Swap(job &, job &);
            if more than one of these prototypes is present, the compiler
                chooses the non template version over explicit 
                specializations and template versions, and it chooses an 
                explicit specialization over a version generated from 
                a template  based on the job type:

                double u, v;
                ...
                Swap(u,v); // use template
                job a, b;
                ...
                Swap(a,b); // use void Swap<job>(job &, job &)


The decltype Keyword:
        返回 变量的类型：
            int x;
            decltype(x) y;  // make y the same type as x
            
        参数可以是表达式：
            decltype(x + y) xpy = x + y;
        参数 是函数调用：
            long indeed(int);
            decltype (indeed(3)) m; // m is type int

        双空号：
            double xx = 4.4;
            decltype ((xx)) r2 = xx;
            decltype(xx) w = xx;
            // r2 is double &
            // w is double

C++模版类的语法
        template  <class 模版参数列表…>
        class 类名
        { //类体}
        成员的实现…
            例如：
            //类声明部分，有两个模板参数T1，T2
            template  <class T1, class T2 >  
            class A {
                private:
                int a;
                T1 b;  //成员变量也可以用模板参数
                public: 
                int fun1(T1 x, int y );
                T2 fun2(T1 x, T2 y);
            }
            //类实现部分
                template  <class T1, class T2 >
                int A<T1>:: fun1(T1 x, int y ){//实现…… }
                template  <class T1, class T2 >
                T2 A<T1,T2>:: fun2(T1 x, T2 y) {//实现…… }
            //使用类A
                int main( ) {
                    //定义对象a,并用int替换T1, float替换T2
                    A<int, float>  a;
                    //实例化a,调用a的属性和方法……
                }
                

        










