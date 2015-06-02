#include <stddef.h>
#include "assert.h"
#include "mem.h"
#include "stack.h"
//这里包含 stack.h文件 定义了T是一个指针

#define T Stack_T

struct T{
    int count;
    struct elem{
        void *x;        //这里使用指针 可以容纳任何类型
        struct elem *link;
    } *head;
};

T Stack_new(void)
{
    T stk;

    NEW(stk);   //这里每次 创建一个 指向开始的指针 这样可以保证申请很多
                //内存快 不重复。。。。。
    stk -> count = 0;
    stk -> head = NULL;
    
    return stk;
}

int Stack_empty(T stk)//这里不能使用 const T stk    他会使stk为一个常量指针 
                        //没用  stk本来就是无法修改的 修改的参量
                        //可以使用 const struct T * stk  ????
{
    assert(stk);        //已检查的运行错误
    return stk -> count == 0;
}

void Stack_push (T stk, void *x)
{
    struct elem *t;

    assert(stk);
    NEW(t);
    t -> x = x;
    t -> link = stk -> head;
    stk -> head = t;
    stk -> count++;

}

void *Stack_pop(T stk)
{
    void *x;
    struct elem *t;

    assert(stk);
    assert(stk->count > 0);
    t = stk -> head;
    stk -> head = t -> link;
    stk -> count--;
    x = t -> x;
    FREE(t);
    return x;
}

void Stack_free(T *stk)//传递一个指针的指针 这样可以把stk申请的内存消灭掉
{
    struct elem *t , *u;

    assert(stk && *stk);
    for(t = (*stk) -> head; t; t = u) {
        u = t -> link;
        FREE(*t);
    }
    FREE(*stk);
}











