#ifndef ARENA_INCLUDED
#define ARENA_INCLUDED
#include "except.h"

#define T Arena_T
typedef struct T *T;

extern const Except_T Arena_NewFailed;
extern const Except_T Arena_Failed;

extern T        Arena_new(void);        //返回一个句柄 一系列内存的开始
extern void     Arena_dispose(T *ap);   //释放和*ap内存池关联的内存 并将ap=
                                        //NULl
extern void *   Arena_alloc(T arena, long nbytes,//在一个句柄上 分配空间
                            const char *file, int line);
extern void *   Arena_calloc(T arena, long count,//在一个句柄上 分配空间
                            long nbytes,const char *file, int line);
extern void     Arena_free(T arena);    //释放整个句柄的内存 很多的内存块

#undef T
#endif














