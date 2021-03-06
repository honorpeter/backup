一本学科计算机专业要学的： 并行计算  软件开发测试
进程间通信
    



进程之间的竞争
    操作系统中 资源是有限的 当两个进程 同时使用同一个资源时
        （如 打印机）  便会出现竞争
    虽然cup每次只能执行一个 进程代码  但操作系统 支持进程抢占
        当一个进程想使用打印机的时候 它检查了一个没人用 它刚要用
        就被 内核抢占了 另一个现在运行的进程也使用打印机 就去用了
        当那个进程 醒来的时候 就直接去用会出现 矛盾
进程之间的关系
    互斥：  几个进程同时访问 同一个 临界资源 (可以共享使用 不能同时使用) 
            便是 互斥关系
    同步：  一个进程负责读取数据  一个负责计算读取来的数据
            这样有相互关系的进程 成为同步 

    解决方案
        Busy Waiting 一直去访问 看是否可以使用
            Disabling interrupts
            Lock variatles  
        TSL算法 可以实行  执行的这条语句不能别打断
        Sleep and Wake
            Semaphore 算法
                Semaphore 信号量
                PV 是原子操作 不可被打断
                Semaphore s = 2;  s 附初值是可以使用=号 其他情况下不能
                进行操作 s++（错的）   当进程使用某个资源时 进行pv操作 进来
                时p操作 走时v操作 P s； s自减 在判断s小于0 如果是让该进程sleep
                V s； 自加   再判断 s是否小于等于0 如果是 则叫醒 下一个进程
                    s 等于 正数表示 资源可以用的个数
                    s 等于 负数 表示 等待进程的个数
    解决方案必须满足一下条件
        1 两个进程必须 不能同时拥有临街资源
        2 不能阻塞别的进程进入临界区



进程间通信：    
    五位哲学家
        使用信号量 semaphore

线程之间的互斥和同步：

管道：只能一个写 一个读  单向的  无名管道： 父子才能使用
                                  有名管道： 不相干的进程也可以使用


死锁：
    两个以上进程 同时等待 对方释放资源

    解决方法：
        1 忽略这个问题 不管她 它发生的概率很低      大部分操作系统采取的方法
         检测是否存在死锁： 使用矩阵
                            使用 有向图 资源图 看是否有环
         检测到了：怎么办
            杀死 最年轻的进程

        2 进程图
        3 sbling  一个打印队列 进程直接发送到队列里面就可以 不需要管其他了  

    安全状态：
        银行家算法
    
可抢占资源：
不可抢占资源： 如打印机  绝大多数都是 不可抢占资源
    

