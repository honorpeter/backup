/*
 * 使用队列实现的广度优先遍历
 * st数组记录 访问的父节点的先后顺序
 */
#define bfs search

void bfs(Graph G, Edge e)
{
    int v, w;
    QUEUEput(e);
    while(!QUEUEempty()){
        if(pre[(e = QUEUEget()).w] == -1){
            pre[e.w] = cnt++;
            st[e.w] = e.v;
            for(v = 0; v < G->V; v++){
                if(G->adj[e.w][v] == 1)
                    if(pre[v] == -1)
                        QUEUEput(EDGE(e.w,v));
            }
        }
    }
}

/*
 * 上面的实现有很多的缺点 
 * 效率不高
 * 因为它每次都要把很多无用的顶点放到 队列中
 * 没有必要只需要放 实际顶点的个数便可以了
 * 顶点入队的时候 进行标记
 */

void bfs(Graph G, Edge e)
{
    int v, w;
    QUEUEput(e);
    pre[e.w] = cnt++;
    while(!QUEUEempty()){
        e = QUEUEget();
        w = e.w;
        st[w] = e.w;
        for (v = 0; v < G->V; v++) {
            if((G->adj[w][v] == 1) && (pre[v] == -1)){
                QUEUEput(EDGE(w.v));
                pre[v] = cnt++;
            }
        }
    }
}







