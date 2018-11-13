两种管理方式：
    catkin：   复杂功能强大
        mkdir -p wp/src
        cd ..
        catkin_make
            会生成 build  devel文件夹

    进入当前的工作空间：
        source devel/setup.bash

    export | grep ROS   参看当前工作空间变量

    rosbuild：  功能简单  
        穿件工作区
            rosws init ~/fuerte_workspace /opt/ros/fuerte
                    ws( sudo apt-get install python-rosinstall)
            mkdir ~/fuerte_workspace/sandbox
            rosws set ~/fuerte_workspace/sandbox            
            source ~/fuerte_workspace/setup.bash
    
ROS文件系统介绍:
    快速了解文件系统概念:
        Packages: 软件包，是ROS应用程序代码的组织单元，每个软件包都可以包含程序库、可执行文件、脚本或者其它手动创建的东西。

        Manifest (package.xml): 清单，是对于'软件包'相关信息的描述,用于定义软件包相关元信息之间的依赖关系，这些信息包括版本、维护者和许可协议等。

    rospack: 操作对象是package  软件包
        rospack允许你获取软件包的有关信息。
        rospack find 名称
        roscd 本地包名称/子目录

    系统变量：
        $ROS_PACKAGE_PATH  这个变量可以包含多个类似PATH

    roscd log   切换到log目录

    rosls
    Tab 自动完成输入

    创建ros软件包：
        cd ~/catkin_ws/src
        catkin_create_pkg beginner_tutorials std_msgs rospy roscpp
                穿件beginner----ls  依赖std_msgs rospy roscpp

    Building a catkin workspace and sourcing the setup file
        cd ~/catkin_ws
        catkin_make

        . ~/catkin_ws/devel/setup.bash  添加workspace到系统变量

    查看package依赖：
        rospack depends1 beginner_tutorials 
        rospack depends beginner_tutorials  列出所有依赖 递归

    
            
    
        










