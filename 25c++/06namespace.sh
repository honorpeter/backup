Namespaces:
        Names in C++ can refer to variables, functions, structures, 
                enumerations, classes, and class and structure members.
        Traditional C++ Namespaces:
            
        New Namespace Features:
            uses the new keyword namespace to create two namespaces, Jack
                namespace Jack {
                    double pail;
                    void fetch();
                    int pal;
                    struct Well { ... };
                }
        using Declarations and using Directives
            The using declaration lets you make particular identifiers
                 available, and the using directive makes the entire 
                 namespace accessible.

            Declarations:
                 using Jill::fetch; // a using declaration
                 you can use the name fetch instead of Jill::fetch .
                    int main()
                    {
                        using Jill::fetch; //put fetch into local namespace
                        double fetch;    //Error! Already have a local fetch
                        cin >> fetch;   //read a value into Jill::fetch
                        cin >> ::fetch; //read a value into global fetch
                        ...
                    }
            Directives:
                Global:
                    using namespace Jack; // make all the names in Jack 
                                        available
                                Placing a using directive at the global 
                                level makes the namespace names available 
                                globally
                Local:
                    Placing a using directive in a particular function makes
                        the names available just in that function. 
                        int main()
                        {
                            using namespace jack; // make names available 
                                                in vorn()
                        ...
                        }
                or include file:
                    std::cin >> x;
        More Namespace Features:
                nest namespace declarations, like this:
                    namespace elements
                    {
                    namespace fire
                    {
                        int flame;
                        ...
                    }
                    float water;
                    }
            Unnamed Namespaces:
                    namespace
                    // unnamed namespace
                    {
                        int ice;
                        int bandycoot;
                    }
                    其主要目的是让该 namespace 中的成员（变量或函数）具有
                        独一无二的全局名称，避免名字碰撞 (name collisions)。
                        一般在编写 .cpp 文件时，如果需要写一些小的 helper 
                        函数，我们常常会放到匿名 namespace 里
                    感觉： 对函数而言 用static关键字 也可以代替其功能 
                不利之处:
                    其中的函数难以设断点，如果你像我一样使用的是 gdb 
                        这样的文本模式 debugger。
                    使用某些版本的 g++ 时，同一个文件每次编译出来的二进制
                        文件会变化，这让某些 build tool 失灵。


使用：
        using namesapce std;
        using std::string;   使用其中的一个函数









