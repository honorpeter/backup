opencv:
    设置opencv查找目录： 
    FIND_PACKAGE(OpenCV 2.4.8 EXACT REQUIRED PATHS "/home/longriyao/Soft/opencv-2.4/install")
    'find_package( OpenCV REQUIRED )

`   target_link_libraries(application ${OpenCV_LIBS})
    编译器会自动 在/usr/inclde文件夹中寻找 头文件

make使用 -l呢
    -lboost_system

boost:  
    find_package(Boost 1.36.0)
    find_package( Boost 1.54.0 REQUIRED system timer)
    
    if(Boost_FOUND)
        include_directories(${Boost_INCLUDE_DIRS})
        target_link_libraries(foo ${Boost_LIBRARIES})
    endif()
    手动安装：
        手动安装的boost 安装到/usr/local中 但是cmake找不到
        所以使用 cmake .. -DBOOST_ROOT=/usr/local 帮他找到
        或者
        set( BOOST_ROOT "/home/longriyao/Soft/boost_1_67_0/install" CACHE PATH "Boost library path" )
        set( Boost_NO_SYSTEM_PATHS on CACHE BOOL "Do not search system for Boost" )

    
    
