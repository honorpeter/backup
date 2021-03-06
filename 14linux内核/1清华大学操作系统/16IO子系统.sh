IO子系统:

IO特点:
      设备接口类型:
            字符设备:
                键盘 鼠标 串口  
                字节为单位 顺序访问 
                IO命令: get() put()等
            块设备
                磁盘
                以一个数据块访问的
                内存映射文件访问
            网络设备
                以太网
                格式化报文交换
                IO命令: send receive 
        同步和异步IO:
            阻塞IO  wait
            非阻塞 IO
            异步IO
IO结构:
        CPU与设备之间的连接
            设备控制器:
                CPU和io设备间的接口
                向CPU提供特殊的指令和寄存器
            IO地址:
                CPU用来控制IO硬件
                内存地址和端口号
                    IO指令
                        通过IO端口号访问设备寄存器
                    内存映射IO
                        设备的寄存器/存储被映射到内存物理地址空间
                        通过内存load/store指令完成IO操作
            CPU与设备的通信方式:
                轮询 设备中断和DMA
        内核IO结构:
            

                        IO子系统:负责缓存 ....
                        软件:  每个设备驱动软件
                        硬件: 键盘 鼠标 .....

IO数据传输
        CPU与设备控制器的数据传输:
            程序控制ＩＯ
                通过CPU的in/out或则load/store传输所有数据
                特点:硬件简单 编程容易
                    消耗CPU时间和数据量成正比
                适用于简单的小型的设备IO
            直接内存访问DMA
                设备控制器可直接访问系统总线
                控制器直接与内存相互传输数据
                IO吞吐量大的

            CPU了解设备状态:
                轮询: 定期检查
                设备中断


磁盘调度:
        寻道时间
        软转延迟
        传输时间

        通过优化磁盘访问请求顺序来提高性能
        先进先出算法:
        最短服务时间优先:
        扫描算法: 电梯算法  
        循环扫描算法:
        C-LOOK:
        N步扫描:
            将磁盘请求队列分层长度为N的子队列
            按FIFO算法一次处理所有子队列
            每个队列里使用 扫描算法
磁盘缓存: 
        放在内存中的数据中的缓存
        单缓存:
            一个缓冲区  CPU和设备只能一个操作缓冲区
        双缓存:
            两个缓冲区

        访问频率置换算法: LRU LFU
            栈 分为三步分  
                新区域
                中间区域
                旧区域
            









