软件管理中心 安装的软件一般安装在	/usr/share里面
 
通过 apt-get install 安装的软件一般安装在 /opt

lamp 安装在  	/usr/local/里面


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

安装为之笔记:
        sudo add-apt-repository ppa:wiznote-team/ppa
        sudo apt-get udpate
        sudo apt-gte install wiznote

安装cuda:
        先下载在官方 先按照官方的命令执行   执行完之后
        在 zshrc中
        export PATH=/usr/local/cuda-7.5/bin:$PATH
        export LD_LIBRARY_PATH=/usr/local/cuda-7.5/lib64:$LD_LIBRARY_PATH
            
        
    
