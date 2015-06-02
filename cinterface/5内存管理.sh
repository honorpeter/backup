接口:
        实现的函数包括异常处理  
            一般包括 file 和 line
        一般使用 宏 来简化函数      __FILE__ __LINE__

        实现函数 一般要使用     extern
        /function/mem/mem.h
        这个函数实现了简单的功能    malloc realloc 以及 异常检查
实现:
        /function/mem/mem.c





稽核实现:
        接口 一样 实现方式不同

        维护了一张哈希表    来管理释放的内存当你 再需要的时候 
        从空闲的列表中分配给你      这样可以避免系统调用带来的开销

        哈希表:
            指向每个像操作系统申请的内存   
                使用一个环连接 来连接空闲的内存块
                freelist作为环连接的开始和结尾

        实现/funciton/mem/memchk.c










