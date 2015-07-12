    .section .data       以 点 开头的都是 指令或伪操作（这些 由 汇编程序处里                                变为机械指令） 
                        .section 指令将程序分为几个 部分 
                        .section .data 是数据段的开始

    .section .text      是存放程序指令的部分

    .globl _start       程序开始位置 _start 是一个符号 符号表示：标志
                            内存的地址 。。。  定义位置的时候 data_iteam: 
                        .globl 表示 _start 是全局的 让内核知道他的位置
                            因为链接的时候 需要用到这个位置

    movl $1, %eax       使用寄存器的时候 需要加 %    $1  表示1
    movl $22, %ebx      
     
    int $0x80           int 表示中断  int 后面加中断号

