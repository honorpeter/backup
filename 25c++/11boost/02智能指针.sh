Boost智能指针——shared_pt:
    boost::shared_ptr是可以共享所有权的智能指针


#include <string>
#include <iostream>
#include <boost/shared_ptr.hpp>

class implementation
{
public:
    ~implementation() { std::cout <<"destroying implementation\n"; }
    void do_something() { std::cout << "did something\n"; }
};

//`

void test()
{
    boost::shared_ptr<implementation> sp1(new implementation());
    std::cout<<"The Sample now has "<<sp1.use_count()<<" references\n";

    boost::shared_ptr<implementation> sp2 = sp1;
    std::cout<<"The Sample now has "<<sp2.use_count()<<" references\n";
    
    sp1.reset();
    std::cout<<"After Reset sp1. The Sample now has "<<sp2.use_count()<<" references\n";

    sp2.reset();
    std::cout<<"After Reset sp2.\n";
}

void main()
{
    test();
}

output:
    The Sample now has 1 references
    The Sample now has 2 references
    After Reset sp1. The Sample now has 1 references
    destroying implementation
    After Reset sp2.
boost::shared_ptr指针sp1和sp2同时拥有了implementation对象的访问权限，且当
    sp1和sp2都释放对该对象的所有权时，其所管理的的对象的内存才被自动释放。
    在共享对象的访问权限同时，也实现了其内存的自动管理。
    管理方法： 引用计数方式管理 和内存垃圾收集差不多

安全的使用boost::shared_ptr：
        避免对shared_ptr所管理的对象的直接内存管理操作，以免造成该对象的
        重释放 shared_ptr并不能对循环引用的对象内存自动管理
        不要构造一个临时的shared_ptr作为函数的参数。
        如下列代码则可能导致内存泄漏：
void test()
{
    foo(boost::shared_ptr<implementation>(new    implementation()),g());
}
正确的用法为：
void test()
{
    boost::shared_ptr<implementation> sp    (new implementation());
    foo(sp,g());
}









