/*
 * 如果存在话   那么图一定是一个连通图了
 * 所以 不需要考虑 不连通图了
 * 思路：
 *      使用深度优先 遍历 图中的每个节点 当找到对应的节点的时
 *      判断是否走了v的节点 如果走了v个节点的话 那么就全部走完了
 *      否则 不是
 */
static int visited[maxV];

int pathR(Graph g, int v, int w, int d)
{
    int t;
    if(v == w){         //截止条件
        if(d == 0)
            return 1;
        else
            return 0;
    }
    visited[v] = 1;     //先前标记

    for(t = 0; t < g ; t++){//遍历所有
        if(g[v][t] == 1){
            if(visited[v] == 0)
                if(parthR(g,t,w,d-1)) return 1;
        }
    }
    visited[v] = 0;     //后退的时候 如果不符合条件 清零 然后可以开始下一条
                        //路径
    return 0;           //同样也是截止条件  当没有节点要访问的时候
}

int GRAPHpathH(Graph g, int v, int w)
{
    int t;
    for(t = 0; t < g->v ;t++) 
        visited[t] = 0;
    return pathR(g,v,w,g->v-1);//不考虑 不连通的图 所以不用for循环
}













