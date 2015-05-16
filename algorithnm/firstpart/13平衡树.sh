BST的缺点:
        如果算法的用户不注意的话:
            标准BST的最坏情况就有可能出现 已经有序的文件
            有大量重复关键字的文件    ..都有可能导致 二次的BST的构造时间
            和线性的搜索时间
平衡树:
        平衡一颗BST     将BST变为一颗完美的平衡树   通过划分把中值节点
                        放在树根 然后递归的对子树左同样的事情
        code:
            link balanceR(link h)
            {
                if(h -> N <2) return h;
                h = partR(h, h->N/2);
                h ->l = balanceR(h->l);
                h ->r = balanceR(h->r);
                return h;
            }

        为基于BST的符号表的实现提供可保证的一般方法的三种范例:
                随机化:     把随机化决策引入到算法自身 大大降低了最坏情况
                            出现的概率
                平摊  :     每次做额外的工作 是为了避免以后左更多的工作
                            这种方法可以为每个操作的平均开销提供上线
                优化  :     为每个操作 提供性能保证


随机化BST:
        随机化BST插入:
            算法思想:
                当我们把一个新节点插入到N个节点的树中时 新节点出现在树根
                的概率为1/(N+1)  因而我们可以使用用这个概率进行根插入
            link insertR(link h, Item item)
            {
                Key v = key(item), t = key(h -> item);
                if(h == z) return NEW(item,z,z,1);
                if(rand() < RAND_MAX/(h->N+1))
                    return insertT(h,item);//根插入法
                if less(v,t) 
                    h->l = insertR(h -> l, item);
                else 
                    h -> r = insertR(h->r,item);

                (h->N)++;
                return h;

            }

            void STinsert(Item item)
            {
                head = insertR(head,item);
            }


    随机化BST组合:
            使用随机化决策而非任意决策来确定组合树中使用那个节点作为树根
            且使每个节点成为树根的概率相等 
        code:
            link joinR(link a,link b)
            {
                if(a == z)  return b;
                b = insertR(b,a->item);
                b ->l = STjoin(a->l,b->l);
                b ->r = STjoin(a->r,b->r);
                fixN(b);
                free(a);
                return b;
            }

            link STjoin(link a, link b)
            {
                if(rand()/(RAND_MAX/(a->N+b->N)+1) < a->N)
                    joinR(a,b);
                else
                    joinR(b,a);
            }
        随机BST中删除:
            link joinR(link a, link b)
            {
                if(a == z) return b;
                if(b == z) return a;

                
                if(rand() / (RAND_MAX/(a->N+b->N)+1) < a->N){
                    a -> r = joinLR(a->r,b);
                    return a;
                }else{
                    b->l = joinLR(a,b->l);
                    return b;
                }
            }


伸展BST
        研究修改 根插入法 使旋转在某种意义上也能使树平衡

            BST中的伸展插入:    和跟插入法 不同之处在于一个本质的细节
            
            code :
                link splay(link h, Item item)
                {
                    key v = key(item);
                    if(h == z){
                        return NEW(item ,z, z ,1);
                    }
                    if(less(v,key(h->item))){
                        if( h == z) return NEW(item,z,h,h->N+1);
                        if(less(v,key(hl->item))){
                            hll = splay(hll,item);
                            h = rotR(h);
                        }else{
                            hlr = splay(hlr,item);
                            hl = rotL(hl);
                        }
                        return rotR(h);
                    }else{
                    if(hr == z) return NEW(item,h,z,h->N+1);
                        if(less(key(hr->item),v)){
                            hrr = splay(hrr,item);
                            h = rotL(h);
                        }else{
                            hrl = splay(hrl,item);
                            hr = rotR(h);
                        }
                    return rotL(h);
                    }
                }

            void STinsert(Item item){
                head = splay(head,item);
            }






自顶向下的2-3-4树

        2-3-4搜索树定义:
                为空树  or 由以下三类节点组成的树
                1   2-节点, 具有一个关键字 一个指向带有较小关键字的一棵树的
                    左连接  一个指向带有较关键字的一棵树的右链接
                2   3-节点: 具有两个关键字  一个指向较小关键字的一棵树的左
                    链接    一个指向带有该节点两个关键字定义区间之间的关键字
                    值的一棵树的中链接 以及一个指向带有较大关键字的一棵树的
                    右链接
                3   4-节点: 具有三个关键字和四个链接    四个链接分别指向
                    从大到小的关键字节点 
        平衡2-3-4搜索树:
                是一颗2-3-4搜索树   其中所有指向空树的链接到树根的距离都相同


红黑树:
        红黑树中的插入:
            code :
                link RBinsert(link h, Item item, int sw)
                {
                    Key v = key(item);
                    if(h == z) return NEW(item ,z ,z,l,1);
                    if((hl->red) && (hr->red)){
                        h->red = 1;
                        hl ->red = 0;
                        hr ->red =0;
                    }
                    if(less(v,key(h->item))){
                        hl = RBinsert(hl,item,0);
                        if(h->red && hl->red && sw)
                            h = rotR(h);
                        if(hl ->red && hll ->red){
                            h = rotR(h);
                            h -> red = 0;
                            hr ->red = 1;
                        }
                    }else{
                        hr = RBinsert(hr , item ,1);
                        if(h -> red && hr -> red && !sw) h = rotL(h);
                        if(hr -> red && hrr ->red){
                            h = rotL(h);
                            h -> red = 0;
                            hl -> red =1 ;
                        }
                    }
                    fixN(h);
                    return h;
                }

                void STinsert(Item item)
                {
                    head = RBinsert(head,item,0);
                    head -> red = 0;
                }
        
红黑BST:
        一颗二叉搜索树  其中每个节点都标记为 红或黑 附加的限制条件是:
            在任何一个从外部链接通向树根的路径上 不存在连续出现的两个红节点
平衡红黑BST:
        是一颗红黑BST 其中所有从外部链接通向树根的路径上包含的黑节点数相同


跳跃表:
        跳跃表是一个有序链表    其中每个节点包含不定数量的链接  节点中的第i
        个链接构成的单向链表 跳过含有少于i个链接的节点

        可以有两级跳跃表    三级 .... n级 

            跳跃表中的搜索:
                k表示级数   如果链表在第k层下一个节点 小于搜索关键字
                移动到该节点 如果不小于 则向下移到的第k-1层
                Item searchR(link t, Key v, int k)
                {
                    if(t == z)  return NULLitem;
                    if(eq(v,key(t->item))) return t->item;
                    if(less(v,key(t->next[k]->item))){
                        if(k == 0) return NULLitem;
                        return searchR(t,v,k-1);
                    }
                    return searchR(t->next[k],v,k);
                }
                Item STsearch(key v)
                {
                    return searchR(head,v,lgN);
                }
        跳跃表的初始化:
            typedef struct STnode* link;
            struct STnode { 
                Item item;
                link* next;
                int sz;
            };
            static link head, z;
            static int N, lgN;
            link NEW(Item item, int k)      
            { 
                int i; link x = malloc(sizeof *x);
                x->next = malloc(k*sizeof(link));
                x->item = item; x->sz = k;
                for (i = 0; i < k; i++) x->next[i] = z;
                return x;                         
            }                                   
            void STinit(int max) 
            { 
                N = 0; lgN = 0; 
                z = NEW(NULLitem, 0); 
                head = NEW(NULLitem, lgNmax); 
            }

    插入:

            int randX()
            { 
                int i, j, t = rand();
                for (i = 1, j = 2; i < lgNmax; i++, j += j)
                if (t > RAND_MAX/j) break;
                if (i > lgN) lgN = i;
                return i;
            }
            void insertR(link t, link x, int k)
            { Key v = key(x->item); 
                if (less(v, key(t->next[k]->item))) 
                { 
                    if (k < x->sz)
                    { x->next[k] = t->next[k]; 
                        t->next[k] = x; }
                    if (k == 0) return;
                    insertR(t, x, k-1); return;
                }
                insertR(t->next[k], x, k);
            }
            void STinsert(Key v)
            { 
                insertR(head, NEW(v, randX()), lgN);
                N++; 
            }
    删除:
            void deleteR(link t, Key v, int k)
            { 
                link x = t->next[k];
                if (!less(key(x->item), v)) 
                { 
                    if (eq(v, key(x->item)))
                    { t->next[k] = x->next[k]; }
                    if (k == 0) { free(x); return; }
                    deleteR(t, v, k-1); return;
                }
                deleteR(t->next[k], v, k);
            }
            void STdelete(Key v)
            {
                deleteR(head, v, lgN);
                N--;
            }


            







