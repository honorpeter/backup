全流程：
    编译：
        编译选项：
            add_compile_options
                这个选项对c  c++都管用

            通过set命令修改CMAKE_CXX_FLAGS或CMAKE_C_FLAGS   
                分别针对c++ 和 c

            只针对c++添加 c++11
            if(CMAKE_COMPILER_IS_GNUCXX)
                set(CMAKE_CXX_FLAGS "-std=c++11 ${CMAKE_CXX_FLAGS}")
                message(STATUS "optional:-std=c++11")   
            endif(CMAKE_COMPILER_IS_GNUCXX)

    添加宏定义：
        
        + OPTION(USE_MACRO "Build the project using macro" OFF)
        + IF(USE_MACRO)
            +  add_definitions("-DUSE_MACRO")
        + endif(USE_MACRO)
        
        
        add_definitions("-DUSE_MACRO")     -D


        开启：　cmake 　-DUSE_MACRO＝on ..
        关闭：　cmake 　-DUSE_MACRO＝off ..
        
    添加头文件目录：
        include_directories(/usr/local/cuda/include)
        相当于-I
        
    添加链接库：  相当于 -lOpenCL
        target_link_libraries(demo OpenCL)

    添加链接库目录：
        相当于 -L
        LINK_DIRECTORIES() 



