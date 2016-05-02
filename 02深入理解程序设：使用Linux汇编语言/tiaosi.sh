汇编调试：
    使用gdb调试
    as --gstabs maximum.s -o max.o
        --gstabs要加上
    ld 。。。。。一样

    gdb ./max  这样运行就可以使用了

    man gdb  ok....
    help


    gcc -S file.c可以将c语言翻译成汇编语言
        file.o 中
    
