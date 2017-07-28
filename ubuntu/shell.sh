tee 重定向输出到多个文件

常见用例：
 
        tee file     //覆盖

        tee -a file    //追加

        tee -        //输出到标准输出两次
        tee - -    //输出到标准输出三次

        tee file1 file2 -    //输出到标准输出两次,并写到那两个文件中

        ls | tee file   

        另：把标准错误也被tee读取
            ls "*" 2>&1 | tee ls.txt 
    

zerotier:
    commond: sudo zerotier-cli join     -h
            新建网络
            添加到本地
            生成ip

终端下面打开图形界面：
         startx         startX
         xinit

dd 命令：
    很强大 可以转换文件格式 等其他操作

linux下显示dd命令的进度:
        每5秒输出dd的进度
            watch -n 5 pkill -USR1 ^dd$
                pkill、killall、kill向dd命令发送SIGUSR1信息，dd命令进程接
                收到信号之后就打印出自己当前的进度
                最后是一个正则表达式

df: 以磁盘分区为单位查看文件系统，可以加上参数查看磁盘剩余空间：
        df -hl
du ： 查看分区内文件的大小：
        du -h *


格式化u盘：
        lsblk   查看upan
        Erase everything in the pen drive (OPTIONAL):
            sudo dd if=/dev/zero of=/dev/sdb bs=4k && sync
        Make a new partition table in the device:
            sudo fdisk /dev/sdb
            Then press letter o to create a new empty DOS partition table
        Make a new partition:
            Press letter n to add a new partition. You will be prompted 
            for the size of the partition. Making a primary partition 
            when prompted, if you are not sure
        Format your new partition:
            See what is your new partition with a command lsblk
            Issue the command below to format the new volume:
                sudo mkfs.vfat /dev/sdb1  
        Eject the device:
             sudo eject /dev/sdb

硬盘文件格式：
        一个硬盘可以有很多的分区    
            所以要建立分区表    
                DOS类型 最多可以建立4个分区
                GPT类型             128个分区
                Sun类型             4
                SGI                 16个分区
        每个分区中 可以建立一个文件系统
        这样分区可以防止 一个文件污染 还以可以保存磁盘中其他的文件

        u盘也是这样的
        linux系统中的： /dev/sdb1   是指的磁盘sdb 分区1
                        /dev/sg1    可是是磁盘sg    分区1
                            sg类型的是不block 不能使用mount挂载 
        磁盘：disk      可以使用 lsblk 查看
                sda     第一个磁盘
                    sda1    磁盘1 上的第一个分区
                sdb     第二个
                    sdb1    磁盘2 上的第一个分区
                sdc     。。。。

        在分区中建立文件系统：
                mkfs.vfat /dev/sdb1  
                mkfs -t 可以指定类型
                也可以使用mkfs.类型 创建

修改默认shell：
	chsh -s /usr/bin/zsh
参看进程树：
    pstree -p | grep http

统计某文件夹下文件的个数
ls -l |grep "^-"|wc -l

统计某文件夹下目录的个数
ls -l |grep "^ｄ"|wc -l

统计文件夹下文件的个数，包括子文件夹里的
ls -lR|grep "^-"|wc -l





