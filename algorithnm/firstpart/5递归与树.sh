分治法：
        使用分治法求最大值：

        Item max(Item a[], int l, int r)
        {
            Item u, v;
            int m = (l + r) / 2;

            if( l == r) return a[l];

            u = max(Item a[], l, m);
            v = max(Item a[], m+1, r);

            if( u > v) 
                return u;
            else 
                return v;
        }

        分治法：
            从一个维度入手  将这个维度分为几个小的部分  再次分下去
            首先    从这个维度出发  将这个维度分为一个树形结构
                    树形结构：
                            直线    孩子节点为1
                            二叉树  孩子节点为2
                            三叉树            3
            再写出递归函数
                :   使用三种遍历方式    遍历树  
                    再加上对节点的操作 函数之间的通信

            递归之间各个函数通信：
                使用return
                使用全局变量
                使用静态变量

            循环语句也可以向递归那样来解释：
                但是： 循环语句只能 选择树中    一条路 走下去   
                        不能遍历所有的节点。。。。
                但是： 循环语句可以借助于 队列和栈进行回溯  实现遍历
                        所有节点
                        当借助栈的时候 和 递归遍历的顺序一样

动态规划：
        两个递归树的相加
        斐波那契树：    
            int F(int i)
            {
                if( i < 1) return 0;
                if( i == 1) return 1;

                return F( i-1 ) + F(i - 2);

            }
            有大量的重复计算：
                    如i =10         
                                10
                        9                   8       
                    8       7           7       6   这个分支有重复

            动态规划避免重复：  使用一个外部数组存放计算好的值
            int F(int i)
            {
                int t;
                if( knownF[i] != unknow) return knowF[i];
                if(i == 0) t = 0;
                if( i == 1) t = 1;
                if(i > 1)  t = F(i -1) + F(i - 2);
                return knowF[i] = t;

            }


树的遍历：
        递归的 前序 中序 后序遍历：
            改变(*visit)(h);的位置  便是不同的遍历方式

        void traverse(link h, void (*visit)(link))
        {
            if( h == NULL){
                return ;
            }
                (*visit)(h);
            traverse(h -> l, visit);
            traverse(h -> r, visit);
        }

        非递归遍历：
            基于栈的遍历    前序遍历 
            void traverse(link h, void (*visit)(link))
            {
                STACKinit(max);
                STACKpush(h);
                while( !STACKempty()){
                    (*visit)(h = STACKpop());
                    if( h -> l != NULL){
                        STACKpush(h -> l);
                    }
                    if( h -> r != NULL){
                        STACKpush(h -> r);
                    }
                }
            }

            层次遍历：  基于队列的
                void traverse(link h, (*visit)(link h))
                {
                    QUEUEinit(max);
                    QUEUEput(h);

                    while(!QUEUEempty()){
                        (*visit)(h = QUEUEget)();

                        if( h -> l != NULL) QUEUEput(h -> l);
                        if( h -> r != NULL) QUEUEput(h -> r);
                    }
                }

        快速打印树：
            void printnode(char c, int h)
            {
                int i;
                for(i = 0; i<h ; i++){
                    printf("%c\n",c);
                }
            }

            void show(link x, int h)
            {
                if( x == NULL ){
                    printnode('*', h);
                    return ;
                }
                show( x -> r, h + 1);
                
                printnode(x -> item, h);
                show(x -> l, h + l);
            }
    线索二叉数
        将节点中 的空指针 指向前面的节点
        再加入一个ltag 来判断是之心指向孩子还是前序

        使用中序遍历 来让空指针指向 前序和后序
            树 存储方式 是以树的形式存储
            遍历方式： 前序 中序 后序 。。。。

    树 深林 和二叉树相互转换：
        深林： 由多个树组成：
    树和二叉树相互转换：
        首先连接 兄弟节点 
        然后    去掉父节点和右子树之间的连线
    深林和二叉树之间的转换：
        首先： 将每个树变为 二叉树
        然后： 将每个树的根节点  相互连接到一起

    树和深林的遍历：
        前序遍历:
        后序遍历：
    树和深林的前序遍历和转化后的二叉树的前序遍历一样
    后序遍历和 中序遍历一样

    赫夫曼编码：
        用作数据压缩:

        赫夫曼树：
                赫夫曼  最优二叉树
                从根节点开始    
                    右子树 为 1
                    左子树为  0
    构建赫夫曼编码：
        统计数据中每个字符出现的频率        按照频率大小进行排序
            从最小的开始合成一个节点 频率相加  再取数构建    构建赫夫曼树
            左边的节点小于右边的节点

        使用table：
            使用table将一个字符和011101。。这样的0 1 对应起来
                这里的字符便是 原文的字符   使用0 1序列代替字符 












