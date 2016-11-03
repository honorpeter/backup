文件系统概念:
        文件系统是操作系统中管理持久数据的子系统 提供数据存储和访问功能
        文件是文件系统的基本的单位

        文件系统的功能:
            管理文件块:
            管理空闲空间:
            分配算法:
            管理文件集合:
                定位:文件及其内容
                命名:通过名字找到文件
                文件系统结构:文件 组织方式
            数据可靠和安全:
                安全:多层次保护数据
                可靠:
                    持久保存文件
                    避免系统崩溃 媒体错误 攻击
            文件属性:
                名称 类型 位置 大小 保护 创建者 创建时间 最近修改时间
            文件头: 文件系统元数据中的文件信息
                文件属性 
                文件存储位置和顺序

        文件描述符:
            操作系统在打开文件表中维护的打开文件状态和信息
            信息内容:
                文件指针:
                    最近一次读写位置    每个进程分别维护自己的打开位置
                文件打开计数:
                    当前打开文件的次数  
                    最后一个进程关闭文件时 将其从打开文件表中删除
                文件的磁盘位置:
                    缓存数据访问信息
                访问权限:
                    每个进程的文件访问模式信息

        文件的用户视图和系统视图:
                用户视图:
                    持久的数据结构
                系统访问接口:
                    字节序列的集合
                    系统不关心存储在磁盘上的数据结构
                    数据块的集合
                进程读文件:
                    活取字节所在的数据块
                    返回数据块内对应部分
                进程写文件:
                    读数据块  
                磁盘的读写是 块 最小单位

        访问模式:
                顺序访问:
                    按字节一次读取
                        大多数 都是
                    随机访问:
                        从中间读写
                    索引访问:
                        一句数据特征索引
                        通常系统不完整提供索引访问
                        数据库是建立在索引内容的磁盘访问上
        文件内部结构:
                无结构:
                    单词 字节序列
                简单记录结构:
                    分列
                    固定长度
                    可变长度
                复杂结构:
                    格式化的文档 word PDF
                    可执行文件
                    ......
        文件共享和访问控制:
                多用户系统中的文件共享是很必要 的
                访问控制:
                    每个用户能够获得那些文件的那些访问权限
                    访问模式: 读 写 执行  删除 列表
                文件访问控制列表:
                    文件实体 权限
                    
                    Unix模式:
                        用户 | 组 | 所有人 , 读|写|可执行
                        用户标识 ID 
                            识别用户表明每个用户所允许的权限和保护模式
                        组标识ID
                            允许用户组成组 指定访问权限
        语义一致性:
            规定多进程如何同时访问共享文件:
                与同步算法相似
                因磁盘IO和网络延迟而设计简单
            Unix文件系统UFS 语义:
                对打开文件的写入内容立即对其他打开同一文件的用户可见
                共享文件指针允许多用户同时读取和写入文件
            会话语义:
                写入内容只有当文件关闭时可见
            读写锁:
                一些操作系统的文件系统提供该功能

        分层文件系统:
            文件以目录的方式组织起来
            目录是一类特殊的文件
                目录的内容是文件索引表 文件名 指向文件的指针
            目录和文件的树形结构:
                
            硬连接:
            软连接:
            文件目录中的循环:  
                如何保证没有循环:
                    只允许到文件的连接 不允许在子目录的连接
                    增加连接时 用循环检查算法确定是否合理
                    限制 目录搜索长度
            名字解析:
                把逻辑名字换成物理资源
                依据路径名 在文件系统中找到实际文件位置
                遍历文件目录知道找到文件
            当前工作目录:
                每个进程都会指向一个文件目录用户解析文件名
                也就是 相对目录
        文件系统挂载:
                将一个 文件系统挂接到另一个文件系统的目录中
        磁盘文件系统:
                文件存储在数据存储设备上 如磁盘 FAT NTFS ext2
        数据库文件系统:
                是可被寻址的  如WinFS
        日志文件系统:
                记录文件系统的修改 /时间 
        网络/分布式文件系统
                NFS SMF
            共享协议:
                NFS for unix  CIFS for windows
                NFS是不安全的
        特殊 / 虚拟文件系统:
                管道

虚拟文件系统:
        目标: 对所有不同文件系统的抽象
        功能:提供相同的文件和文件系统接口 API

文件系统基本的数据结构:
        文件卷控制块:   superblock
            每个文件系统一个
            文件系统详细信息
            块 块大小 空余块 计数/指针...
        文件控制块: vnode
            每个文件一个
            文件详细信息
            访问权限 拥有者大小 数据块位置
        目录项:
            每个目录项一个   对应 一个文件或目录
            将目录项数据结构及属性布局编码成属性数据结构
            指向文件控制块 父目录 子目录

        文件系统的存储结构:
            持久存储在外存中
        当需要时加载到内存:
            卷控制块:  当文件系统挂载时 进入内存
            文件控制块: 当文件被访问的时候 进入内存
            目录节点:  在遍历一个文件路径时 加入到内存

文件缓存和打开文件管理:
        多种磁盘缓冲位置:
            磁盘    磁盘控制器(就有缓存)  内存 内存虚拟盘
                                               打开文件表
                                               数据块缓存

            数据块缓存:
                
            页缓存: 统一缓存数据块和内存页

        文件系统中打开文件的数据结构:
                每个被打开的文件都有一个文件描述符
                文件状态信息:
                    目录项 当前文件指针 文件操作设置等..
                系统打开文件表: 共有的部分
                进程打开文件表: 每个进程 独特的部分

        打开文件锁:
            强制:   根据文件状态 来操作系统决定是否访问
            劝告:   进程自己决定怎么做 进程可以询问文件状态

文件分配:
        分配给一个文件数据块的位置和顺序
        分配方式:
            连续分配:
                ......
            链式分配
                    链表表示
            索引分配:
                    指针 存放指针
            UFS多级索引分配: unix系统分配 算法....


空闲空间管理和冗余磁盘陈列:
        使用什么数据结构表示 空闲数据块列表
         
        位图: 0表示空闲 1 反之      100111000101
        链表: 
        链式索引:

        冗余磁盘阵列:
            多种磁盘管理技术:
            RAID分类
                RAID-0  RAID-1 RAID-5

                RAID-0  提高读写速度
                RAID-1 提高可靠性
                RAID-4 带校验的磁盘
                RAID-5 带分布是校验和
            实现:
                软件:操作系统内核的文件卷管理
                硬件:RAID硬件控制器


ucore文件系统架构:
        Apps    Apps    Apps
            FS syscall接口
                VFS
               SimplesFS
                IO接口
        ----------------------
            superblock  root-dir inode  freemap inode/file data
                    硬盘

        








