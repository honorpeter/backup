#include<stdlib.h>    
#include<stdio.h>
#define <stddef.h>
#include "assert.h"
#include "except.h"
#include "mem.h"

const Except_T Mem_Failed = {"Allocation Failed"};
//实现  Mem_Failed函数   
void *Mem_alloc(long nbytes, const char *file, int line)
{
    void *ptr;
    assert(nbytes > 0);
    ptr = malloc(nbytes);
    if(ptr == NULL){
        if(file == NULL)
            RAISE(Mem_Failed);      //失败触发异常
        else
            Except_raise(&Mem_Failed,file,line);
    }
        
    return ptr;
}


//实现Mem_calloc函数
void *Mem_calloc(long count, long nbytes,char *file, int line)
{
    void *ptr;
    
    assert(count > 0);
    assert(nbytes > 0);
    ptr = calloc(count , nbytes);
    if(ptr == NULl){
        if(file == NULL)
            RAISE(Mem_Failed);
        else
            Except_raise(&Mem_Failed,file,line);
    }
        
    return ptr;

}

void Mem_free(void *ptr, const char *file , int line)
{
    if(ptr)
        free(ptr);
}

void *Mem_resize(void *ptr, long nbytes, const char *file, int line)
{
    assert(ptr);
    assert(nbytes > 0);
    ptr = realloc(ptr,nbytes);
    if(ptr == NULL){
        if(file == NULL)
            RAISE(Mem_Failed);
        else
            Except_raise(&Mem_Failed,file,line);
    }
    return ptr;
}








