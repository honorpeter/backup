.section .data
 data_items:    #标记 下面数据段 的起始地址
    .long 3,45,15,154,34,44,45,45,0  #.long是指令 表示数据存储大小的指令
                                    # .long表示 4个字节大小 .byte(一个字节) 
                                    #.int 两个字节  .long .ascii "hello world\0"
                                    #用于将 字符串输入内存每个字符占一个字节
                                    #最后一个 \0 提示我们 字符串结束
.section .text
    .globl _start
 _start:
    movl $0, %edi
    movl data_items( ,%edi,4) , %eax
                            #data_items详解
                            起始地址（，%索引寄存器，字长） 下面详解
    movl %eax,%ebx

 start_loop:                
                            #循环开始的标记位置
    cmpl $0, %eax
    je loop_exit
    incl %edi
                        #自增 1
    movl data_items(,%edi,4),%eax
    cmpl %ebx,%eax
                        #cmpl指令对两个值 进行比较 比较会影响 %eflags寄存器
                        je 若值相等则跳转
                        jg great
                        jge
                        jle less
    jle start_loop
    movl %eax,%ebx
    jmp start_loop
                        #jmp 无条件 跳转
    
   loop_exit:
        movl $1, %eax
        int $0x80 
                    

#寻址方式
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
    简介寻址：
        movl (%eax),%ebx
            就是从寄存器中存放的地址 加载地址指向的内容
    基地址寻址：
        movl 4(%eax),%ebx
            就是将寄存器中的值加上外面的常量 再寻找内存的内容
    立即寻址：
        movl $23, %ebx
            直接将12加载到寄存器中
         
        
    
    
