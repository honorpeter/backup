CPU/GPU并发  隐藏驱动程序开销：
    内核启动：
        默认的内核的启动是异步的
            nullKernelAsync.cu  测试空内核启动的时间的程序 内核异步启动
                本机 10us左右
            结果：调用一个内核甚至什么都不做的内核将话费2~8毫秒的时间

            nullKernelSync.cu  内核同步 启动 
                                启动一个内核 执行完后 才能执行 下一个内核
                本机结果22us

        即使不进行同步操作，如果内核运行时间不比内核启动所花的时间长，GPU
            可能会在CPU提交更多工作之前 闲置
            为了知道一个内核需要做多少工作才能使启动内核是值得的
                
异步的内存复制：
        主机端到设备端：
            nullHtoDMemcpyAsync.cu文件 测量每个内存复制开销
            breakevenHtoDMemcpy.cu 测量不同大小内存复制 开销
                斜率差不多是PCIIe2。0理论值 

        设备到主机
            ...
        code中还有 同步操作的测量函数

CUDA事件：CPU/GPU同步
        CUDA事件的主要特点之一是： 可以支持部分CPU/GPU同步，在完整的同步中
            CPU要一直等待GPU空闲，  在部分同步中，CUDA事件可以被记录到GPU
            命令的异步流中
            pageableMemcpyHtoD.cu

    阻塞事件：

    查询事件：
        CUDA流和事件可以同cudaStreamQuery() cudaEventQuery()查询

CUDA事件：计时
    。。。

    流水线 工作         具体 不会写代码

映射锁页内存：
    。。。。。  不会

并发内核处理：
    SM2.x架构和更高的gPU架构 可以并发有运行多个内核，只要他们在不同流中被
        启动的并且有适当大小的内存块的话


GPU/GPU同步：
    多GPU的流与事件：
        流和事件存在于上下文的作用域中，当调用cuCtxDestroy() or cudaDeviceReset()
            事，相关的流和事件就会被破坏
        内核启动和cudaEventRecord()仅能在同一个上下文/设备中使用CUDA流
        cudaMemcpy（）可以从任何流调用
        cudaStreamWaitEvent（）可以使用任何流 被任何事件调用

        


        


                









