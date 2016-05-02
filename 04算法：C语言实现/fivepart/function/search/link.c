/*
 * 处理单个连通图
 */
void  dfsRcc(Graph G, int v, int id)
{
    link t;
    G -> cc[v] = id;        //标记同一个连通图
    for (t = G->adj[v]; t != NULL; t =t -> next)
        if (G->cc[t->v] == -1) {
            dfsRcc(G,t->w,id);
        }
}

/*
 * 预处理函数   每次执行一次 便不需要执行了
 */
int GRAPHcc(Graph G)
{
    int v,id = 0;   //id:   在同一个连通图中 有相同的值
    G -> cc = malloc(G->V *sizeof(int));
    for(v = 0; v < G->V; v++){
        G->cc[v] = -1;          //初始化为-1
    }

    for(v = 0; v < G->V; v++){             //遍历每个连通图
        if(G->cc[v] == -1)      dfsRcc(G,v,id++);//每个id都加1
    }
    return id;
}



/*
 * 判断s和t在图中是否是连通的
 * 邻接表实现
 */
int GRAPHconnect(Graph G, int s, int t)
{
    return G->cc[s] == G->cc[t];//cc数组记录
}






