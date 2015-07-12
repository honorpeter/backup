#include<stdlib.h>    
#include "Item.h"
#define null(A) (key(st[A]) == ke(NULLitem))
static int N, M;    //N记录插入的元素个数   M记录离散表的大小
static Item *st;
void STinit(int max)
{
    int i;
    N = 0; 
    M = 2*max;//创建为元素大小二倍的个数 这样有助于 减小冲突
    st = malloc(M * sizeof(Item));
    for(i = 0; i < M; i++ ) st[i] = NULLitem;
}

int STcount()
{
    return N;
}

void STinsert(Item item)
{
    key v = key(item);
    int i = hash(v,M);
    while(!null(A)) i = (i+1) %M;//取摸运算防止 超出 离散表元素个数
    st[i] = item;
    N++;
}

Item STsearch(key v)
{
    int i = hash(v,M);
    while(!null(i)){
        if eq(v,key(st[i])) return st[i];
        else 
            i = (i+1) %M;
    }
    return NULLitem;
}

void STdelete(Item item)
{
    int j, i = hash(key(item),M);
    Item v;
    while(!null(i)){
        if eq(key(item),key(st[i]))
            break;
        else
            i = (i + 1) %M;
    }
    if(null(i)) return ;
    st[i] = NULLitem;
    N --;
        //删除完 新的元素之后  重新插入一下 这个元素后面的元素
    for(j = i+1; !null(j); j=(j + 1)%M, N--){
        v = st[j];
        st[j] = NULLitem;
        STinsert(v);
    }
}









