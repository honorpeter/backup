linux系统调用  使用汇编语言：
    退出程序：
        movl $1, $eax       #这是退出 程序的linux内核命令号

        movl $0, $ebx       #这是我们 程序退出是 返回给系统的 状态
                        # 范围 0~255   echo $? 可以输出 这里的数字

        int $0x80           # 运行linux内核  进行系统调用 调用完之后 
                            控制权 再次回到你的手中
        interupt 0x表示十六进制 80端口  一般操作系统提供 255个中断(软件中断)


    %eax保存系统调用号 返回值和错误代码 也存储在%eax

    文件操作系统调用：
                 eax         ebx                ecx              edx
    退出程序：   1            返回值    
    读取至给：   3            文件描述符        缓冲区           缓冲区大小
    定缓冲区                                    开始
                                                地址.bbs
    write

    close

    open

    chdir

    lseek

    getpid

    mkdir

    dup

    pipe

    brk

    ictl

http://www.lxhp.in-berlin.de/lhpsyscal.html 列出了更完备的系统调用以及其他相关信息

关于在linux上系统调用是如何实现的 参阅http://www.faqs.org/docs/kernel_2_4/lki-2.html#ss2.11     
    上面是 linux内核2.4如何实现的

http://www.joelonsoftware.com/articles/Unicode.html
关于unicode字符集的问题

linux下的c函数库信息  详见http://www.gnu.org/software/libc/manual/
    
            

使用代码共享库
    as helloworld-lib.s -o helloworld-lib.o
    ld -dynamic-linker /lib/ld-linux.so.2 -o helloworld-lib helloworld-lib.o -lc
        -dynamic-linker /lib/ld-linux.so.2使我们的程序可以链接到库
        这样 操作系统将加载程序/lib/ld-linux.so.2  以加载外部库并将其链接到
        程序    这种方法 成为 动态连接器
       选项 -lc 链接c库  一般命令为 libc.so

      执行过程：
            首先 /lib/ld-linux.so.2是动态连接器  
            程序执行时 加载了动态连接器 它看 缺少c库
            便去(/etc/ld.so.conf目录以及环境变量LD_LIBRARY_PATH的所有目录
            中寻找　库libc.so的库 然后在库中查找所需符号 函数名) 加载到内存
    
构建一个共享库：
    ld -shared write-record.o read-record.o -o librecord.so
    使用这个库
        ld -L . -dynamic-linker /lib/ld-linux.so.2 -o write-records -lrecord 
            write-record.o 

            -l 告诉链接器 在当前目录下寻找库（通常只搜索 /lib  /usr/lib和其
            它几个目录）  lrecord告诉连接器在librecord.so文件中找函数方法

            再将生成的动态链接库 添加到 指定目录便可使用了

        参考资料
            http://www.benyossef.com/presentations/dlink
            http://www.linuxjournal.com/article.php?sid=1059
            http://www.iecc.com/linker10.html以ELF文件格式很好的描述了
            

