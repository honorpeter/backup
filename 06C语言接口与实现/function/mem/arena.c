#include<stdlib.h>    
#include<string.h>    
#include "assert.h"
#include "except.h"
#include "arena.h"
#define T Arena_T
#define THRESHOLD 10
const Except_T Arena_NewFailed = {"Arena Creation Failed"};
const Except_T Arena_Failed = {"Arena Allocation Failed"};

struct T{
    T prev;             //指向大内存块的起始  此处保存恶露一个Arena_T的实例
    char *avail;        //指向大内存块中第一个空闲位置 从这里开始到limit都是
    char *limit;        //可用的内存
};
union align{
    int i;
    long l;
    long *lp;
    void *p;
    void (*fp)(void);
    float f;
    double d;
    long double;
};

union header{
    struct T b;
    union align a;
};

static T freechunks;        //申明一个实体 来指向第一个内存快开始的位置
                            //栈式结构...
static int nfree;

T Arena_new(void)
{
    T arena = malloc(sizeof(*arena));   //创建一个 arena实体 来管理内存快
    if(arena == NULL)
        RAISE(Arena_NewFailed);
    arena-> prev = NULL;
    arena-> limit = arena -> avail = NULL;
    return arena;
}

void Arena_dispose(T *ap)
{
    assert(ap && *ap);
    Arena_free(*ap);
    free(*ap);
    *ap = NULL;
}

/*
 * 分配空间     分配N字节的内存空间 在N不大于limit-avail时  将avail加N
 * 返回avail的原值便可  
 * 如果N大于的话    需要调用malloc分配一个新的大内存块 (在新的大内存块的头
 * 建立为一个arena实体)  并arena的各个
 * 字段使之描述原来的大内存的avail limit位置 然后分配继续进行.
 *
 * 因而各个大内存块头部的Arean_T 结构实体 栈式结构  让新的内存块的Arena_T来
 * 管理 原来久的avail limit地址
 * 
 */
void *Arena_alloc(T arena, long nbytes,
                    const char *file, int line)
{
    assert(arena);
    assert(nbytes > 0);
    nbytes = ((nbytes +sizeof(union align ) -1) /
            (sizeof(union align))) * (sizeof (union align));
                //堆nbytes向上舍入

    while(nbytes > arena ->limit - arena-> avail){
            //当没有足够的内存的时候 进行的操作
            //分配新的内存块 并在上面初始化 Arena_T 实体来管理这个内存快
            //刚申请的内存快 和原来的内存快 一起通过链表连接起来 是一个栈
            //使用一个栈 将这几个内存快连接起来
        T ptr;
        char *limit;

        if((ptr = freechunks ) != NULL ){    //判断是否为空栈
            freechunks = freechunks -> prev;//如果不为空 指向下一个内存快
            nfree--;                        //查看空闲内存快是否够用
            limit = ptr -> limit;
        }else{                              //为空栈 分配一个大的内存快
            long m = sizeof(union header) +nbytes +10*1024;
            ptr = malloc(m);
            if(ptr == NULL){
                if(file == NULL)
                    RAISE(Arena_Failed);
                else
                    Except_raise(&Arena_Failed,file,line);
            }

            limit =(char *)ptr + m;
        }

        *ptr = *arena;      
        arena -> avail = (char *)((union header *)ptr + 1);
        arena -> limit = limit;
        arena -> prev = ptr;
    }

    //当有足够的内存分配的时候的操作 
    arena ->avail += nbytes;
    return arena->avail - nbytes;
}


void *Arena_calloc(T arena, long count , long nbytes,
                    const char *file, int line)
{
    void *ptr;

    assert(cout > 0);
    ptr = Arena_alloc(arena, count*nbytes,file,line);
    memset(ptr,'\0',count*nbytes);
    return ptr;

}

void Arena_free(T arena)
{
    assert(arena);

    while(arena -> pre){
        struct T tmp = *arena -> pre;// 先-> 再*
        if(nfree < THRESHOLD){
            arena->prev-> prev = freechunks;    //空闲链表栈式 存储
            freechunks = arena-> prev;
            nfree++;    //  记录空闲内存快的多少
            freechunks->limit = arena->limit;
        }else
            free(arena -> prev);
                        // 空闲链表中的 空闲内存块 大于10的话 
                        //直接释放给 内核
        
        *arena = tmp;
    }
    assert(arena->limit == NULL);
    assert(arena->avail == NULL);
}









