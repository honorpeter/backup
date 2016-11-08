多GPU：
    
概论：
    多GPU系统通常包含多个GPU主板
    许多属于多GPU的CUDA功能，例如点对点寻址，要求这些GPU具有相同的规格
    对所有使用多GPU的CUDA应用来说，可分享锁页内存是关键因素

    
点对点机制：
    点对点内存复制：
        当UVA起作用时，鉴于CUDA可以推断出每个设备的节点内存，使用普通的内存
            复制函数族即可实现点对点的内存复制
        而如果UVA没有启动，点对点内存复制必须显示调用cudaMemcpyPeer() ....

        点对点内存复制操作无法与其他操作并行处理，点对点内存复制操作想要开始
            必须保证GPU之前的等待操作全部完成；点点复制之后才能进行其他操作

    点对点寻址：
        使得一个GPU上的内核可以读写驻留在另一个GPU上的内存。 以PCLe速率读取

        要求：启用了UVA
            双端的GPU的计算能力必须SM2.x更高  必须同等芯片
            GPU必须位于相同的IO集线器
        可以调用cudaDeviceCanAccessPeer()来查询设备是否可以与另一个设备的
            内存进行映射
            cudaError_t cudaDeviceCanAccessPeer(int *canAcessPeer,intdevice,
                int peerDevice);
        点对点映射默认不启用，必须明确调用，cudaDeviceEnablePeerAccess()
            cudaError_t cudaDeviceEnablePeerAccess(int peerDevice,
                unsigned int flags);

        可以调用cudaDeviceDisablePeerAccess()来终止点对点映射

        点对点的内存寻址是不对称的，为了让两个GPU互相访问对方，每个GPU都
            必须显示的调用

UVA从地址推断设备：
        可以使用
            cudaPointerGetAttribute()函数查询UVA指针信息

多GPU之间的同步：
        CUDA 事件可以使用 cudaStremWaitEvent()函数对多个GPU进行同步。如果在
            两个GPU之间存在生产者/消费者关系，应用程序可以让生产者GPU记录
            一个事件，然后消费者GPU在他的命令流中插入一个流等待事件。当消费
            者GPU遇到流等待，它将停止处理命令，直到生产者GPU越过了
            cudaEventRecord()被调用的执行点
            cudaError_t chMemcpyPeerToPeer(
                void *_dst, int dstDevice,
                const void *_src, int srcDevice,
                size_t N )
            {
                cudaError_t status;
                char *dst = (char *) _dst;
                const char *src = (const char *) _src;
                int stagingIndex = 0;
                while ( N ) {
                    size_t thisCopySize = min( N, STAGING_BUFFER_SIZE );
                        cudaSetDevice( srcDevice );
                    cudaStreamWaitEvent( 0, g_events[dstDevice][stagingIndex],0);
                    cudaMemcpyAsync( g_hostBuffers[stagingIndex], src,
                        thisCopySize, cudaMemcpyDeviceToHost, NULL );
                    cudaEventRecord( g_events[srcDevice][stagingIndex] );
                    cudaSetDevice( dstDevice );
                    cudaStreamWaitEvent( 0, g_events[srcDevice][stagingIndex],0);
                    cudaMemcpyAsync( dst, g_hostBuffers[stagingIndex],
                        thisCopySize, cudaMemcpyHostToDevice, NULL );
                    cudaEventRecord( g_events[dstDevice][stagingIndex] );
                    dst += thisCopySize;
                    src += thisCopySize;
                    N -= thisCopySize;
                    stagingIndex = 1 - stagingIndex;
                }
                // Wait until both devices are done
                cudaSetDevice( srcDevice );
                cudaDeviceSynchronize();
                cudaSetDevice( dstDevice );
                cudaDeviceSynchronize();
                Error:
                    return status;
            }

单线程多GPU方案：
    一个单线程应用可以驱动多个GPU。CPU线程通过调用cudaSetDevice()来指定欲
        控制的GPU

    当前上下文栈：
        驱动程序API的引用程序可以使用单前上下文栈管理当前上下文 
        cuCtxPushCurrent()函数使得一个新的上下文成为当前上下文，并把他压入到
            栈顶；cuCtxPopCurrent()弹出当前上下文，并恢复前一个上下文


N体问题：
    

多线程多GPU方案：
        CUDA4.0以前 每个GPU都必须由单独的CPU线程控制
        实现一个多线程多GPU的N体问题

             
        
            











