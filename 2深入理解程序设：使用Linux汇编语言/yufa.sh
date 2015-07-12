汇编语法
    汇编语法分为：
        指令(以点开头的) 和 标示符( 不是以点开头的都是表示符)

        指令： （这些 由 汇编程序处里变为机械指令）
            .section .data   
                        .section 指令将程序分为几个 部分 
                        .section .data 是数据段的开始

            .section .text      是存放程序指令的部分

            .section .bss 
                        .bss段类似于数据段 不同是它不占用可执行程序的空间
                        可以保留存储位置却不能进行初始化
                        一般用作 读取文件使用
            .lcomm 指令
                   .lcomm my_buffer,500 
                   创建一个符号my_buffer 指代我们用作缓冲区的500字符

            .globl _start   程序开始位置 _start 是一个符号 符号表示：标志
                            内存的地址 。。。  定义位置的时候 data_iteam: 
                            .globl 表示 _start 是全局的 让内核知道他的位置
                            因为链接的时候 需要用到这个位置
            movl $1, %eax       使用寄存器的时候 需要加 %    $1  表示1
                                movl 表示 4个字节
            movl $22, %ebx      

            int $0x80           int 表示中断  int 后面加中断号
            
            指令.long .byte .int .ancii
                    看 maximum.s
            指令　 incl
                    incl 自增1
            指令 decl   
                    decl 自减
            指令cmpl    jmp     je jg jge jle
                    看 maximum.s 
            指令call    
                    将返回地址入栈 在跳转 
                    常用于调用函数 详见power.s
            指令ret
                    出栈 将出栈的值给%eip并 跳转

            指令pushl
                    pushl 数据      将 数据 入栈
            指令 popl
                    popl 数据       将 数据 出栈
            指令 imull
                     imull %ebx,%eax
                        整数相乘  并将结果存放到第二个书中  详见：power.s
            指令 addl
                     addl $8, %esp
                            addl  加法运算
            指令 .equ
                .equ LINUX_SYSCALL, 0x80
                替换 相当于c中的宏

            指令.include
                .include "linux.s"
                包含外部文件
            指令 .rept .endr
                .rept 31
                .byte 0
                .endr
                填充 31个 0

   



寻址方式
    内存地址引用:
        地址或偏移 (%基址寄存器,%索引寄存器,比例因子)  #所有字段可选
            结果地址=地址或偏移 + %基址或偏移量寄存器+比例因子×%索引寄存器
                中间两个必须是寄存器 两边两个必须是常数 
                如果省略哪一项 0 代替
    直接寻址方式：
        movl ADDRESS, $eax
            将地址ADDRESS中的内容加载 到寄存器%eax
            ADDRESS 可以值数字 也可以是 标识符
    索引寻址方式：
        就是 内存地址引用
    间接寻址：
        movl (%eax),%ebx
            就是从寄存器中存放的地址 加载地址指向的内容
    基地址寻址：
        movl 4(%eax),%ebx
            就是将寄存器中的值加上外面的常量 再寻找内存的内容
    立即寻址：
        movl $23, %ebx
            直接将12加载到寄存器中
         
