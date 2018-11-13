find_package() 命令原理：
    两种寻找模式：
        module：    findOpenCL.cmake  寻找这种文件 去寻找相应的库 默认采用
        config模式： 如果module没有找到 采用这种模式
        Module模式：
            搜索CMAKE_MODULE_PATH指定路径下的FindXXX.cmake文件，执行
            该文件从而找到XXX库。其中，具体查找库并给XXX_INCLUDE_DIRS和
            XXX_LIBRARIES两个变量赋值的操作由FindXXX.cmake模块完成。

            设置寻找module路径：
                set (CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/")

        Config模式：搜索XXX_DIR指定路径下的XXXConfig.cmake文件，执行该文件从
            而找到XXX库。其中具体查找库并给XXX_INCLUDE_DIRS和XXX_LIBRARIES两
            个变量赋值的操作由XXXConfig.cmake模块完成。

            set(Caffe_DIR /home/wjg/projects/caffe/build)  指定Caffe寻找路径
                Caffe_DIR：这个目录需要存在  XXXConfig.cmake
            set(OpenCV_DIR opencv/opencv-3.1.0/build/install/share/OpenCV)
            # Requires OpenCV
            FIND_PACKAGE( OpenCV 3.1.0 REQUIRED EXACT)


