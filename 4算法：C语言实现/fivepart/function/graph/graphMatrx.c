#include<stdlib.h>    
#include "graph.h"


struct graph{
    int v;      //存放顶点的个数
    int e;      //存放边的个数  添加到图中的边的个数
    int **adj;
};

Graph GRAPHinit(int v)
{
    Graph g = malloc( sizeof *g);
    g->v=v;
    g->e=0;
    g->adj = MATRXint(v,v,0);//分配一个     矩阵  填充0或1 代表是否存在
    return g;
}

void GRAPHinsert(Graph g, Edge e)
{
    int v = e.v , w = e.w;
    if(g->adj[v][w]==0)
        g->e++;
    g->adj[v][w]=1;
    g->adj[w][v]=1;
}

void GRAPHremove(Graph g, Edge e)
{
    int v = e.v , w = e.w;
    if(g->adj[v][w] == 0)
        g->e--;
    g->adj[v][w] = 0;
    g->adj[w][v] = 0;
}

int GRAPHedges(Edge a[], Graph g)//将矩阵的值 转出来
{
    int v, w, e=0;
    for (v = 0; v < g->v; v++) {
        for(w = v+1; w<g->v; w++)
            if(g->adj[v][w] == 1)
                a[e++] = EDGE(v,w);
    }
    retrun e;
}

int **MATRXint(int r, int c, int val)
{
    int i,j;
    int **t = malloc(r*sizeof(int *));
    for(i = 0; i< r; i++){
        for(j = 0; j < c; j++)
            t[i][j] = val;      //二维数组的初始化
    }
    return t;
}










