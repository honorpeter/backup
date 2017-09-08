获取cpu几个核：
    sudo make -j`cat /proc/cpuinfo| grep "processor"| wc -l`
