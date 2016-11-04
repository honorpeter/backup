主机内存：
        系统中可被CPU访问的内存，默认是可换页的   为了硬件使用DMA，操作系统
            允许主机内存进行锁页

    分配锁页内存：
            运行时：cudaHostAlloc()  / cudaFreeHost()
            驱动API：  cuMemHostAlloc()/ cuMemFreeHost()

    可共享锁页内存：
            默认情况下 谁调用的函数 谁使用锁页内存
            但是 通过在函数cudaHostAlloc函数中指定 cudaHostAllocPortable标志
                    或在函数cuHostMemAlloc中 指定CU_MEMHOSTALLOC_PORTABLE
                    所有GPU都可以访问
                当统一虚拟寻址有效，所有的锁页内存都是可共享的

    映射锁页内存：
            锁页内存可以被GPU直接访问，但仅仅是通过内存复制函数可以做到
            CUDA内核不能直接读写主机内存 SM1.2以上可以直接读写主机内存
            为了启用映射锁页内存，（就是直接读取主机内存）.....

            当UVA启用，所有的锁页内存都是被映射的

    写结合锁页内存：
            。。。。


    注册锁页内存：
            。。。


全局内存：
        设备内存    GPU可以直接读写

    指针：
            主机指针(void *)和设备指针(CUdeviceptr)之间可以方便的转换
            设备指针和主机指针有相同的宽度，32操作系统32位  64 -》64
            设备指针：
                #if defined(__x86_64) || define(AMD64) || define(_M_AMD64)
                    typedef unsigned long long CUdeviceptr;
                #else
                    typedef unsigned int CUdeviceptr;
                #endif 
            主机指针：
                uintptr_t  在头文件<stdint.h>中定义的
                
            CUdeviceptr devicePtr;
            void *p
            p = (void *)(uintptr_t) devicePtr;
            devicePtr = (CUdeviceptr) (uintptr_t) p;
            
        主机可以在设备指针上进行算数运算，但是不能解引用

    动态内存分配：
        运行时：
            cudaError_t cudaMalloc(void **,size_t);
            cudaError_t cudaFree(void);
        驱动API：
            CUresult CUDAAPI cuMemAlloc(CUdeviceptr *dptr,size_t bytesize);
            CUresult CUDAAPI cuMemFree(CUdeviceptr dptr);

    等步长内存分配：
        。。。
    内核内分配：
        费米架构硬件可以使用ma设备内存malloc（）函数动态分配
        由于这可能需要中断CPU 会很慢
        必须使用free函数释放

    查询全局内存数量：
            运行时：cudaGetDevicePropertites() 检查
                    cudaDeviceProp.totalGlobalMem;
            驱动API：
                CUresult CUDAAPI cuDeviceTotalMem(size_t *bytes,CUdevice dev);

    静态内存分配：
        使用__device__关键标记在内存声明中
            静态内存复制可以使用
                cudaMemcpyToSymbol()
                和cudaMemcpyFromSymbol()函数

                可以调用函数cudaGetSymbolAddress()查询关联到静态分配的内存上
                的指针      (void **devPtr,char *symbol)

    内存初始化API
        提供1D  2D的内存初始化函数
            cudaError_t cudaMemset(void *devPtr,int value,size_t count);
            cudaError_t cudaMemset2D(void *devPtr, size_t pitch,int vaule,
                size_t width, size_t height);
                pitch指定内存中 每行的字节数

    指针查询：
            函数cudaPointerAttributes()接受一个指针作为参数   并传回一个
                cudaPointerAttributes结构体{
                enum cudaMemoryType memoryType,
                int devide;
                void *devicePointer;
                void *hostPointer;
            }
            当UVA启用 指针在进程内是唯一的  没有启用 输入指针假定为当前设备


    内核查询：
        Sm2. 。。。。查询指针是否指向了全局
            unsigned int __isGlobal(const void *p);


    读写全局内存：
            template<class T>
            __global__ void
            globalWrites(T *out,T value,size_t N)
            {
                for(size_t i = blockIdx.x*blockDim.x+threadIdx.x; i < N;
                  i += blockDim.x*gridDim.x)
                  out[i] = value;
            }

    测试gpu那些什么线程块 情况下 宽带最大 G/s
            程序：
                code/globalRead.cu 一次读
                globalCopy.cu   一次读 一次写
                globalReadTex.cu    一次通过纹理操作的读
                globalCopy2.cu      两次读  一次写
                globalWrite.cu      一次写

            线程模型：
                都是 grid是一位的
                     block是一维的
                     支持任意的大小的gird和block 前提是一维的

                     有限的线程需要搞定无线大的数组 
                        所以每个线程 首先每次运输n个 一组block干完了以后
                        去找对应的下一段 继续干活

原子操作：
        SM1.x慢的离谱
        SM2.x有所提升
        SM3.大幅度全面提升

        支持大多数的原子操作
                 atomicAdd()    


常量内存：
        常量内存是为了多个线程只读类型的广播操作而优化的内存
        可以使用__constant__来声明  访问优化 加快访问速度

        访问常量内存：
            运行时：cudaMemcpyToSymbol()  and  cudaMemcpyFromSymbol() 
                分别赋值数据到常量内存和从常量内存复制数据
                常量内存的指针可以使用 cudaGetSymbolAddress()函数查询
               cudaError_t cudaGetSymbolAddress(void **devPtr,char *symbol);

            驱动API；。。。


本地内存：
        本地内存包括CUDA内核中每一个线程的栈
            作用：容纳寄存器溢出数据    ...
            早期的CUDA硬件中，使用本地内存 速度非常慢
            随着费米架构引入一级缓冲，只要本地内存在一级缓冲就OK
        报告给定内核需要的本地内存数量：
            nvcc -Xptxas    -v,abi=no

        可以使用函数查询：
            cuFunGetAttribute(CU_FUNC_ATTRIBUTE_LOCAL_SIZE_BYTES);

        优化策略：
            增加一级缓存到48K    cudaFuncSetCacheConfig()


共享内存：
        用来在同一线程块内的CUDA线程间交换数据

        使用共享内存的内核由一下过程执行写入
            加载共享内存和__syncthreads()
            处理共享内存和__syncthreads()
            写入结果

        使用nvcc -Xptxas-v,abi=no   报告共享内存使用量

    不定大小共享内存声明：
        内核声明的每个共享内存，都会在启动内核时为线程块自动分配，如果内核
            包含了一个为确定大小的共享内存声明，在内核启动时，该声明数量
            必须指定。
            __shared__ char shardChars[];

内存复制：
        cuda支持：主机与设备    锁页主机和设备或数组 异步内存复制
        点对点内存复制
        

        默认的任何设计主机内存的复制都是同步的  其他都是异步的

统一虚拟寻址：
        统一虚拟寻址使CUDA可以地址范围上的内存类型进行推断
            可以直接复制
            运行时：
             cudaError_t cudaMemcpy(void *dst,const void *src,size_t bytes);
                    
                            

            










