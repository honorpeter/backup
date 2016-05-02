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










