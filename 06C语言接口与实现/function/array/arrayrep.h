#ifndef ARRAYREP_INCLUDED
#define ARRAYREP_INCLUDED


#define T Array_T
struct T{
    int length;
    int size;
    //这里只是保存了一个 指针 指向一块区域 存放的时候 按字节存放 取也一样
    char *array;
};

extern void ArrayRep_init(T array, int length, int size,void *ary);
#undef T
#endif









