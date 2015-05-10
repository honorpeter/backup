下载内核源码：
    wget https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.6.tar.xz

解压：
    xz -d linux-3.18.6.tar.xz
    tar -xvf linux-3.18.6.tar
编译内核：
    cd linux-3.18.6
    make i386_defconfig     #x86体系结构
    make # 一般要编译很长时间，少则20分钟多则数小时 

# 制作根文件系统
    git clone https://github.com/mengning/menu.git 
    cd menu
    gcc -o init linktable.c menu.c test.c -m32 -static –lpthread
                //这里需要先安装 32位的库文件
                    In case of -m32:
                        sudo apt-get install libc6-dev-i386 
                    重新安装库文件
                        sudo apt-get purge libc6-dev
                        sudo apt-get install libc6-dev

    mkdir rootfs        创建rootfs目录
    cd rootfs
    cp ../menu/init ./
    find . | cpio -o -Hnewc |gzip -9 > ../rootfs.img
            1.  find .    查找显示当前目录下的所有文件、文件夹
            2.   |          管道，将 | 左边命令的结果（也就是find .
                 得到的所有文件、文件夹路径名称）传给右边(也就cpio命令)
            3. cpio -o -H newc    cpio是将文件系统打包或解包， -o 是打包 ，
                -H 指定格式 为newc 
                newc The new (SVR4) portable format, which supports file
                 systems having more than 65536 i-nodes. (4294967295 bytes)
            4  |  将cpio打好的包传给gzip压缩
            5 gzip    压缩命令的一种，gnuzip。类似zip，rar。
            6 >~/myinitramfs.gz   将压缩后的数据 存为 文件myinitramfs.gz

    编译内核：
        xz -d linux-3.18.6.tar.xz
        tar -xvf linux-3.18.6.tar
        cd linux-3.18.6
        make i386_defconfig
        make # 一般要编译很长时间，少则20分钟多则数小时

    # 启动MenuOS系统
        cd ~/LinuxKernel/
        qemu -kernel linux-3.18.6/arch/x86/boot/bzImage -initrd rootfs.img

    重新配置编译Linux使之携带调试信息:
        make menuconfig    选中如下选项重新配置Linux，
                使之携带调试信息    sudo apt-get install libncurses5-dev
            kernel hacking—>
            [*] compile the kernel with debug info

        make 重新编译（时间较长）

    使用gdb跟踪调试内核:
            qemu -kernel linux-3.18.6/arch/x86/boot/bzImage -initrd 
                    rootfs.img -s -S # 关于-s和-S选项的说明：
                # -S freeze CPU at startup (use ’c’ to start execution)
                # -s shorthand for -gdb tcp::1234 若不想使用1234端口，
                    #则可以使用-gdb tcp:xxxx来取代-s选项
    另开一个shell窗口:
            gdb
    （gdb）file linux-3.18.6/vmlinux # 在gdb界面中targe remote之前加载符号表
    （gdb）target remote:1234 # 建立gdb和gdbserver之间的连接,
                                #按c 让qemu上的Linux继续运行
    （gdb）break start_kernel # 断点的设置可以在target remote之前，
                                #也可以在之后

    


        
qemu:
        sudo ln -s /usr/bin/qemu-system-i386 /usr/bin/qemu
    















