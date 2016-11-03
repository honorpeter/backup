/*
 * 在一个对应与有向图的DFS深林中 如果指向已经访问节点的边
 * 通向一个更高的后序编号的节点  则它是一条后向边
 * 否则 如果它通向一个更低前序编号的节点 则是一个交叉边 如果通向一个更高
 * 前序编号的节点 是一条下向边
 *  
 *  下面的程序打印 这些边
 *  应用：
 *      使用DFS检查每条边时  当且精当没有碰到任何后向边时 
 *      有向图才是一个DAG
 */
void dfsR(Graph G, Edge e)
{
    link t;
    int i, v, w = e.w;
    Edge x;
    show("tree",e);//打印normal边
    pre[w] = cnt++;//记录遍历顺序  前序遍历
    for(t = G->adj[w]; t != NULL; t = t->next){
        if(pre[t->w] == -1)
            dfsR(G,EDGE(w,t->v));
        else{
            v = t->v;
            x = EDGE(w,v);
            if(post[v] == -1)
                show("back",x); //后序边
            else if(pre[v] > pre[w])
                show("down",x); //打印前序边
            else
                show("cross",x);//打印交叉边
        }
    }
    post[w] = cntP++;//后序遍历

}
