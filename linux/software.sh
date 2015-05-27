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

