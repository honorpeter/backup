#ifndef MEM_INCLUDED
#define MEM_INCLUDED

#include "except.h"
extern const Except_T Mem_Failed;
extern void *Mem_alloc(long nbytes, const char *file, int line);
                            //这个函数分配n个字节的内存返回指向第一个指针
extern void *Mem_calloc(long count, long nbytes, const char *file,
                         int line);
                            //这个函数分配n的元素 的内存 并且都初始化为0
extern void Mem_free(void *ptr, const char *file, int line);
extern void *Mem_resize(void *ptr, long nbytes,
                        const char *file, int line);

#define ALLOC(nbytes) \
    Mem_alloc((nbytes),__FILE__,__LINE__)
#define CALLOC(count,nbytes) \
    Mem_calloc((count),(nbytes),__FILE__,__LINE__)

#define RESIZE(ptr,nbytes) ((ptr) = Mem_resize((ptr), \
                (nbytes),__FILE__,__LINE__))
#define FREE(ptr) ((void)(Mem_free((ptr), \
                __FILE__,__LINE__),(ptr)=0))
                //释放指针 然后再 让指针变为NULL
#define NEW(p) ((p) = ALLOC((long)sizeof*(p)))
#define NEW0(p) ((p) = ALLOC(1,(long)sizeof*(p)))
#endif












