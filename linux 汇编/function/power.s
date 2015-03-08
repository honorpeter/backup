#   本程序计算
#   2^3 + 5^2

#本程序所有的内容都存储在寄存器中 故数据段中不含任何内容
.section .data

.section .text

.globl _start

_start:

pushl $3        #压入 第二个参数
pushl $2        #压入 第一个参数
                #函数参数 压入倒叙压入 
                # 内存地址  函数布局形式  c语言约定 都存放在栈中
                #                           如何访问
                #           参数N           N*4+4(%ebp)
                #           ...
                #           参数2           12(%ebp)
                #           参数1           8(%ebp)
                #           返回地址        4(%ebp)
                #           旧%ebp          (%ebp)
                #           局部变量 1      -4(%ebp)
                #               局部变量1 一般为 c语言return 中的数据
                #           局部变量 2      -8(%ebp)
call power      
                #call  将返回地址入栈 再跳转
                #jmp  则不会

addl $8, %esp
                #addl  加法运算
                #弹出入栈参数
pushl %eax

pushl $2
pushl $5
call power
addl $8,%esp
popl %ebx

addl %eax, %ebx

movl $1, %eax
int $0x80





.type power, @function      #告诉链接器这是一个函数

power:
                    #标记 函数开始的位置

pushl %ebp
                    # 将%ebp中的值入栈
movl %esp,%ebp
subl $4, %esp       
                    #  用于存放 c语言中 return 中的数据
movl 8(%ebp),%ebx
movl 12(%ebp),%ecx

movl %ebx,-4(%ebp)



power_loop_start:
    cmpl $1,%ecx
    je end_power
    movl -4(%ebp),%eax
    imull %ebx,%eax
                    # 整数相乘  并将结果存放到第二个中 
    movl %eax,-4(%ebp)

    decl %ecx       
                    #自减一
    jmp power_loop_start


                    #当一个函数 执行完毕时 会做三件事
end_power:
    movl -4(%ebp),%eax
                    # 1 将函数的返回值 c语言中的return  给%eax
    movl %ebp, %esp
                    #2 回复栈的状态 还有%ebp状态
                    #    直接销毁 布局变量 
    popl %ebp
                    #恢复 %ebp的值
    ret
                    # 3 出栈将值给%eip    跳转
