概述：
        规则写在：
            CMakeLists.txt 文件  中:
                PROJECT (HELLO)
                SET(SRC_LIST main.c)
                MESSAGE(STATUS "This is BINARY dir " ${HELLO_BINARY_DIR})
                MESSAGE(STATUS "This is SOURCE dir "${HELLO_SOURCE_DIR})
                ADD_EXECUTABLE(hello ${SRC_LIST})

        构建:
                内部构建:
                    cmake .             //生成 makefile文件
                    make                //进行编译
                查看细节:
                    make VERBOSE=1 来构建   
                外部构建:
                    通过外部编译进行工程构建,HELLO_SOURCE_DIR 
                        仍然指代工程路径,即 /backup/cmake/t1
                    而 HELLO_BINARY_DIR 则指代编译路径,即
                        /backup/cmake/t1/build
                    命令：
                        cd build       //build 目录 是你想存放 obj文件的地方
                        cmake ..  
                        make

                        目标文件 hello 位于 build/bin 目录中


规则：  CMakeLists.txt
        原则：
                1 . 参数之间使用空格或分号分开
                2 . 变量使用${}方式取值,但是在 IF 控制语句中是直接使用变量名
                3 . 指令是大小写无关的,参数和变量是大小写相关的
                        推荐你全部使用大写指令

            注意：
                1 这里需要特别解释的是作为工程名的 HELLO 和生成的可执行文件 
                    hello 是没有任何关系的。 hello 定义了可执行文件的文件名
                2 SET(SRC_LIST main.c)也可以写成 SET(SRC_LIST “main.c”)
                        假设一个源文件的文件名是 fu nc.c(文件名中间包含
                        了空格)。 这时候就必须使用双引号

                3 MESSAGE(STATUS “This is BINARY dir” ${HELLO_BINARY_DIR})
                        也可以写成:
                  MESSAGE(STATUS “This is BINARY dir ${HELLO_BINARY_DIR}”)
        PROJECT 指令的语法是:
            PROJECT(projectname [CXX] [C] [Java])
                    指令定义工程名称,并可指定工程支持的语言 
                    默认情况表示支持所有语言
            这个指令隐式的定义了两个 cmake 变量:
                    <projectname>_BINARY_DIR 以及<projectname>_SOURCE_DIR,
                    上例就是: HELLO_BINARY_DIR 和 HELLO_SOURCE_DIR
        SET 指令的语法是:
                SET(VAR [VALUE] [CACHE TYPE DOCSTRING [FORCE]])
                如果有多个源文件,也可以定义成:
                        SET(SRC_LIST main.c t1.c t2.c)

        MESSAGE 指令的语法是:
            MESSAGE([SEND_ERROR | STATUS | FATAL_ERROR] "message to display"
                                            ...)
                    这个指令用于向终端输出用户定义的信息,包含了三种类型:
                        SEND_ERROR,产生错误,生成过程被跳过。
                        SATUS ,输出前缀为 — 的信息
                        FATAL_ERROR,立即终止所有 cmake 过程
        ADD_EXECUTABLE(hello ${SRC_LIST}):
                定义了这个工程会生成一个文件名为 hello 的可执行文件,
                相关的源文件是 SRC_LIST 中定义的源文件列表,
        ADD_SUBDIRECTORY 指令:
                ADD_SUBDIRECTORY(source_dir [binary_dir] [EXCLUDE_FROM_ALL])
                用于向当前工程添加存放源文件的子目录,并可以指定中间二进制和
                    目标二进制存 放的位置。EXCLUDE_FROM_ALL 参数的含义是将这
                    个目录从编译过程中排除
                    
                    ADD_SUBDIRECTORY(src bin)
                        将 src 子目录加入工程,并指定编译输出(包含编译中间
                        结果)路径为 bin 目录。如果不进行 bin 目录的指定,
                        那么编译结果(包括中间结果)都将存放在 build/src 目录
                        (这个目录跟原有的 src 目录对应)
        指令 ADD_LIBRARY:
                ADD_LIBRARY(libname
                    [SHARED|STATIC|MODULE]
                    [EXCLUDE_FROM_ALL]
                    source1 source2 ... sourceN)
                    你不需要写全 libhello.so,只需要填写 hello 即可,cmake 
                        系统会自动为你生成 libhello.X
                    类型有三种:
                        SHARED,动态库
                        STATIC,静态库
                        MODULE,在使用 dyld 的系统有效,如果不支持 dyld,
                        则被当作 SHARED 对待
        SET_TARGET_PROPERTIES:
                SET_TARGET_PROPERTIES(target1 target2 ...
                    PROPERTIES prop1 value1
                    prop2 value2 ...)
                    这条指令可以用来设置输出的名称,对于动态库,还可以用来指
                        定动态库版本和 API 版本
            版本号:
                SET_TARGET_PROPERTIES(hello PROPERTIES VERSION 1.2 
                        SOVERSION 1)
                    VERSION 指代动态库版本,SOVERSION 指代 API 版本。
        GET_TARGET_PROPERTY(VAR target property)
        

变量：
        ${}来引用变量
        在 IF 控制语句,变量是直接使用变量名引用,而不需要${}。

        重要变量：
            SET(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)
            SET(LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/lib)
                SET 指令重新定义 EXECUTABLE_OUTPUT_PATH 和 
                LIBRARY_OUTPUT_PATH 变量 来指定最终的目标二进制的位置
                (指最终生成的 hello 或者最终的共享库,
                不包含编译生成的中间文件)
                在哪里 ADD_EXECUTABLE 或 ADD_LIBRARY,
                如果需要改变目标存放路径,就在哪里加入上述的定义
            <projectname>_BINARY_DIR 和 PROJECT_BINARY_DIR 变量,他
                    们指的编译发生的当前目录        build

    cmake 常用变量::
            CMAKE_BINARY_DIR
            PROJECT_BINARY_DIR
            <projectname>_BINARY_DIR
                指代的内容是一致的,如果是 in source 编译,指得就是工程顶层
                    目录,如果 是 out-of-source 编译,指的是工程编译发生的目录
            CMAKE_SOURCE_DIR
            PROJECT_SOURCE_DIR
            <projectname>_SOURCE_DIR
                指代的内容是一致的,不论采用何种编译方式,都是工程顶层目录。
            CMAKE_CURRENT_SOURCE_DIR:
                    指的是当前处理的 CMakeLists.txt 所在的路径
            CMAKE_CURRRENT_BINARY_DIR:
                    
            CMAKE_CURRENT_LIST_FILE:
                    输出调用这个变量的 CMakeLists.txt 的完整路径
            CMAKE_CURRENT_LIST_LINE:
                    输出这个变量所在的行
            CMAKE_MODULE_PATH

            EXECUTABLE_OUTPUT_PATH 和 LIBRARY_OUTPUT_PATH:

            PROJECT_NAME:
                返回通过 PROJECT 指令定义的项目名称。

        cmake 调用环境变量:
            设置环境变量:
                    SET(ENV{变量名} 值)
        系统信息:
                    1,CMAKE_MAJOR_VERSION,CMAKE 主版本号,比如 2.4.6 中的 2
                    2,CMAKE_MINOR_VERSION,CMAKE 次版本号,比如 2.4.6 中的 4
                    3,CMAKE_PATCH_VERSION,CMAKE 补丁等级,比如 2.4.6 中的 6
                    4,CMAKE_SYSTEM,系统名称,比如 Linux-2.6.22
                    5,CMAKE_SYSTEM_NAME,不包含版本的系统名,比如 Linux
                    6,CMAKE_SYSTEM_VERSION,系统版本,比如 2.6.22
                    7,CMAKE_SYSTEM_PROCESSOR,处理器名称,比如 i686.
                    8,UNIX,在所有的类 UNIX 平台为 TRUE,包括 OS X 和 cygwin
                    9,WIN32,在所有的 win32 平台为 TRUE,包括 cygwin       

        开关选项:
                1,CMAKE_ALLOW_LOOSE_LOOP_CONSTRUCTS,
                        用来控制 IF ELSE 语句的书写方式
                2,BUILD_SHARED_LIBS
                        这个开关用来控制默认的库编译方式,如果不进行设置,
                        使用 ADD_LIBRARY 并没有指定库 类型的情况下,默认编
                        译生成的库都是静态库。 如果 
                        SET(BUILD_SHARED_LIBS ON)后,默认生成的为动态库。
                3,CMAKE_C_FLAGS
                    设置 C 编译选项,也可以通过指令 ADD_DEFINITIONS()添加。
                4,CMAKE_CXX_FLAGS
                    设置 C++编译选项,也可以通过指令 ADD_DEFINITIONS()添加。
    自定义变量:
            SET(HELLO_SRC main.SOURCE_PATHc)



                

清理工程:
            make clean
            即可对构建结果进行清理。


安装:
        make:从代码编译后直接 make install 安装
                make install 
                        将 hello 直接安装到/usr/bin 目录 
                make install DESTDIR=/tmp/test 
                        将他安装在 /tmp/test/usr/bin 目录
        cmake:
            指令 INSTALL 和一个非常有用的变量 CMAKE_INSTALL_PREFIX
                使用：
                    cmake -DCMAKE_INSTALL_PREFIX=/usr .
            INSTALL 指令包含了各种安装类型:
                INSTALL(TARGETS targets...
                    [[ARCHIVE|LIBRARY|RUNTIME]
                    [DESTINATION <dir>]
                    [PERMISSIONS permissions...]
                    [CONFIGURATIONS
                [Debug|Release|...]]
                    [COMPONENT <component>]
                    [OPTIONAL]
                    ] [...])
                    参数中的 TARGETS 后面跟的就是我们通过 ADD_EXECUTABLE
                        或者 ADD_LIBRARY 定义的 目标文件,可能是可执行二进制
                        动态库、静态库。
                    目标类型也就相对应的有三种,ARCHIVE 特指静态库,
                        LIBRARY 特指动态库,RUNTIME 特指可执行目标二进制
                    DESTINATION 定义了安装的路径,如果路径以/开头,那么指的
                        是绝对路径,这时候 CMAKE_INSTALL_PREFIX 其实就无效
                        了。如果你希望使用 CMAKE_INSTALL_PREFIX 来 定义安
                        装路径,就要写成相对路径
                例子:
                    INSTALL(TARGETS myrun mylib mystaticlib
                        RUNTIME DESTINATION bin
                        LIBRARY DESTINATION lib
                        ARCHIVE DESTINATION libstatic
                        )
                普通文件的安装:
                    doc  readme
                    INSTALL(FILES files... DESTINATION <dir>
                        [PERMISSIONS permissions...]
                        [CONFIGURATIONS [Debug|Release|...]]
                        [COMPONENT <component>]
                        [RENAME <name>] [OPTIONAL])


使用外部共享库和头文件:
        引入头文件搜索路径: 
            指令 INCLUDE_DIRECTORIES
                INCLUDE_DIRECTORIES([AFTER|BEFORE] [SYSTEM] dir1 dir2 ...)
                    用来向工程添加多个特定的头文件搜索路径,路径之间用空格
                        分割,如果路径 中包含了空格,可以使用双引号将它括起来
                    默认的行为是追加到当前的头文件搜索路径的 后面 
                        通过 AFTER 或者 BEFORE 参数,也可以控制是追加还是置前

        为 target 添加共享库:
                LINK_DIRECTORIES 和 TARGET_LINK_LIBRARIES
                LINK_DIRECTORIES(directory1 directory2 ...):
                    添加非标准的共享库搜索路径

                TARGET_LINK_LIBRARIES(target library1
                    <debug | optimized> library2
                    ...)
                    这个指令可以用来为 target 添加需要链接的共享库
                        TARGET_LINK_LIBRARIES(main hello)
                        也可以写成
                        TARGET_LINK_LIBRARIES(main libhello.so)
        链接到静态库:
                TARGET_LINK_LIBRARIES(main libhello.a)

        特殊的环境变量 CMAKE_INCLUDE_PATH 和 CMAKE_LIBRARY_PATH:
                这两个是环境变量而不是 cmake 变量。
                使用方法是要在 bash 中用 export 或者在 csh 中使用 set 命令
                        设置或者 CMAKE_INCLUDE_PATH=/home/include
                例：
                    export CMAKE_INCLUDE_PATH=/usr/include/hello
                    FIND_PATH(myHeader hello.h)
                    IF(myHeader)
                    INCLUDE_DIRECTORIES(${myHeader})
                    ENDIF(myHeader)
                    FIND_PATH 用来在指定路径中搜索文件名








