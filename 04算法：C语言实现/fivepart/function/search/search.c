/*
 * 深度优先搜索
 * 和树的遍历的一样
 */
#define dfsR search
// 邻接矩阵实现
// cnt是一个全局变量  
void dfsR(Graph g, Edge e)
{
    int t, w = e.w;         //记录节点是否被访问过 
    pre[w] = cnt ++;        //记录节点访问的次序    w表示节点cnt表示次序
    for( t = 0; t < G->V; t++){//遍历所有的节点  只能在一个连通图内
        if(G->adj[w][t] != 0)
            if(pre[t] == -1)
                dfsR(G,EDGE(w,t));
    }
}



//邻接表实现

void dfsR(Graph G, Edge e)
{
    link    t;
    int     w = e.w;
    pre[w] = cnt++;
    for(t = G->adj[w]; t != NULL; t = t->next){
        if(pre[t-v] == -1)
            dfsR(G,EDGE(w,t->v));
    }
}


//图搜索ADT函数

static int cnt , pre[maxV];
void GRAPHsearch(Graph G)
{
    int v;
    cnt = 0;
    for(v = 0; v < V; v++) pre[v] = -1;
    for(v = 0; v < G->V; v++){
        if(pre[v] == -1)
            search(G,EDGE(v,v));//调用上面的两个任意一个函数
    }
}
                                                    





