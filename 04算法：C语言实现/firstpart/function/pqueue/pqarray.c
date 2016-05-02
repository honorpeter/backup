#include<stdlib.h>    
#include "Item.h"

static Item *pq;

static int N;

void PQinit(int maxN)
{
    pq = malloc(sizeof(*pq)*maxN);
    N = 0;
}

int PQempty()
{
    return N == 0;
}

void PQinsert(Item v)
{
    pq[N++] = v;
}

Item PQdelmax()
{
    int j, max =0;
    for(j = 1; j < N; j++){     //找到最大的元素
        if(less(pq[max],pq[j])) max = j;
    }
    exch(pq[max],pq[N-1]);      //交换最大元素和第二个元素的位置
    return pq[--N];
}













