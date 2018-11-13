debug感知：
    build.sh perception     #下载第三方库  高清地图 编译感知模块
    source catkin_build/devel/setup.zsh #先source 在local build
    cd modules/perception
    bash local_build.sh -d      #下载感知的模型文件 而且也会加载系统环境变量
    clion.sh

    debug：
        source catkin_build/devel/setup.zsh
        roscore

        roslaunch sky_touch perception_offline.launch

