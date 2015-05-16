优先队列：
        是一种数据结构  其数据项中带有关键字
            支持插入新元素 和 删除最大元素操作的数据结构

        基于优先队列的ADT
            /function/pqueue/..
            基于无序数组的实现： pqarray.c
            还可以是 基于 有序数组
                        有序表
                        无序表
                        堆
                        二项列队
堆数据结构：
        堆是一个节点的集合 表示为数组 其中关键字按照堆有序的
            完全二叉树的形式排列
            数组从1开始  1存放根节点
            那么 i处节点的父节点为 i/2  两个子节点的位置为 2i  2i+1

基于堆的优先队列实现：
    基于堆的算法：
        堆有序树的性质： 每个 父节点 比 子节点的关键字 大
                下面的各种堆化都是为了满足这个性质的
        自底向上的堆化：
            在增加一个节点的优先级时  为了恢复堆的的条件 我们在堆中
            向上移动 需要是交换位置k处节点与父节点 
            只要a[k/2] < a[k] 就继续这一过程
            fixUp(Item a[], int k)
            {
                while(k > 1 && less(a[k/2],a[k])){
                    exch(a[k],a[k/2]);
                    k = k/2;
                }
            }
        自上向下堆化：
            如果一个节点的位置 不满足堆的性质 比子节点的关键字还小
                交换自己和子节点中最大的位置  向下。。。。 直到根节点
            fixDown(Item a[], int k, int N)
            {
                int j;
                while(2*k <= N){
                    j = 2*k;
                    if(j < N && less(a[j],a[j+1])) j++;
                    if(!less(a[k],a[j])) break;
                    exch(a[k],a[j]);
                    k = j;
                }
            }
        
        基于堆有序树的优先队列实现：
            pqheap.c

使用优先队列进行排序：
        思路：
            将需要排序的序列 都插入到 优先队列中 然后在从优先队列中删除max
        void PQsort(Item a[], int l, int r)
        {
            int k;
            PQinit();
            for(k = l; k <= r; k++) PQinsert(a[k]);
            for(k = r; k >= l; k--) a[k] = PQdelmax();
        }

堆排序：
        思路：
            for循环 构造堆 接着while循环交换 最大元素与数组中最后一个元素
                并修正堆
        void heapsort(Item a[], int l, int r)
        {
            int k, N = r-l+1; 
            Item *pq = a+l-1;//指向下标为1的元素 为根节点

            for(k = N/2; k >= 1; k--)//构造堆
                fixDown(pq,k,N);
            while(N > 1){             //将最大的元素 放在最后一个 一直这样放
                                    //下去 直到没有元素为止
                exch(pq[1],pq[N]);
                fixDown(pq,1,--N);
            }
        }

优先队列ADT：
        可以实现 多了队列的join操作 将多个优先队列合并在一起
        无序双联表优先队列实现：
                /function/pqueue/link/*

         索引数据项的优先队列：
            基于索引堆的优先队列
        
        二项队列：
            有序链表实现了快速的join操作和insert操作
                但实现了较慢的delmaximum操作
            有序链表实现了快速的 delmaximum 但。。。

            堆上有快速的insert和delmaximum操作
                但较慢的jion操作
            二项队列便出现了。。。。

            左有序堆：
                每个节点中的关键字 大于或等于该节点的左子树中所有关键字
            二项树：
                一棵2次幂堆 是一颗左有序的堆    由右子树为空 左子树为完全
                二叉树构成的根组成 
                     根的右子树为空  左字树为完全二叉树

            连接两个大小相等的2次幂堆:
                PQlink pair(PQlink p, PQlink q)
                { PQlink t;
                    if (less(p->key, q->key)) 
                        { p->r = q->l; q->l = p; return q; }
                    else { q->r = p->l; p->l = q; return p; }
                }
            二项队列：
                由几个或多个2次幂堆构成 
                实际上就是一个 2进制数 每个2次幂堆 代表一个位数
                想想一下 以前进制树形结构 便明白了

            二项列队的插入操作：
                实际上就是 二进制加1 移位
                    struct PQnode{ Item key; PQlink l, r;};
                    struct pq{PQlink *bq;};
                    PQlink PQinsert(PQ pq, Item v)
                    { int i;
                        PQlink c, t = malloc(sizeof *t);
                        c = t; c->l = z; c->r = z; c->key = v;
                        for (i = 0; i < maxBQsize; i++)
                        {
                            if (c == z) break;
                            if (pq->bq[i] == z) { 
                                pq->bq[i] = c; break;
                            }
                            c = pair(c, pq->bq[i]); pq->bq[i] = z;
                        }
                        return t;
                    }
                二项队列中删除最大元素的操作：
                    从2次幂中 根节点中找
                    Item PQdelmax(PQ pq)
                    { int i, j, max; PQlink x; Item v; 
                        PQlink temp[maxBQsize];
                        for (i = 0, max = -1; i < maxBQsize; i++)
                        if (pq->bq[i] != z) 
                            if ((max == -1) || (pq->bq[i]->key > v))
                            { max = i; v = pq->bq[max]->key; }
                        x = pq->bq[max]->l; 
                        for (i = max; i < maxBQsize; i++) temp[i] = z; 
                        for (i = max ; i > 0; i--)
                        { temp[i-1] = x; x = x->r; temp[i-1]->r = z; }
                        free(pq->bq[max]); pq->bq[max] = z;
                        BQjoin(pq->bq, temp);  
                        return v;
                    }      

                两个二项队列中的连接操作：
                    实际就是 两个二进制数 相加
                    #define test(C, B, A) 4*(C) + 2*(B) + 1*(A)
                    void BQjoin(PQlink *a, PQlink *b)
                    { int i; PQlink c = z;
                        for (i = 0; i < maxBQsize; i++)
                        switch(test(c != z, b[i] != z, a[i] != z))
                            {
                            case 2: a[i] = b[i]; break;
                            case 3: c = pair(a[i], b[i]); 
                                    a[i] = z; break;
                            case 4: a[i] = c; c = z; break;
                            case 5: c = pair(c, a[i]); 
                                    a[i] = z; break;
                            case 6: 
                            case 7: c = pair(c, b[i]); break;
                            }
                    }
                    void PQjoin(PQ a, PQ b)
                    { BQjoin(a->bq, b->bq); }


             












