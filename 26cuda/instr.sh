1.什么是CUDA:
           CUDA(Compute Unified Device Architecture)，统一计算架构，是
                NVidia推出的并行计算平台
                一个并行计算平台和简单（简洁）地使用图像处理单元（GPU）
                        进行通用计算的编程模型
2.为什么要用到CUDA:
         CPU主频要比GPU高2-3倍左右，但是通常情况下GPU核心的数量要比CPU多
                2-3个数量级以上。因此GPU的计算能力要远大于CPU
                CUDA可以直接使用C/C++语言来开发GPU程序
3.CUDA环境搭建:
        CUDA环境主要分为四点：硬件（GPU设备）、操作系统、
                    C/C++编译器和CUDA工具包。

第一个CUDA程序:
       .....

5. CUDA编程:
        5.1. 基本概念:
             CUDA编程中需要注意一些基本概念，分别为：主机、设备、运行时API、
             驱动API、warp、bank、函数类型限定符、变量类型限定符、thread、
             block、grid、计算能力、SIMT、内置变量、纹理、CUDA数组等。

                    主机：可理解为CPU与内存的组合。

            设备：可理解为GPU与显存的组合。
            运行时API：是指CUDA运行时API是在驱动API的基础上封装而成的，
                    简化了CUDA的开发。
            驱动API：是指CUDA驱动API，相比运行时API更接近于设备，可灵活运
                用设备的特性开发CUDA，可实现运行时API无法实现的功能。
            warp：多处理器激活、管理、调度和执行并行任务的单位。计算能力2.x
                的设备warp为32个线程。未来的设备可能不同，可以通过内置变量
                warpSize查询。
            bank：为了获得较高的存储器带宽，共享存储器被划分为多个大小相等的
                存储器模块，称为存储体，这些存储体就叫bank，可同步访问。
            函数类型限定符：是CUDA C中特有的，用来修饰是主机函数，设备调
                用的设备函数，还是主机调用的设备函数。有__device__、
                __global__、__host__。
            变量类型限定符：是用来修饰设备变量的。有__device__、
                __constant__、__shared__。
            thread：设备中的线程，与主机中的线程是同一个概念。
            block：线程块，由一组线程组成。一个线程块中的所以线程会在同一
                个多处理器上执行，一个多处理器上可同时执行多个线程块。
            grid：有所有线程块组成的网格。
            计算能力：是NVidia GPU不同架构的计算能力。
            SIMT：单指令多线程，与单指令多数据（SIMD）类似。一条指令多个
                线程一同执行，实现程序的并行化。
            内置变量：有threadIdx、blockDim、blockIdx、gridDim、warpSize。
                其中threadIdx指此线程在线程块中的位置；blockDim指线程块维度
                blockIdx指该线程块在网格中的位置；gridDim指线程块网格维度；
                warpSize指一个warp多少个线程。
            纹理：本文主要涉及到的是纹理参考、纹理绑定、纹理获取。
            CUDA数组：区别于线性存储器，对数据进行了对齐等的处理，包括一维、
                二维和三维。其中的数据为：一元、二元或四元组。
    5.2. 线程层次结构:
        CUDA线程的层次结构，由小到大依次为线程、线程块、线程块网格
    5.3. 存储器层次结构:
        CUDA存储器有：寄存器、共享存储器、常量存储器、本地存储器、
            全局存储器、纹理存储器等。其中寄存器和本地存储器是线程私有的，
            共享存储器是对线程块中的所有线程可见，常量存储器、全局存储器和
            纹理存储器是对网格中所有线程可见。
        NVidia GPU的硬件结构是，一组流处理器组成一个多处理器，一个或多个多
            处理器组成一个GPU。其中流处理器，可以理解为处理计算的核心单元。
            多处理器类似于多核CPU。NVidia GPU从DX10（DirectX10）开始出现了
            Tesla、Fermi、Kepler架构，不同的架构多处理器中流处理器数量都有
            差别。
    5.4. 运行时API:
         运用运行时API开发CUDA程序需要了解：初始化、设备管理、存储器管理、
            流管理、事件管理、纹理参考管理、OpenGL互操作和Direct3D互操作。
        初始化:
            运行时API不存在显示初始化函数，初始化会在首次调用运行时函数时
                完成。虽然不需要调用初始化函数进行初始化，但是退出时需要调
                用退出函数cudaThreadExit()释放资源。
        设备管理:
            有些电脑上可能有多块设备，因此对于不同的要求选择合适的设备。
                设备管理主要是获取设备信息和选择执行设备。

            主要有三个函数：
                ·cudaGetDeviceCount()：得到电脑上设备的个数。
                ·cudaGetDeviceProperties()：获得对应设备的信息。
                ·cudaSetDevice()：设置CUDA上下文对应的设备。
            运行__global__函数前需要提前选择设备，如果不调用cudaSetDevice()
                函数，则默认使用0号设备。

            上面三个函数的具体用法请查看CUDA运行时API文档。
        存储器管理:
            共享存储器、常量存储器、线性存储器和CUDA数组的使用是存储器管
                    理的主要部分。
            共享存储器:
                共享存储器，使用__shared__变量限定符修饰，可静态或动态分配
                    共享存储器。
                静态分配共享存储器，是在设备代码中直接分配共享存储器的大小
                    #define SHARED_MEM 16  
                    __global__ void kernel(…)  
  
                    {  
                        __shared__ int shared[SHARED_MEM];  
                    }  
                    void main()  
                    {  
                        kernel<<<nBlock, nThread>>>(…);  
                    } 
                动态分配共享存储器，是在主机代码中使用内核函数的第三个特定参
                        数传入分配共享存储器的大小
                    #define SHARED_MEM 16  
                    __global__ void kernel(…)  
                    {  
                        extern __shared__ int shared[];  
                    }  
  
                    void main()  
                    {  
                        int nSharedMem = (int)SHARED_MEM;  
                        kernel<<<nBlock, nThread, nSharedMem*sizeof(int)>>>(…);  
                    } 
            常量存储器:
                常量存储器，使用__constant__变量限定符修饰。使用常量存储器
                    是由于其在设备上有片上缓存，比全局存储器读取效率高很多。
                使用常量存储器时会涉及的运行时API函数主要有：
                    ·cudaMemcpyToSymbol()
                    ·cudaMemcpyFromSymbol()
                    ·cudaGetSymbolAddress()
                    ·cudaGetSymbolSize()
                主机代码中使用cudaGetSymbolAddress()获取__constant__或
                    __device__定义的变量地址。设备代码中可通过提取
                    __device__、__shared__或__constant__变量的指针获取变量
                    地址。
            线性存储器:
                线性存储器是使用cudaMalloc()、cudaMallocPitch()或
                cudaMalloc3D()分配的，使用cudaFree()释放。二维的时候建议使
                用cudaMallocPitch()分配，cudaMallocPitch()函数对对齐进行了
                调整。这三个分配函数对应cudaMemset()、cudaMemset2D()、
                cudaMemset3D()三个memset函数和cudaMemcpy()、cudaMemcpy2D()、
                cudaMemcpy3D()三个memcpy函数。
            CUDA数组:
                CUDA数组是使用cudaMallocArray()、cudaMalloc3DArray()分
                    配的，使用cudaFreeArray()释放。
    5.4.4. 流管理:
            主机设备之间的内存拷贝与内核在设备上执行是异步的。在不使用流的
                情况下，是这样执行的：设备先从主机上拷贝内存，拷贝完成之后
                再在设备上执行内核代码计算，最后当内核执行完毕，再把设备上
                的内存拷贝到主机上。
                当使用两个流的情况下，0号流执行内核代码的同时1号流拷贝主机
                内存到设备，1号流执行的同时0号流拷贝设备内存到主机 （具体的
                实现并不一定如此，这里是为了说明流的作用简单做了假设）。
                两个流的情况下，部分内存拷贝和内置执行是同时进行的（异步的）
                比同步的内存拷贝和内核执行节省了时间。

            与流有关的函数有：
                ·cudaStreamCreate()：流的创建；
                ·cudaStreamDestroy()：流的销毁；
                ·cudaStreamSynchronize()：流同步；
                ·*Async：与流相关的其他函数。
                内核<<<…>>>的第四个参数为哪个流。
                CUDA编程指南中有对流具体实现的讲解。
        5.4.5. 事件管理:
              由于部分CUDA运行时函数的执行与主机代码是异步的。在一块代码中
              CUDA运行时函数执行没有结束就直接执行其后的主机代码了，主机并
              不知道已经执行到哪个CUDA运行时函数了。事件的引入就是为了解决
              这一问题，在CUDA运行时函数已经执行完毕后记入下事件，查询此事
              件是否记录就能知道那个CUDA运行时函数已经执行完毕。在CUDA运行
              时函数前后记入事件就能获得此函数执行的时间。
                     与事件有关的函数有：
                        ·cudaEventCreate()：事件的创建；
                        ·cudaEventDestroy()：事件的销毁；
                        ·cudaEventRecord()；记录事件；
                        ·cudaEventSynchronize()：事件同步；
                        ·cudaEventElapsedTime()：计算两事件的时间差。
                    具体的实现请查询CUDA编程指南。

            

            


        









