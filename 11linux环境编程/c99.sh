通过c99标准提供了一些新的功能：
    内联函数：
        使用关键词  inline
        static inline int foo (){}
        
        static inline _attribute_((always_inline)) int foo (){}
        这个函数告诉编译器 总是 对个函数执行内联操作
    避免内联：
        编译器会自己优化  所以。。。
        可以避免
        __attribute__((noinline))
    纯函数：
        是值不会带来任何其他影响 其返回值 只收函数参数和或nonvalatile全部
            变量的影响  任何参数或全局变量都只支持 只读 模式
        __attribute__((pure)) int foo (){}
        .....

    常函数：
         是一种严格的纯函数 不能访问全局变量 参数不能是指针类型 
        __attribute__((const)) int foo (){}
        和纯函数一样 返回void类型 也是非法且没有意义
    没有返回值的函数：
        __attribute__((noreturn)) void foo (){}
    分配内存的函数：
        
        __attribute__((malloc)) void * get_page ()
        {
                int page_size;
                page_size = getpagesize();
                if(page_size <= 0)
                    return NULL;
                return malloc(page_size);
        } 

    强制调用方 检查返回值
        
        __attribute__((warn_unused_result)) int foo (){}
    把函数表示为已使用：
        
        __attribute__((used)) int foo (){}
    把函已数表示为未使用：
        
        __attribute__((unused)) int foo (){}
    对结构体进行紧凑存储：
        struct __attribute__((packed)) foo{};
    增加变量的对齐：
        int beard_length __attribute__((aligned(32))) =0
        int beard_length __attribute__((aligned)) =5

    分支标注：
        #define likely(x) __builtin_expect(!!(x),1)
        #define unlikely(x) __builtin_expect(!!(x),0)

        把分支表识为 不太可能  为真
        int ret;
        ret = close(fd);
        if(unlikely(ret))
            perror("close");

        相反：
            const char *home;
            home = getenv("HOME");
            if(likely(home))
                printf("OK");
            else
                fprinf(stderr,"wrong");
    获取表达式类型
        typeof
        typeof(*x) y[]  声明y数组也是*x类型
    获取类型的对齐方式：
        __aligof__(int)
        返回值 依赖于体系结构   很可能返回 4  因为32为整数 通常是4个字节

    获取结构体中中成员变量的偏移：
        #define offsetof(type,member) __builtin_offsetof(type,member)

    获取函数的返回地址；
        void *__builtin_return_address(unsigned int level);
            level 0:    
                表示当前函数的地址
            level 1：
                表示返回当前函数的调用方地址
            level 2
                该函数调用的放的返回地址
    条件范围：
        switch(val)
        case 1...10:
            //
            break;
        case 11 ... 20:
            //
            break;
        case 'a'...'z':



        
