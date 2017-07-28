opencv:
    find_package( OpenCV REQUIRED )

`   target_link_libraries(application ${OpenCV_LIBS})
    编译器会自动 在/usr/inclde文件夹中寻找 头文件

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
    
    
