#include<stdlib.h>    
#include<stdarg.h>    
#include<string.h>    
#include "assert.h"
#include "seq.h"
#include "array.h"
#include "arrayrep.h"
#include "mem.h"

#define T Seq_T

struct T{
    struct Array_T array;// 保存值
    int length;             //元素个数
    int head;               //保存索引为0的值
};


T Seq_new(int hint)
{
    T seq;
    assert(hint >= 0);
    NEW0(seq);//将length和head初始化为0 
    if(hint == 0)
        hint = 16;
    ArrayRep_init(&seq->array, hint , sizeof(void *), 
            ALLOC(hint *sizeof (void *)));
    return seq;
}

T Seq_seq(void *x, ...)
{
    va_list ap;
    T seq = Seq_new(0);

    va_start(ap,x);
    for( ; x; x = va_arg(ap,void *))
        Seq_addhi(seq,x);
    va_end(ap);
    return seq;
}

void Seq_free(T seq)
{
    assert(seq && *seq);
    assert((void *x)*seq == (void *)&(*seq)->array);//判断地址是否相等
    Array_free((Array_T *)seq);
}

int Seq_length(T seq)
{
    assert(seq); 
    return seq->length;
}


/*
 * 序列中的第i个值 对应数组元素中的索引值为(head + i)mod array.length
 */
void *Seq_get(T seq, int i)
{
    assert(seq);
    assert(i > =0 && i <= seq->length);
    return ((void **)seq->array.array)[(seq->head + i)%seq->array.length];
}

void *Seq_put(T seq, int i, void *x)
{
    void *prev;

    assert(i >= 0&& i < seq->length);
    prev = ((void **)seq->array.array)[(seq->head + i)%seq->array.length];
    ((void **)seq->array.array)[(seq->head + i)%seq->array.length] = x;
    return prev;
}

void *Seq_remhi(T seq)
{
    int i;
    assert(seq);
    assert(seq -> length >0);
    i = --seq->length;
    return ((void **)seq->array.array)[(seq->head + i)%seq->array.length];
}

void *Seq_remlo(T seq)
{
    int i =0 ;
    void *x;

    assert(seq);
    assert(seq -> length > 0);
    x = ((void **)seq->array.array)[(seq->head + i)%seq->array.length];
    
    seq -> head = (seq->hand + 1)%seq->array.length;
    return x;
}

void *Seq_addhi(T seq, void *x)
{
    int i;
    
    assert(seq);
    if(seq->length == seq->array->length)
        expand(seq);
    i = seq->length++;
    return ((void **)seq->array.array)[(seq->head + i)%seq->array.length]=x;
}

void *Seq_addlo(T seq, void *x)
{
    int i = 0;
    assert(seq);
    if(seq -> length == seq->array.length)
        expand(seq);
    if(--seq->head < 0)
        seq->head = seq->array.length-1;
    seq->length++;
    return ((void **)seq->array.array)[(seq->head + i)%seq->array.length]=x;
}

static void expand(T seq)
{
    int n = seq->array.length;
    Array_resize(&seq->array,2*n);
    if(seq->head > 0){
        void **old = &((void **)seq->array.array)[seq->head];
        memcpy(old+n, old, (n -seq->head) *sizeof(void *));
        seq->head += n;
    }

}

























