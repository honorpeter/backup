/*
 * 使用  递归深度优先搜索
 * 和使用   二叉树的遍历是一样的
 * 唯一不同的是 
 *      二叉树每个树有两个节点  
 *      但图 可以用多个节点 所以使用一个for循环
 *      这个便可以遍历  一个节点的所有子节点
 *      同样 先遍历 然后在回来
 */
static int visited[maxV];       //记录访问过的元素
int pathR(Graph g, int v, int w)
{
    int t;
    if(v == w)  return 1;       //和二叉树遍历  一样截止条件
    visited[v] = 1;             //同样也有  前后    这是先前操作
    for (t = 0; i < g->v; t++) {//使用for循环这样可以遍历所有的子节点
        if(g->adj[v][t] == 1)
            if(visited[t] == 0)
                if(pathR(g, t, w)) return 1;
    }
    return 0;               //也是截止条件  当没有节点需要访问的时候
}



//总的调用函数
int GRAPHpath(Graph g, int v, int w)
{
    int t;
    for (t = 0; t < g->v; t++) {//这个for循环保证   可以让不连通图也可以
                                //访问
        visited[t] = 0;
    }
    return pathR(g,v,w);
}










