归约：
        归约是一类并行算法：对传入的N个输入数据，使用一个二元的符合结合律的
            操作符 生成1个结果      这类操作包括取最小数，最大，求和，平方
            求和，逻辑与 逻辑或 向量点积
            归约是其他高级运算中要用的基础算法，如扫描

两遍归约：
        包含两个阶段：一个内核执行NumBlocks个并行归约，其中NumBlocks是指
            用来调用内核的线程块数，得到的结果写入到一个中间变量数组，最终
            的结果通过一个线程块第二遍调用同一个内核在中间爱你数组基础上生成
                reducetion1Templated.cuh

            位于共享内存的数组用来累计每个线程块内的归约，七大小取决于块的
                线程数，所以当内核启动时，必须指定该值，块的线程数必须是2的
                幂次方
            优化：当线程数的大小低于硬件线程束的大小32 无需调用__syncthreads
                函数 reduction2Templated.cuh

            优化：
                模板展开优化， 减少if语句条件判断
                reduction3Templated.cuh

单遍归约:
        两遍归约是针对CUDA线程块无法同步这一问题的部分解决方法。
            使用原子操作和共享内存的组合可避免第二个内核调用

            reduction4SinglePass.cuh    
            reduction4Templated.cuh

原子归约：
            reduction5Atomics.cuh
            reduction5Templated.cuh

任意线程块大小归约：
        
                 reduction6AnyBlockSize.cuh

任意数据类型的归约：
            



    
            









