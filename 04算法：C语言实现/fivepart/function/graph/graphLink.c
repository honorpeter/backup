#include<stdlib.h>    
#include "graph.h"

typedef struct node *link;
struct node{
    int v;          //存放节点 标号 每个节点有唯一的标号
    link next;      //连接下一个节点
};

struct graph{
    int v;
    int e;
    link *adj;
};

link NEW(int v, link next)
{
    link x= malloc(sizeof*x);
    x->v = v;
    x->next = next;
    return x;
}
Graph GRAPHinit(int v)
{
    int i;
    graph g = malloc(sizeof *g);//分配控制图的结构
    g->v = v;
    g->e = 0;
    g->adj = malloc(v*sizeof(link));//分配 v的顶点 以备连接数组
    for(i = 0 ; i < v; i++ )
        g->adj[v] = NULL;
    return g;
}

Graph GRAPH
Graph GRAPHinsertE(Graph g, Edge e)
{
    int v = e.v, w = e.w;
    g->adj[v] = NEW(w,g->adj[v]);
    g->adj[w] = NEW(v, g->adj[w]);
    g->e++;
}

int GRAPHedges(Edge a[], Graph g)
{
    int v, e=0;
    link t;
    for (v = 0; v < g->v; v++) {
        for(t = g->adj[v]; t != NULL; t = t->next)
            if(v < t->v)
                a[e++] = EDGE(v,t->v);
    }
    retrun e;

}








