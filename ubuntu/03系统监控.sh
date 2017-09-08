查看包所属 命令 说书 包命令  找到源码

使用/proc:
    /proc/[number]/cmdline 程序命令行参数，以’\0’分隔的字符串文件（在程序中，可以通过直接读此文件，获取程序的命令行参数，但不推荐这么做，这样做了程序的可移植性不好 😥 ）
    /proc/[number]/cwd 程序的当前工作路径的软链接(readlink就可以得到被链接的目录)
    /proc/[number]/environ 程序的当前环境变量，以’\0’分隔的字符串文件
    /proc/[number]/exe 程序的可执行文件的软链接（通过readlink可以获取程序可执行文件的完整路径）
    /proc/[number]/fd 程序当前正在使用的fd，这些fd都链向实际的文件
    /proc/[number]/maps 程序的地址空间分布和访问权限（通过这些信息，可以查看进程的地址是否在合法的范围）
    /proc/[number]/smaps (since Linux 2.6.14) 程序的每块内存映射区域的内存使用情况

ldd查看:  程序依赖
    ldd program

    可以查看/proc/[number]/fd里面的文件 基本也可以看到依赖的库文件

nm:查看程序的所有符号表：
    nm -C proc | grep symbol
        -C将 函数名字 可读 

vmstat:可以查看详细的内存使用情况系统情况


