GPU架构：
        特斯拉： 
        费米架构：
        开普勒架构：

同一寻址：
    在费米架构或者更高的gpu寻址是 64位  这样就可以同一寻址了
        CUDA 4.0 增加了一个叫做统一虚拟寻址的特性UVA
        支持UVA的系统会自动开启UVA， linux windows都支持UVA
点对点映射：
        可以是费米架构的GPU读取另一个费米架构的GPU的内存，仅支持开启UVA的
                平台        
        点对点映射是非对称的  我可以看到你 你不可以看到我

CPU和GPU交互：
        锁页主机内存：  GPU可以直接访问CPU内存
                    GPU可以通过DMA方式 直接访问CPU锁页内存（不可换出到硬盘）
                    可以通过 cudaMallocHosst()来分配

        命令缓冲区：    由CUDA驱动程序写入命令，GPU从此缓冲区读取命令并控制
                            其执行
                    CPU将命令写入一个供GPU消耗的 命令缓冲区 与此同时 GPU读取
                            并执行先前写入的命令
        CPU GPU同步：  CPU如何跟踪GPU的进度
                    GPU 本身必须给CPu汇报工作进度
                    命令缓冲区和 “同步位置”（存在锁页主机内存中）
                    如果有CPU写入的命令8之后 紧接着是cudaThreadSynchronize
                        函数那么驱动程序将一直等待，知道共享同步只大于或等于
                        8




nvcc  与 PTX ：
        nvcc 编译器
        PTX： 并行程序执行
            是编译后的GPU代码的一种中间形式，它可以再次编译为原声的GPU微码
            PTX可以离线或在线的方式编译为微码

设备与初始化：
        设备数量：
            调用cuDeviceGetCount（）或cudaGetDeviceCount（）查询
        设备属性：cuDeviceComputeProperties（）函数
            返回结构体：cudaDeviceProp

上下文：
        管理CUDa程序中所有对象生命周期的容器
            所有内存分配
            模块
            CUDA留
            CUDA事件
            文理与表面引用
            使用本地内存 。。。。调试 同步。。。

    当前上下文：
            为了代替当前上下文 栈  CUDa运行时提供cudaSetDevice（）
                为调用的线程设置当前上下文
                一个设备可以是多个CPU线程的当前上下文

软件：
        nvcc 有很多选项

        ptxas   PTX汇编工具
            ptxas是吧PTX编译成指定的GPU微码工具
            nvcc调用ptxas  有多参数

            开发人员可以通过调用cuModuleLoadDataEX（）动态的加载PTX代码
            CUresult cuModuleLoadDataEX(
                CUmodule *module;
                const void *image;
                unsigned int numOptions,
                CUjit_option *options,
                void **optionValues
            );


        cuobjDump:
            用与检查CUDa所生成的二进制文件的实用工具 可以用于检查nvcc生成
                的微码   指定nvcc的 --cubin产生文件.cubin
                然后  用  cuobjdump --dump-sass filename.cubin
                从.cubin文件中转存为反汇编的微码
        nvidia-smi 系统管理接口
            --lsit-gpus
            --loop=     在指定的时间按间隔进行检查







