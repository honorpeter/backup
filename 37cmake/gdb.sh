gdb program
    set args .....

简单命令：
    start 开始程序
    s  step into
    n  stop over
    c  next breakpoint
    b  line  function  加断电

print 查看变量

gdbserver:
    gdbserver :1234 ev
    
调试core文件：
    生成core文件
    ulimit -c unlimited
        or ulimit -c 100000

    gdb binary core
        如果是直接core dump可以用下面命令找原因
            backtrace  
        start
