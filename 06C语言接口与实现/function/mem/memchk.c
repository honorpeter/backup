#include<stdlib.h>    
#include<string.h>    
#include "assert.h"
#include "except.h"
#include "mem.h"

#define NDESCRIPTORS 512

#define NALLOC  ((4096 +sizeof(union align)-1) / \
        (sizeof(union align)))*sizeof((union align))//再次分配内存的大小 
                                                    //??

#define hash(p,t)   (((unsigned long)(p) >> 3) & \
        (sizeof(t)/sizeof(t)[0]-1))     //??
                            //t是 一个哈希表 维护的句柄 指针数组
                            //不知 为何减1
                            //哈希函数      地址右移 3位 并对htab大小取摸
                            //除数减一 和 被除数 & 变可以实现取摸操作
                            //好像不能实现啊

union align {
    int i;
    long l;
    long *lp;
    void *p;
    void (*fp);
    float f;
    double d;
    long double ld;
}
static struct descriptor{
    struct descriptor *free; //所有的 空闲内存节点连在一起 连接到freelist
                            //如果这个内存块已经分配给用户 那么指向NULL
    struct descriptor *link;// 解决地址冲突的 下一个节点
    const void *ptr;        //分配的内存块的地址
    long size;              //块的长度
    const char *file;       //filename
    int line;               //line nunber
} *htab[2048];              //节点 

static struct descriptor freelist = { &freelist};// 声明空闲环列表 
                                                //因为为空 所以指向自己


static struct descriptor *find(const void *ptr)//查找 ptr地址是否在htab中
{
    struct descriptor *bp = htab[hash(ptr,htab)];

    while(bp && bp-> ptr != ptr)
        bp = bp -> link;
    return bp;
}


void Mem_free(void *ptr, const char *file , int line)
{
    if(ptr){
        struct descriptor *bp;
        
        if((unsigned long)ptr % (sizeof(union align)) != 0
                || (bp = find(ptr) == NULL || bp -> free))
                    //这里过滤掉了 那些不是严格的对齐值倍数地址 这些地址不坑
                    //是有效的快地址
                    //因为从Mem_alloc返回的地址都是可以对齐的整数块
            Except_raise(&Assert_Failed, file,line);
        bp -> free = freelist.free;  //释放的时候 只是将它加到freelist列表中
        freelist.free = bp;
    }

}


void *Mem_resize(void *ptr,long nbytes, const char *file, int line)
{
    struct descriptor *bp;
    void *newptr;

    assert(ptr);
    assert(nbytes > 0);

    if(((unsigned long)ptr)%(sizeof (union align)) != 0 || 
            (bp = find(ptr)) == NULL || bp -> free)
        Except_raise(&Assert_Failed,file,line)

    newptr =  Mem_alloc(nbytes,file, line);
    memcpy(newptr,ptr,nbytes < bp ->size ? nbytes: bp ->size);
}

void *Mem_calloc(long count, long nbytes, const char *file,int line )
{
    void *ptr;
    assert(count > 0);
    assert(nbytes > 0);
    ptr = Mem_alloc(count * nbytes,file,line);
    memset(ptr,'\0',count*nbytes);      //用0填充
    return ptr;
}
//为一块内存 添加节点 用来管理
static struct descriptor *dalloc(void *ptr,long size,const char *file,
        int line)
{
    static struct descriptor *avail;
    static int nleft;
    
    if(nleft <= 0){
        avail = malloc(NDESCRIPTORS*sizeof(*avail));
        if(avail == NULL)
            return NULL;
        nleft = NDESCRIPTORS;
    }
    avail -> ptr = ptr;
    avail -> size = size;
    avail -> line = line;
    avail -> free = avail -> link = NULL;
    nleft--;
    return avail++;
}

//分配策略: 使用最先适配算法分配内存    搜索freelist查找第一个可以满足大小的
//空闲块 并划分出去 如果没有 那么使用malloc分配一个 添加到freelist中然后在
//搜索 freelist链表
void *Mem_alloc(long nbytes,const char *file, int line)
{
    struct descriptor *bp;
    void *ptr;
    assert(nbytes > 0);
    nbytes = ((nbytes + sizeof(union align)-1)/ (sizeof(union align))) 
        * (sizeof(union align));
                    //将nbytes向上舍入 对齐到align大小的倍数
                    //照应上面的find函数

    for(bp = freelist.free; bp; bp = bp ->free){//第一个大小大于nbytes的空闲
                                                //内存来满足条件
        if(bp->size > nbytes){

            bp - >size -= nbytes;           //将满足那个内存块 切割下来
                                            //并连接到hash表中
            ptr = (char *)bp->ptr + bp->size;
            if((bp = dalloc(ptr,nbytes,file,line)) != NULL){
                unsigned h = hash(ptr, htab);
                bp -> link =htab[h];
                htab[h] = bp;
                return ptr;
            }else{
                if(file ==NULl)
                    RAISE(Mem_Failed);
                else
                    Except_raise(&Mem_Failed,file,line);
            
        }
        if(bp == &freelist){        //如果没有 那么在申请一块内存 来满足 
            struct descriptor *newptr;
            if((ptr = malloc(nbytes + NALLOC))== NULL || 
                    (newptr =dalloc(ptr,nbytes+NALLOC,__FILE__,
                                    __LINE__))==NULL) {
                if(file == NULL)
                    RAISE(Mem_Failed);
                else
                    Except_raise(&Mem_Failed,__FILE__,__LINE__);
            }
            newptr -> free = freelist.free;
            freelist.free=newptr;
        }
    }
    assert(0);
    return NULL;
}


