/*
 * 基于堆有序树实现的优先队列
 * 根据堆有序树的性质 每个父节点都比 子节点的关键字大
 * 所以插入删除操作。。。。。
 */
#include<stdlib.h>    
#include "Item.h"
static Item *pq;
static int N;

void PQinit(int maxN)
{
    pq = malloc((maxN+1)*sizeof(Item));
    N = 0;
}

int PQempty()
{
    return N==0;
}

void PQinsert(Item v)
{
    pq[N++] = v;
    fixup(pq,N);
}
Item PQdelmax()
{
    exch(pq[1],pq[N]);
    fixDown(pq,1,N-1);
    return pq[N--];
}












