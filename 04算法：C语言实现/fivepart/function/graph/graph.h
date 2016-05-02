typedef struct {
    int v;
    int w;
}Edge;//边的数据结构

Edge EDGE(int , int);//返回边

typedef struct graph *Graph;
Graph GRAPHinit(int);//初始化tu
void GRAPHinsert(Graph ,Edge);
void GRAPHremove(Graph, Edge);
int GRAPHedges(Edge[], Graph G);
Graph GRAPHcopy(Graph);
void GRAPHdestory(Graph);










