最短路径：
        三种情况：
                从一个顶点到另一个顶点  的最短路径
                从一个顶点到其他的所有的顶点的最短路径
                任意两个顶点之间的最短路径


        Dijkstra算法：
                解决非负权重网络中的单源点 最短路径 从一个顶点到其他所有顶点
                基本思路：
                    实现使用了一个顶点的优先队列（按照离源点的距离排序）
                    用源点优先级0， 其他顶点优先级maxWT来初始化队列
                    然后进行循环 将最低优先级的顶点从队列中移到SPT中,
                    并沿着他的依附边执行 松弛运算

                    边松弛：
                        测试沿着一条已知的边 是否得到通向目标顶点的一条
                            最短路径
                        路径松弛：测试通过一个已知顶点 是否可以得到一条
                            连通其他两个已知顶点的新的最短路径 
                    #define GRAPHpfs GRAPHspt
                    #define P (wt[v] + t->wt)
                    void GRAPHpfs(Graph G, int s, int st[], double wt[])
                    { 
                        int v, w;  link t;
                        PQinit(); priority = wt;
                        for (v = 0; v < G->V; v++)
                        { 
                            st[v] = -1; wt[v] = maxWT; PQinsert(v);
                        }
                        wt[s] = 0.0; PQdec(s);
                        while (!PQempty())
                        if (wt[v = PQdelmin()] != maxWT)
                            for (t = G->adj[v]; t != NULL; t = t->next)
                                if (P < wt[w = t->v]) 
                                { wt[w] = P; PQdec(w); st[w] = v; }
                      }
                                        
                                       









