/*
 * tc数组指针tc用于保存传递包矩阵
 */
void GRAPHtc(Graph G)
{ int i, s, t;
    G->tc = MATRIXint(G->V, G->V, 0);
    for (s = 0; s < G->V; s++)
        for (t = 0; t < G->V; t++)
            G->tc[s][t] = G->adj[s][t];
    for (s = 0; s < G->V; s++) G->tc[s][s] = 1;
    for (i = 0; i < G->V; i++)
        for (s = 0; s < G->V; s++)
            if (G->tc[s][i] == 1)
                for (t = 0; t < G->V; t++)
                    if (G->tc[i][t] == 1) G->tc[s][t] = 1; 
}
int GRAPHreach(Graph G, int s, int t)
{ 
    return G->tc[s][t];
}




/*
 * 基于DFS的传递闭包
 * 它以每个顶点为起始点进行单独的DFS来计算 可到达节点集合  得到传递闭包
 */
void TCdfsR(Graph G, Edge e)
{ 
    link t; 
    G->tc[e.v][e.w] = 1; 
    for (t = G->adj[e.w]; t != NULL; t = t->next)
        if (G->tc[e.v][t->v] == 0) 
            TCdfsR(G, EDGE(e.v, t->v)); 
}
void GRAPHtc(Graph G, Edge e)
{ 
    int v, w;
    G->tc = MATRIXint(G->V, G->V, 0);
    for (v = 0; v < G->V; v++) 
        TCdfsR(G, EDGE(v, v));
}
int GRAPHreach(Graph G, int s, int t)
{ 
    return G->tc[s][t]; 
}






