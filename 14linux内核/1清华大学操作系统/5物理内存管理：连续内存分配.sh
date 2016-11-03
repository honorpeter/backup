计算机体系结构/内存层次：
        寄存器
        内存    :最小访问是1个字节8个位     32位一次读写4个字节
                每个字节有一个物理地址可以进行访问
        高速缓冲区：cache   L1 L2  硬件操作 不用软件编写代码
        外存： 磁盘
                每次读取512个字节   扇区

        操作系统的内存管理方式：MMU
            重定位
            分段    数据段 代码段 
            分页:   最基本的单位
            虚拟存储：目前多数系统（如linux）采用按需页式虚拟存储
         地址空间：
                物理空间： 硬件支持 可以直接访问
                逻辑地址： 进程可以看到的地址
                    生成过程： 
                        源代码 编译器编译 汇编代码(里面的函数名还是字符串)
                               汇编编译 机械码    (函数名变为确定的地址)
                               链接      (将程序的代码和函数库连接起来  将函
                                            数库的内容放到程序前面 然后程序
                                            的地址都向后移动一下)
                                加载  （还要重定位）再次平移
                地址生成时机和限制：
                    编译时：
                        假设起始地址已知
                        如果起始地址改变 必须重新编译
                    加载时：
                        如编译时起始位置未知 编译器需要生成可重定位相对位置
                        加载时 生成绝对地址
                    执行时：
                        执行时代码可移动
                        需地址转化 硬件支持

            地址检查：  
                    检查段的长度 和段的偏移量是否合法
        连续内存分配：
                给进程分配一块不小于指定大小的连续的物理内存区域

                内存碎片：
                    外碎片：    进程之间的碎片
                    内碎片：    进程内的碎片
                动态分区分配：  先顺序分配 再分配时 寻找
                    最先匹配
                            找到一个大于的空闲内存
                            释放的时候 看两边有没有空闲的 合并
                    最佳匹配
                            找到大于中的最小的
                            空闲分区按照大小排序
                            遍历所有的内存区域
                    最差匹配：
                            找到最大的

        碎片整理：
                    调整进程内存位置  合并内存空间
                    条件：
                        进程内存可以重定位
                    分区对换：将进程的内存放到外存中
        伙伴系统：
                    连续内存分配  ucore系统实现
                现将内存分配2的1次方2次方3次方。。。几个部分 然后选择那个块
                        进行下面的操作
                    2倍分法  比如有100M空闲 需要6M
                    100/2=50>6
                    50/2=25 >6
                    .....
                    12.5/2=6.5>6
                    6.5/2=3.25<6所以给6.5M给程序
                合并条件：
                    大小相同 2的幂次方
                    地址相邻
                    低地址空闲块起始地址为2的i+1次方
                详见：pic/mem
不连续内存分配：
            进程空间的内存地址不连续
            基本单元：段式分配 页式分配
                段式分配
                页式分配
                断页式分配
            段式存储管理：  数据段 代码段 
                    段地址空间
                    段访问
            80386段机制 
            也是存储管理：
                    页帧：物理地址
                        页的大小是2的n次幂 502 4096
                        标示：页帧号 页内偏移量

                    页面： 逻辑地址
                        标示：页面号 页内偏移量=页帧页内偏移量
                    页面到页帧：
                            页表:通过页表 从页面好找到页帧号
                            MMU/
                    页表：
                            页表基址寄存器 PTBR存放页表的开始地址
                        页表中的内容：
                            帧号：f
                            标志位：
                                    存在位
                                            是否有物理帧和逻辑页对应
                                    修改位
                                            对应的内容是否修改
                                    引用位
                                            最近一段时间是否访问
                            页面太小：
                                    页面数量太多  页表很大
                                    处理方法：
                                        缓存 快表 
                                        间接访问  多级页表
            段页式管理：
                                     参考：天津大学操作系统


                
            
                
                                        

















