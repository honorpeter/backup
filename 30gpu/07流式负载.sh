流式负载：
        是每个数据元素可以被独立的计算的任何，它是可以移植到CUDA中的简单的
            负载。

        为了提高程序的性能，使用saxpy函数作为例子
            stream1Device.cu  修改带模板 去掉模板 提供传输性能

            异步内存复制：stream2Async.cu

    流 使用多个流 来提高性能 
        stream3Streams.cu
    使用映射锁页内存 stream4Mapped.cu







