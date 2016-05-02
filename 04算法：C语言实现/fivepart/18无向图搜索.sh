无向图搜索：
    深度优先搜索：
        和图的遍历算法思考方式一样
        只是 图遍历 每个节点可以有多个子节点
        二叉树只有两个子节点    所以使用for循环来遍历

        code:
            function/search/...

    图搜索ADT:
        可以处理连通图和非连通图
            function/search/search.c


    图连通性问题:
        客户程序可以在线性时间内 测试任何顶点对是否连通
            function/search/link.c

    广度优先搜索
        和二叉树的层次遍历实现方式一样
        使用一个 队列实现
        code:
            function/search/BFS.c


 通用图搜索：
        使用栈 便是深度优先搜索
        使用队列便是广度优先搜索

        也可以使用随机队列实现 图搜索
            function/search/random
        也可以使用优先队列实现 图搜索
        。。。。很多的实现方式






