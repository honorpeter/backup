异常与断言：
    程序中通常会发生三种错误：
        用户错误
                是指预期发生的  程序必须预计到这种错误 并做妥善处理
        运行时错误
                他们从来都是非预期的 总是表明程序出现了bug
                因而程序无法从这种错误恢复过来 必须优雅的结束
                    可以使用断言来结束运行
        异常
                可能从错误代码中恢复过来

    Except 接口：
         /function/except/except.h
            使用了宏定义 这样可以让__FILE__ 直接传递过去 用户不用了解
            宏定义 一般都是这么使用的

            使用了宏定义：
                TRY   
                        在try中可以触发异常
                        RAISE
                        RERAISE     如果没有嵌套这里边可以直接触发
                EXCEPT 
                        有嵌套的话便  会跳转到这里 
                ELSE
                        ...
                FINALLY

                END_TRY

                RAISE(e)
                        使用raise实现的 
                RERAISE
                        使用raise实现的 
        实现
         /function/except/except.c
            这个文件中只有一个函数 触发异常用的
                这个函数：
                    使用了一个栈来  来处理嵌套的情况
                    栈不为空：跳转到其他地方
                    如果栈为空 直接触发异常便可
        断言：
            将断言的实现 改变成了 异常处理
            /function/except/assert.h
            /function/except/assert.c







