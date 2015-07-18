x86启动过程 ： 32的位
        加点后：    每个寄存器都有一个默认值
        CS = f000H  EIP = 0000FFF0H   寻址按照实模式寻址
        加载一个扇区 512字节 bootloader

        bootloader:
            进入保护模式： 段机制可以工作 页机制也可以工作
            加载操作系统ucore




        段机制：
                CS  实现分段机制 每个CS的值不同 便代表不同的段
                    在ucore没有使用段机制  CS值固定的 直接修改EIP 便可以定位
                    使用分页机制

                段寄存器CS DS。。。。
                    前13位是 段选择址（index）这个值会查找在段描述中的一个项
                    14,15位是优先级 内核00特权级  用户11

        全局描述符表： GDT
            是由bootloader建立起来的  GDT表的首地址保存在GDTR寄存器中
                GDT表是一个大的数组：
                    存放：段的基址(起始地址)  段的大小


        访问的时候 ：
            先根据GDTR找到GDT然后根据CS的前13位找到哪一项  然后找到基地址
                基址+EIP（偏移地址）   便可以访问了

        在ucore中 
                GDT数组中
                每个基址都是0   段长都是4G
                这样映射之后就是 物理地址了


        做好以上工作之后 进入保护模式： bootloader 完成的
                将CR0的第0号地址 设置为1

        加载ucore： ELF格式的kernel
                根据ELF的 头结构 进行存放地址。。。 


C函数调用的实现：
        参见 ： 深入理解程序设计 linux汇编

gcc内嵌汇编：
        因为C语言没有对应的表示  所以需要内嵌汇编
         
        加入asm     将%变为两个
            movl $0xffff %eax       asm("movl $0xffff, %%eax")      

        总的格式：
                asm( assembler template     //是上个例子 下面可选
                    :output operands        //输出限制
                    :input  operands        //输入限制
                    :clobbers
                );


                uint32_t cr0;
                asm volatile("movl %%cr0, %0\n":"=r"(cr0));
                cr0 |= 0x80000000;
                asm volatile ("movl %0,%%cr0\n"::"r"(cr0));

                volatile: 不需要做进一步的优化 调整顺序
                %0  ： 代表是第一个用到的寄存器
                r：     代表任意寄存器

                翻译生汇编代码：
                    movl %cr0, %ebx
                    movl %ebx, 12(%esp)
                    orl  %-2147483648, 12(%esp)
                    movl 12(%esp), %eax
                    movl %eax , %cr0


                long__res, arg1 = 2, arg2 = 22, agr3 = 222,arg4 =233;
                __asm__volatile("int $0x80"
                :"=a"(_res)
                :"0"(11),"b"(arg1),"c"(agr2),"d"(arg3),"S"(arg4));

                 翻译生汇编代码：
                        movl $11, %eax
                        movl -28(%ebp), %ebx
                        movl -24(%ebp), %ecx
                        movl -20(%ebp), %edx
                        movl -16(%ebp), %esi
                        int $0x80
                        movl %edi, -12(%ebp)


                        常用的寄存器约束的缩写:
                            r:I/O,表示使用一个通用寄存器,由GCC在%eax/ 
                            %ax/ %al、%ebx/ %bx/ %bl、%ecx/ %cx /%cl、%edx/%
                            dx/%dl中选取一个GCC认为是合适的;
                            q:I/O,表示使用一个通用寄存器,与r的意义相同;
                            g:I/O,表示使用寄存器或内存地址;
                            m:I/O,表示使用内存地址;
                            a:I/O,表示使用%eax/%ax/%al;
                            b:I/O,表示使用%ebx/%bx/%bl;
                            c:I/O,表示使用%ecx/%cx/%cl;
                            d:I/O,表示使用%edx/%dx/%dl;
                            D:I/O,表示使用%edi/%di;
                            S:I/O,表示使用%esi/%si;
                            f:I/O,表示使用浮点寄存器;
                            t:I/O,表示使用第一个浮点寄存器;
                            u:I/O,表示使用第二个浮点寄存器;
                            A:I/O,表示把%eax与%edx组合成一个64位的整数值;
                            o:I/O,表示使用一个内存位置的偏移量;
                            V:I/O,表示仅仅使用一个直接内存位置;
                            i:I/O,表示使用一个整数类型的立即数;
                            n:I/O,表示使用一个带有已知整数值的立即数;
                            F:I/O,表示使用一个浮点类型的立即数;

 

                            =: O 表示此Output操作表达式是只写的
                            + :O 表示此Output操作表达式是可读可写的
                            &:O 表示此Output操作表达式独占为其指定的寄存器
                            %:I 表示此Input操作表达式中的C/C++表达式可以与 
                                一个Input操作表达式中的C/C++表达式互换


x86 中断处理：
        中断源：
            硬件： 
                网卡 时钟 硬盘 串口
                。。
            软件：
                int  指令
        异常： 除零

        每个中断和异常 都有一个编号
        对应每个 服务例程 和编号关联 关联信息 存储在 中断描述符表中 IDT
            IDT的起始地址 和大小保存在 中断描述符表寄存器IDTR

            中断描述符表： 是一个大的数组  
                每一项称为 中断门
                    中断门里面存放了： 类似CS EIP  的两个信息
                        接合GDT就可以寻找到服务例程的地址
                这些寻址过程 都是硬件完成的
                当产生中断 异常的时候 硬件会自动将cs EIP。。。压栈
                不同的级别 压入的内容不同
                    特权级： 压入
                        EPLAGS
                        CS
                        EIP
                        Error Code
                    用户级： 压入
                        ss
                        esp
                        EP
                        CS
                        EIP
                        Error Code
                 处理完时候：通过 iret返回 执行
            软中断：
                和硬件中断差不多


lab1:   bootloader的加载
            编译运行bootloader的过程
            调试bootloader的方法
            PC启动bootloader的过程
            ELF执行文件格式和加载
            外设访问：读硬盘 显示字符
        ucore OS软件：
            编译运行ucore OS的过程
            ucore OS的启动过程
            调试ucore OS的方法
            函数调用关系
            中断管理:中断处理 
            外设管理：时钟
        计算机原理
            CPU的编址与寻址:	基于分段机制的内存管理
            CPU的中断机制
            外设:串口/并口/CGA,时钟,硬盘
                        













