ldconfig -p | grep caffe2
    查看caffe2的动态库有没有添加到 环境搜索中

LD_LIBRARY_PATH:
    有时候管用 有事不管用

ldd：      通过加载器 ld-linux.so 控制环境变量来实现的
    查看依赖
    很多现代应用都是通过动态编译链接的，当一个 需要动态链接 的应用被操作系统加载时，系统必须要 定位 然后 加载它所需要的所有动态库文件。 在Linux环境下，这项工作是由ld-linux.so.2来负责完成的，我们可以通过 ldd 命令来查看一个 应用需要哪些依赖的动态库:
    ld-linux.so加载器将所有的动态库加载后然后再将控制权移交给ls程序的入口。


    ld-linux.so.2 man page给我们更高一层的全局介绍， 它是在 链接器（通常是ld）在运行状态下的部件，用来定位和加载动态库到应用的运行地址（或者是运行内存）当中去。通常，动态链接是 在连接阶段当中 隐式指定的。 gcc -W1 options -L/path/included -lxxx 会将 options 传递到ld 然后指定相应的动态库加载。 ELF 文件提供了相应的加载信息， GCC包含了一个特殊的 ELF 头： INTERP， 这个 INTERP指定了 加载器的路径，我们可以用readelf 来查看相应的程序

    readelf -l a.out

    readefl -d
        -d基本也可以查看动态库


二进制文件编译：
    ld： not find lib       指定了-l  但是没有找到动态库  
        可以ldconfig -p 查看目录中是否存在 该动态库
        使用 -L 指定库寻找目录

    undefined sym：
        1， 没有指定-l  指定需要连接的库
        2， 指定了-l    include 和 lib不一致 不是同一个版本
            这种情况：比如系统环境中安装了 protobuf  conda也安装了protobuf
                就会导致 这种情况
            手动指定使用cmake
                指定精确版本   或则 指定查找路径

运行时：
    寻找动态库顺序：
        1.readefl -d hh.so 
            输出RPATH  首先查找这个路径中的动态库 有的可能没有
            RPATH:是在 编译的时候 指定的
            Library rpath: [/home/xlji/xlji/xlji/caffe2/caffe2/build_ok/lib:]
            在编译的时候 通过-R（或-rpath）指定程序运行时库的路径

        2.　查找/usr/lib  库寻找
        3. 按照ldconfig目录中的库来 寻找
     undefined symbol:
        可以ldconfig -p 查看目录中是否存在 该动态库  以及存在多少个
        使用ldd 查看程序加载的哪一个库 是否和编译的时候加载的相同
            如果编译和加载不相同，可以通过-R来指定路径

运行时搜索路径： 看着不是很准
    搜索动态库的先后顺序

    编译目标代码时指定的动态库搜索路径

    LD_LIBRARY_PATH     :有些程序内新建的shell可能不管用

    /etc/ld.so.cache  好像ldconfig -p只能显示这里的库
         修改 /etc/ld.so.conf 顺序应该可以改变搜索顺序

    default path /lib, and then /usr/lib.


    

-L: “链接”的时候，去找的目录，也就是所有的 -lFOO 选项里的库，都会先从 -L 指定的目录去找，然后是默认的地方。编译时的-L选项并不影响环境变量LDLIBRARYPATH，-L只是指定了程序编译连接时库的路径，并不影响程序执行时库的路径，系统还是会到默认路径下查找该程序所需要的库，如果找不到，还是会报错，类似cannot open shared object file。

-rpath-link：这个也是用于“链接”的时候的，例如你显示指定的需要 FOO.so，但是 FOO.so 本身是需要 BAR.so 的，后者你并没有指定，而是 FOO.so 引用到它，这个时候，会先从 -rpath-link 给的路径里找。

-rpath: “运行”的时候，去找的目录。运行的时候，要找 .so 文件，会从这个选项里指定的地方去找。对于交叉编译，交叉编译链接器需已经配置 --with-sysroot 选项才能起作用。也就是说，-rpath指定的路径会被记录在生成的可执行程序中，用于运行时查找需要加载的动态库。-rpath-link 则只用于链接时查找。
-Wl,-rpath  好像要这么写



连接顺序
直接man ld。The linker uses the following search paths to locate required shared libraries:

       1.  Any directories specified by -rpath-link options.
       2.  Any directories specified by -rpath options.  The difference between -rpath and -rpath-link is that directories specified by -rpath options are included in the executable and used at runtime, whereas the -rpath-link option is only effective at link time. Searching -rpath in this way is only supported by native linkers and cross linkers which have been configured with the --with-sysroot option.
       3.  On an ELF system, for native linkers, if the -rpath and -rpath-link options were not used, search the contents of the environment variable "LD_RUN_PATH".
       4.  On SunOS, if the -rpath option was not used, search any directories specified using -L options.
       5.  For a native linker, the search the contents of the environment variable "LD_LIBRARY_PATH".
       6.  For a native ELF linker, the directories in "DT_RUNPATH" or "DT_RPATH" of a shared library are searched for shared libraries needed by it. The "DT_RPATH" entries are ignored if "DT_RUNPATH" entries exist.
       7.  The default directories, normally /lib and /usr/lib.
       8.  For a native linker on an ELF system, if the file /etc/ld.so.conf exists, the list of directories found in that file.
       If the required shared library is not found, the linker will issue a warning 
    
