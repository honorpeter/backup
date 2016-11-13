ROS系统的架构主要被设计为三个部分： 没一部分都代表一个层级的概念
    文件系统级
            ROS的内部构成   文件夹结构  工作所需的核心文件
    计算图级
            进程和系统之之间的通信
    开源社区级
            一系列的工具和概念

理解ROS文件系统级：
                            文件系统

                            功能包集       功能包集清单

                            功能包

                功能包清单      消息    服务    代码    其他

        一个ROS程序的不同组件要放到不同的文件夹下，文件夹是根据功能的不同来
            对文件进行组织的。
        功能包：    是ROS中软件组织的基本形式。具有最小的结构和最少的内容
                    用户创建ROS程序 可以包含ROS运行的进程 配置文件
                工具：
                    rospack

        功能包清单：
                提供关于功能包，许可信息，依赖关系，编译标志等信息
                是一个manifests.xml文件 通过文件能够实现对功能包管理
                rosstack
        功能包集：
                如果你将几个具有某些功能的功能包组织在一起，那么就是一个功能
                    包集。例如导航功能包集
        功能包集清单：
                stack.xml提供一个关于功能包集清单。包括开源代码许可信息 
                    功能包集依赖关系
        消息类型：
                消息是一个进程发送到其他进程的信息。ROS中有很多标准类型消息
                    消息类型的说明存储在my_package/msg/MyMessageType.msg中
        服务类型：
                定义了服务的请求和响应的数据类型  说明存储在my_package/srv
                    /MyServiceType.srv中

    工具： 为了创建 修改或使用功能包：
            rospack 使用此命令来获取信息或在系统中查找功能包
            roscreate-pkg   创建一个新的包 使用
            rosmake 编译
            rosdep  安装系统依赖
            rxdeps  功能包的依赖图
        若要在文件夹和功能包之间移动文件 
            roscd   该目录
            rosed   编辑文件
            roscp   拷贝
            rosls   列出


    功能包集：
        必须包含的三个文件： CMakeList.txt  Makefile stack.xml


    消息类型：
        消息类型必须包含两个主要部分：
            字段和常量      
            字段定义了要在消息中传输的数据类型 例如int32    float32 string

    服务类型：
        



理解ROS计算图级：
       ROS会创建一个连接到所有进程的网格。在系统中的任何节点都可以访问此网络
            并通过该网络与其他节点交互 获取其他节点发布的信息，并将自身数据
            发送到网格上。
        
            节点    节点管理器      参数服务器      消息
                    
                            计算图级


                    主题    服务        消息记录包

        节点：
            节点是主要的计算执行进程。 如果你想要有一个可以与其他节点进行
                交互的进程，那么你需要创建一个节点，并将此节点连接到ROS网络
                节点需要使用如roscpp或rospy的ROS客户端库进行编写
            节点都是各自独立的可执行文件。 在系统必须有唯一的名称。
            节点工具：
                rosnode：用于显示节点信息的命令
                    rosnode info node
                    rosnode kill node
                    rosnode list
                    rosnode machine hostname列出某一特点计算机上运行的节点
                    rosnode ping node
                    rosnode cleanup 将无法访问节点的注册信息清楚
                启动节点时，改变参数
                    改变主题的
                    rosrun book_tutoirals tutorialX topic1:=/level1/topic1

                    改变参数：
                    rosrun book_tutoirals tutorialX _param:=9.0
                系统保留关键字：
                    _name   节点名字
                    _log    节点日志存储地址
                    _ip_hostname
                    _master
                    _ns

        节点管理器：
            用于节点的名称注册和查找， 在整个ROS系统中没有节点管理器，那就
                不会用节点，服务，消息之间的通信。
            roscore命令运行
        参数服务器：
            能够使数据通过关键字存储在一个系统的核心位置，通过使用参数，能够
                在运行时 配置节点或改变节点的工作任务。
            可以通过网络访问的共享的多变量字典，节点使用它来存储和检索运行
                时的参数。
            工具：
                rosparam    list
                            get parameter
                            set parameter value
                            delete parameter
                            dump file   将参数保存到一个文件
                            load file

        消息：
            节点通过消息完成彼此间的沟通。
            一个节点通过特定主题发布消息。
            工具：rosmsg
                rosmsg  show    显示一条消息的字段
                        list
                        package 列出功能包的所有消息
                        users
                        md5

        主题：
            是由ROS网络对消息进行路由和消息管理的数据总线。每一条消息都要
                发布到响应的主题。档一个节点发送数据时，我们就说该节点正向
                主题发布消息。 节点通过订阅某个主题，来接收来自其他节点的
                消息。主题的名词必须是唯一的
            每个主题都是强类型的，发布到主题上的消息必须与主题的ROS消息类型
                相匹配，并且节点只接收类型匹配的消息。
                可以使用TCP（默认的）和UDP传输。 TCPROS UDPROS
            工具： rostopic
                rostopic bw /topic  显示主题所使用的带宽
                rostopic echo /topic
                rostopic find message_type
                rostopic hz /topic  显示主题发布率
                rostopic info /topic
                rostopic list
                rostopic pub /topic type args 将数据发布到主题
                rostopic type /topic  输出类型

        服务：
            在发布主题时，正在发送的数据能够以多对多的方式交互。当你需要从
                一个节点活取一个请求或应答时，就不需要通过主题来实现。通过
                服务，五福允许直接与某个节点进行交互。必须有唯一的名称。
            工具：
                rossrv  rosservice
                rosservice  call /service args  根据命令行调用参数服务
                            find msg-type   根据服务类型查询
                            info /service
                            list
                            type    /service  服务类型
        消息记录包：
            一种用于保存和回放ROS消息数据的文件格式。它可以获取并记录各种
                难以收集的传感器数据。
            是由ros创建的一组文件，它使用.bag格式保存消息，主题，服务和其他
                ros数据信息。
            工具：
                rosbag  录制 播放   和执行其他操作
                rxbag   可视化图形环境中的数据
                rostopic    节点发送的主题


工作空间：
        变量：$ROS_PACKAGE_PATH
            如果想加入新的目录 向path一样 直接加在后面
创建包：
        roscreate-pkg chapter2_tutorials std_msgs rospy roscpp
                        包名称              依赖    依赖    。。。。
    编译包：
        rosmake chapter2_tutorials

启动：  roscore
节点：
        启动新节点
            rosrun turtlesim turtlesim_node
        然后可以使用主题交互。。。
    
        
             










