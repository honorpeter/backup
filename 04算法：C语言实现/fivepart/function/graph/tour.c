/*
 * 当且仅当图为连通图
 * 且所有顶点的偶数度时 这个图具备欧拉环游
 *      证明：
 *          因为    经过每条边 所以必定连通图   
 *          有进有出 必定为2的倍数
 *
 *
 *
 *  当且仅当图为连通  且刚好有两个顶点为奇数度是
 *   改图才有一条欧拉路径
 *
 */
//线性时间的欧拉路径

#include "STACK.h"
int  path(Graph g, int v)
{
    int w;
    for( ; g->adj[v] != NULL; v=w){
        STACKpush(v);
        w = g->adj[v]->v;
        GRAPHremoveE(g,EDGE(v,w));
    }
    return v;
}

void pathEshow(Graph g, int v, int w)
{
    STACKinit(g->e);
    printf("%d",w);
    while((path(g,v) == v) && !STACKempty()){
        v = STACKpop();
        printf("-%d",v);
    }
    printf("\n");
}









