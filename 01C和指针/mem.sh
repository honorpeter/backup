动态内存分配：
    c语言标准库里面的malloc函数 用一个系统调用编写的 他们会维护一个内存池
    在stdlib.h中定义下面几个函数
        void * malloc(size_t size);     size字节数  申请空间成功返回 
                            返回指向哪里的指针  失败NULL  
                            size_t 也定义在stdlib.h
        void * calloc(size_t num_elements, size_t element_size);
                        几个元素        元素大小        申请成功后初始化为0
        void *realloc(void *ptr, size_t new_size);
                        修改已分配的内存大小  当原来的区域不能改变时
                        复制到另一块区域  返回新的内存指针
        void  free(void *pointer);  
                        释放
        例：
            int *pi;
            pi = malloc (25 * sizeof(int));
            if(pi == NULL){
                printf("Out of memory");
                exit(1);
            }
        内存分配时 常见错误是 没有检查是否为NULL 定义宏MOLLOC解决
        #define     malloc           这样无法调用malloc
        #define     MOLLOC(num, type) (type *)alloc((num) * sizeof(type))
        extern void *alloc(size_t size);

        警告： 使用free时 释放不能一个一个字节的方 一块的释放
            申请后 使用完后 一定要释放
            不然内存泄露 操作系统内存用完 重启

