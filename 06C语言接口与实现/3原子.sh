原子：
        原子是一个指针 指向一个唯一的 不可变的序列  序列中包含0个或多个字节
            任何一个原子只能出现一次
            只通过比较两个指针 即可比较这两个序列是否相等

    接口：
        /function/atom/atom.h
        因为是 不可改变的序列  所以返回的值都是 const常量的
    实现：
        /function/atom/atom.c

    这些原子 可以有很多个 多于 2048 便不好了
    存储周期  开始到结束


    0UL 表示 无符号长整型 0
    1UL 表示 无符号长整型 1

    如果不写UL后缀，系统默认为：int, 即，有符号整数。
        











