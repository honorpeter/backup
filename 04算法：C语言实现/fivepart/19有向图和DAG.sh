有向图：
        带有箭头表示方向    从A到B和从B到A是不同的路线

        求有向图逆图：
            矩阵形式实现    创建一个新的矩阵 然后在重新插入
            function/directGraph/reverse.c


    有向图中DFS 搜索：
        和无向图的搜索基本上一样
            function/directGraph/dfs.c
    判断有向图是否是DAG图：
        DAG图 是一个具有先后顺序的图
        只能指向后面的节点
            /function/directGraph/reverse.c 

    可达性和传递闭包：
        可达性：
                在有向图： 从一个顶点 是否可以到达其他的顶点 
        传递闭包：
                在有向图中： 从一个顶点a到顶点b  b到c顶点 那么a也可以到c
                    这就是传递性

                计算可达性 使用传递闭包：
                    布尔矩阵乘法：
                     function/directGraph/matrix.c
                对于有向图 可以支持很定时间的可达性测试
                    预处理是用的空间与v平方成正比 所需时间与v立方成正比
                    function/directGraph/wrashall.c

                基于DFS的传递闭包：
                    function/directGraph/wrashall.c
                    


DAG： 有向无环图：
        规划问题：
            已知一个任何集合 一个偏序 指定了某些任务 必须在其他一些任务
            前完成  那么如何规划这些任务 使得在偏序的前提下完成所有任务
            这种问题成为 称为 拓扑排序

            从某种意义上说DAG是部分树 部分图 。 处理他们的时候可以使用
            当做一个树处理
                遍历DAG：
                    void traverseR(Dag D, int w)
                    {
                        link t;
                        visit(w);
                        for(t = D->adj[w]; t != NULL; t = t->next) {
                                traverseR(D, t->v); 
                        }
                    }


拓扑排序：
    重新标记：
        已知一个DAG 重新标记他的顶点 让每条有向边从一个底编号顶点 指向高编号
    重排：
        重排所有顶点成一条水平直线 让所有的有向边 从左指向右 

            










