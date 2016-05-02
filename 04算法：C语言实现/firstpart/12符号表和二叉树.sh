符号表是一种数据结构：
        其中数据项含有关键字    它支持两个基本操作：　插入新的数据项　
                                                    返回给定关键字的数据项
        对外接口：k
                functions/table/ST.h
                functions/table/clinet.c    客户端程序
    基于关键字索引搜索实现：
                function/table
            每个数据项都含有一个关键字      按照关键字的大小依次插入数组中
            对于那些 关键字是 小整数型的 关键字才能使用

    顺序搜索：
            基于数组的符号表实现(有序)
                /functions/table/sort.c
                使用N来记录 数组中元素的大小
                关键字不能太大   把数据项顺序连续的放到数组中
            基于链表的符号表(无序)
                /function/table/link.c
                因为链表是无序的 不支持sort和select操作
                
    二分搜索:
            每次求一般 从中间开始来求
            (基于数组的符号表的)    二分搜索 数组是有序的   递归实现
                code:
                Item search(int l, int r, key v)
                {
                    int m = (l + r ) / 2;
                    if( l > r) return NULLitem;
                    if(eq(v,key(st[m]))) return st[m];
                    if( l == r) return NULLitem;
                    if less(v,key(st[m])) 
                        return search(l, m -1 ,v);
                    else 
                        return search(m+1, r, v);
                }

                Item STsearch(key v)
                {
                    return search(0,N-1,v);
                }
 

    二叉树搜索树:
            为了克服 插入 操作开销过高的问题    我们将使用一个种显示的树结构

            定义:
                是一颗二叉树    它的每个内部节点都关联一个关键字 
                    任意节点的关键字大于或等于该节点的左子树中所有节点的
                    关键字 小于或等于该节点的右子树中所有的节点关键字

            使用BST排序:
                使用中序遍历 按照顺序遍历所有节点
                void sortR(link h, void (*visit)(Item))
                { 
                    if (h == z) return;
                    sortR(h->l, visit);
                    visit(h->item); 
                    sortR(h->r, visit);
                }
                void STsort(void (*visit)(Item))
                { sortR(head, visit); } 
            在BST上的插入 非递归实现
                void STinsert(Item item)
                { 
                    Key v = key(item); link p = head, x = p;
                    if (head == NULL) 
                    { head = NEW(item, NULL, NULL, 1); return; }
                    while (x != NULL)
                    { 
                        p = x; x->N++;
                        x = less(v, key(x->item)) ? x->l : x->r; 
                    }
                    x = NEW(item, NULL, NULL, 1);
                    if (less(v, key(p->item))) p->l = x; 
                                        else p->r = x;
                }

在BST的根节点插入:
        在上面的BST插入中 每个新节点 都会插入到树的底层的每个地方

        这次插入都插入到树的根部    因而最近插入的节点都在树的上部

        BST中的右旋转
            一个局部的变化 只涉及三个连接和两个节点 这允许我们逸动书中的节点
            不改变BST的全局性质
            
                link rotR(link h)
                {
                    link x = h->l;
                    h ->l = x->r;
                    x -> r = h;
                    return x;
                }

        左旋:
                link rotL(link h)
                {
                    link x = h-> r;
                    h -> r = x -> l;
                    x -> l = h;
                    return x;
                }

        BST中的跟插入:
            link inserBST中的跟插入:

            link insertT(link h, Item item)
            { 
                Key v = key(item);
                if (h == z) return NEW(item, z, z, 1); 
                if (less(v, key(h->item))) 
                { 
                    h->l = insertT(h->l, item); 
                    h = rotR(h); 
                } else {
                    h->r = insertT(h->r, item); 
                    h = rotL(h); 
                }
                return h;
            }
            void STinsert(Item item)
            { 
                head = insertT(head, item);
            }

    在BST中的选择操作:

            Item selectR(link h, int k)
            { 
                int t = h->l->N;
                if (h == z) return NULLitem;    //如果为空 返回
                if (t > k) return selectR(h->l, k);
                if (t < k) return selectR(h->r, k-t-1);
                return h->item;
            }
            Item STselect(int k)
            { 
                return selectR(head, k); 
            } 


    BST中的划分操作:
            link partR(link h, int k)
            { 
                int t = h->l->N; 
                if (t > k )
                { 
                    h->l = partR(h->l, k); 
                    h = rotR(h); 
                }
                if (t < k )
                { h->r = partR(h->r, k-t-1); 
                    h = rotL(h); 
                }
                    return h;
            }
        BST中的删除一个给定关键字的节点:
            link joinLR(link a, link b)
            { 
                if (b == z) return a;
                b = partR(b, 0); b->l = a; 
                return b;
            }
            link deleteR(link h, Key v)
            { link x; Key t = key(h->item);
                if (h == z) return z; 
                if (less(v, t)) h->l = deleteR(h->l, v);
                if (less(t, v)) h->r = deleteR(h->r, v);
                if (eq(v, t)) 
                { x = h; h = joinLR(h->l, h->r); free(x); }
                return h;
            }
            void STdelete(Key v)
            { head = deleteR(head, v); }

        两棵BST的连接:
            link STjoin(link a, link b)
            { 
                if (b == z) return a;
                if (a == z) return b;
                b = STinsert(b, a->item); 
                b->l = STjoin(a->l, b->l); 
                b->r = STjoin(a->r, b->r); 
                free(a);    
                return b;
            }


















