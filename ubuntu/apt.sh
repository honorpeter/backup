搜索软件包 apt-cache search

软件包信息 apt-cache show

安装 apt-get install(reinstall、-f)

删除 apt-get remove(autoremove、--purge)

更新软件源 apt-get update

更新已安装包apt-get upgrade

apt-get source #——(package 下载该包的源代码)
apt-get dist-upgrade # ---------升级系统
apt-file search filename -----查找filename属于哪个软件包
apt-file list packagename -----列出软件包的内容


sudo apt-get update

    mismatch Hash :
            sudo rm -vf /var/lib/apt/lists/*
            sudo apt-get update

 dpkg -l | grep sdl
     查看相关sdl的包



apt-cache search ^libsdl | grep 1.2
      安装软件的时候 不知道名字的时候 搜索一下

sudo apt-get update  ip not found:
    dpkg --print-foreign-architectures
        如果是arm64 变为arm64 
            dpkg -l | grep arm64
            sudo dpkg --remove-architecture arm64
                将所有arm64 的包 全部删除

            sudo dpkg --force-architecture --remove-architecture arm64
            sudo rm -rf /var/lib/apt/lists
            sudo apt update
            





