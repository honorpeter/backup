最小生成树：
        无向图：
            因为边包含权重 所以修该节点的数据结构
                typedef struct {int v; int w; double wt;};
                Edge EDGE(int , int ,double);

                加权图ADT： 邻接矩阵
                    #include <stdlib.h>
                    #include "GRAPH.h";
                    struct graph{
                        int R; 
                        int E ;
                        double **adj;
                    };

                    Graph GRAPHinit(int v)
                    {
                        int v;
                        Graph G = malloc(sizeof *G);
                        G->adj = MATRIXdouble(V,V,maxWT);
                        G->V = V;
                        G->E = 0;
                        return G;
                    }

                    void GRAPinsertE(Graph G, Edge e)
                    {
                        if(G->adj[e.v][e.w] == maxWT) G->E++;
                        G->adj[e.v][e.w] = e.wt;
                        G->adj[e.w][e.v] = e.wt;
                    }

                    邻接矩阵：
                            #include "GRAPH.h"
                            typedef struct node *link;
                            struct node { int v; double wt; link next; };
                            struct graph { int V; int E; link *adj; };
                            link NEW(int v, double wt, link next)
                              { link x = malloc(sizeof *x);
                                x->v = v; x->wt = wt; x->next = next;     
                                return x;                         
                              }
                            Graph GRAPHinit(int V)
                              { int i;
                                Graph G = malloc(sizeof *G);
                                G->adj = malloc(V*sizeof(link));
                                G->V = V; G->E = 0;
                                for (i = 0; i < V; i++) G->adj[i] = NULL;
                                return G;
                              }
                            void GRAPHinsertE(Graph G, Edge e)
                            { link t; 
                                int v = e.v, w = e.w;
                                if (v == w) return;
                                G->adj[v] = NEW(w, e.wt, G->adj[v]);
                                G->adj[w] = NEW(v, e.wt, G->adj[w]);
                                G->E++;
                            }

最小生成树算法：
        普利姆算法： 稠密图的首选：
            将图中的边分为 最小树中的边 和 非最小树上的边
                每次 在非最小树的边 寻找一个最小的边 添加到树上 知道所有。。

                实现：
                    static int fr[maxV]; 
                    #define P G->adj[v][w];
                    void GRAPHmstV(Graph G , int st , double wt[])
                    {
                        int v, w , min;
                        for(v = 0; v < G->V; v++){
                            st[v] = -1;
                            fr[v] = v;
                            wt[v] =maxWT;
                        }
                            st[0] = 0;
                            wt[G->V] = maxVT;
                            for(min = 0 ; min != G->V;){
                                v = min;
                                st[min]= fr[min];
                                for(w= 0, min = G->V; w < G->V; w++)
                                    {
                                        if(st[w] == -1)
                                        {
                                            wt[w ] = P;
                                            fr[w] = v;
                                        }
                                        if(wt[w] < wt[min]) min = w;
                                    }
                            }

                    }

            优先级优先搜索： 邻接表 每次输出最小的边
                                    #define GRAPHpfs GRAPHmst
                static int fr[maxV];
                static double *priority;
                int less(int i, int j)
                  { return priority[i] < priority[j]; }
                #define P t->wt
                void GRAPHpfs(Graph G, int st[], double wt[])
                  { link t; int v, w; 
                    PQinit(); priority = wt; 
                    for (v = 0; v < G->V; v++)
                      { st[v] = -1; fr[v] = -1; }
                    fr[0] = 0; PQinsert(0);
                    while (!PQempty())
                      {
                        v = PQdelmin(); st[v] = fr[v]; 
                        for (t = G->adj[v]; t != NULL; t = t->next)
                          if (fr[w = t->v] == -1) 
                            { wt[w] = P; PQinsert(w); fr[w] = v; }
                          else if ((st[w] == -1) && (P < wt[w])) 
                            { wt[w] = P; PQdec(w); fr[w] = v; }
                      }
                  }


        Kruskal算法：
            先将所有的边排序 从小到大的顺序 每次添加一个最小的并检查有没有
                环产生 如果有的话 跳过这条边
                    void GRAPHmstE(Graph G, Edge mst[])
                    { int i, k; Edge a[maxE]; 
                        int E = GRAPHedges(a, G);
                        sort(a, 0, E-1);
                        UFinit(G->V);
                        for (i= 0, k = 0; i < E && k < G->V-1; i++)
                        if (!UFfind(a[i].v, a[i].w))
                            {
                            UFunion(a[i].v, a[i].w);
                            mst[k++] = a[i];
                            }
                    }
                    
                                        
                        







