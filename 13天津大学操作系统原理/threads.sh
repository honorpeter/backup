Threads 线程
    进程中的一个执行序列  
    线程的 model
        状态 堆栈状态
        id 
        。。。。
        没有资源信息（资源由进程申请） 

    线程管理方式
    一 进程安排时间 内核不管
        当进程获得时间后
            进程可以设置 每一个线程可以按需的时间
            进程知道每一个 线程的重要性 按需分配
        缺点： 当以线程 阻塞时  内核会 定制 该进程的执行 导致其它线程无法执行
    二 内核循换调度线程 线程表
        可以 解决上面的缺点 但是 没有了 上面的有点
    
   线程共享进程的全局变量 data数据段 共享内存 资源
        当两个线程 同时修改 同一个变量时便会 打架   
            

调度：
    可以对进程进行调度 也可以 对线程 进行调度
    进程分为
            cup密集型（进行大量的计算）  如：视频解码
            IO密集型    
        这两种调度算法 不一样

    系统分为：
            批处理系统 batch systerm
                    一般集群 进行大量的计算 主机分配 任务给其他
                评价：
                    吞吐量
                    cup利用率
                调度策略:
                    First Come First Served
                    Shortest Job First
                    Shortest Remaining-time Next
                    High Response-radio First
                        Response-radio = 1 + Waiting time / Exectute time
                批处理系统  一般不 支持抢占  任务一旦执行 
                    要等到 它执行完 或侧 自动放弃cup
            交互式系统 interactive systerm
                    普通pc电脑
                调度策略：
                    Round-robin scheduling  轮转法
                    Priority scheduling         
                    Muliple queues
                    Shortest process next
                    Guaranteed scheduling
                    Lottery scheduling   彩票 随机算法
                    Fair-share scheduling
                支持抢占
            实时系统
                    一般一直 只执行一个任务
            

