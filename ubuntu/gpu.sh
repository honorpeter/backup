没有进行运行但是占用很多的显存：
    sudo fuser -v /dev/nvidia*
        查看所有使用gpu的进程
        Show which processes use the named files, sockets, or filesystems
    杀死所有占用进程：
        sudo fuser -k -v /dev/nvidia*
        
