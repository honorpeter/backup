获取cpu几个核：
    sudo make -j`cat /proc/cpuinfo| grep "processor"| wc -l`

强制gcc编译使用静态库：
    一种方法是直接指定静态链接的库全名：
        "gcc main.c -l:libfunc.a -L          //这样也是静态链接libfunc.a"
    另一个种：
        -Wl,-Bstatic   -Wl,-Bdynamic
        "gcc main.c  -Wl,-Bstatic -lfunc -L. -Wl,-Bdynamic -lgcc_s"

