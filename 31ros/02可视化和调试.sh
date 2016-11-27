调试：
        使用gdb调试：
            roscd chapter3_tutorials
            gdb bin/example1    就可以调试了

        ros节点启用时调用gdb调试器
            可以通过使用XML语法修改启动文件爱你中的节点属性
            添加launch文件  xml文件
            <launch>
            <node pkg="chapter3_tutorials" type = "example1" 
                    name="example1" output="screen" 
                    launch-prefix="xterm -e gdb --args"/>
            </launch>
            pkg:报名    type：节点名    name： 节点实例
            screen:这些属性输出到屏幕
            调试：launch-prefix="xterm -e gdb --args"

            还可以加入valgrind启动前缀。 详细看 code/launch

    设置ros节点core文件转存：
            首先 取消core文件大小限制：
                ulimit -c unlimited
            将core文件名设置为默认使用的进程pid
                echo 1 > /proc/sys/kernel/core_uses_pid

调试信息：
        输出调试信息：
            ROS_INFO("My INFO message");
            注意：只有主要的ros头文件包括在内，就OK  可以添加ros/console.h
        设置调试信息级别：
            ros有五个调试级别：
                顺序 :  DEBUG   INFO    WARN    ERROR   FATAL

                DEBUG和INFO信息输出到stdout
                WARN    ERROR和FATAL   会输出到stderr
                DEBUG是绿色 INFO是白色  WARN黄色    ERROR红色  FATAL紫色

        为特定节点配置调试信息级别：
            1 在main函数中修改 重新编译
            2 使用宏
            3 使用配置文件 灵活 launch/example1.launch

        信息的更多功能  单次显示  可调  组合
            ROS_<LEVEL>[_STREAM]_ONCE[_NAMED]
            ROS_INFO_STREAM_ONCE()只输出一次
        使用rosconsole和rxconsole在运行时 修改调试级别  rqtconsole
            在一个中断打开rxconsole 出现图形截面 可以看 现在的版本好像没有了
            也可以使用rosconsole

监控系统状态：
        当系统运行时，可能有数个节点和数十个主题在发布消息
        检测节点状态图中任何节点发生的功能失效，使用主题来连接节点展示系统
            架构的状态。

        使用rxgraph rosgraph    rqt_graph(代替了rxgraph)

当奇怪的事情发生，使用roswtf
        检测给定功能包中所有组件的潜在问题， 使用roscd移动到想要分析的包中
            运行roswtf 

画标量数据图：
        使用rxplot  rqt_plot画出时间趋势曲线
            退欲temp主题 以Int32数据格式
                rqt_plot /temp/data

图像可视化：
        我们可以创建一个节点，在节点中展示来自摄像头的图像

    Visualizing a single image:
        command:
            rosrun image_view image_view image:=/camera
                image_view node which shows the images in the given topic 
                    (the image argument) in a window
                rqt_image_view , which supports viewing multiple images 
                    in a single window but does not allow the saving of 
                    images by pressing the right-hand side button.

3D visualization:
    devices:
        stereo cameras, 3D lasers, the Kinect sensor
            provide 3D data—usually in the form of point clouds

    rviz or rqt_rviz    command
        With roscore running, start rqt_rviz with
            rosrun rqt_rviz rqt_rviz




Saving and playing back data:
        ROS can save all the messages published on any topic    bag files

        Recording data in a bag file with rosbag:
            first run some node
                rosrun chapter3_tutorials example4
            two options:
                record all the topics:
                    rosbag record -a
                record only specific topics:
                    rosbag record /temp /accel
        By default, when we run the above command, the rosbag program 
            subscribes to the node and starts recording the message in a 
            bag file in the current directory with the data as the name.

    call to rosbag record into a launch file:
            <node pkg="rosbag" type="record" name="bag_record"
                    args="/temp /accel"/>

    Playing back a bag file:
        First:  roscore running
        Second: move to the folder with the bag file we want to play
        Third:  rosbag play 2014-07-01-22-54-34.bag(bag file name)


        rosbag info <bag_file> 
        rqt_bag                 可以查看属性 等

Using the rqt_gui and rqt plugins:
        rosrun rqt_gui rqt_gui
        调出来所有的插件 供你选择
        


            














