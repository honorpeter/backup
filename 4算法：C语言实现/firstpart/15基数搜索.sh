基数搜索：
        每次比较的不是整个关键字    而是关键字的一段或一部分

        关键字类型：
                字：即固定长度的字节了序列
                        按数位进行各种操作
                字符串： 即变长的字节序列
                        提取关键字 第i位


数字搜索树：
        其搜索和插入算法与二叉树只有一点不同    树分支不是根据整个关键字的
            比较结果    而是根据关键字的某系被选位的比较结果

        二进制数字搜索树：
            每个节点有两个子节点    当为0的时候 走左边的节点    为1的时候
                走右边的节点
                这个和树的遍历 不一样 遍历是访问全部的节点 但这个是只走其中
                的一条路线 选择的走
                w代表 第几位。。。。
            Item searchR(link h , key v, int w)
            {
                key t = key (h->item);
                if(h == z) return NULLitem;//为空退出
                if eq(v,t) return h->item;//找到返回
                if (digit(v,w) == 0)//  为0向左走   选择路线 左走 右走
                    return searchR(h->l, v,w+1);
                else
                    return searchR(h->r,v,w+1);//为1向右走
            }

            Item STsearch(key v)
            {
                return searchR(head,v,0);
            }

线索：
        与上面的一种方法类似： 不同是 这种树中的关键字是有序排列的
        基本思路： 把关键字只存储在 叶子节点上 
                    通过比较位来选择 左右
        和上面的一样 只是它的关键字都放在叶子上 

            线索搜索：
                Item searchR(link h, key v, int w)
                {
                    if(h == z) return NULLitem;//到了空节点没有 返回
                    if((h->l == z) && (h->r == z))//到了叶子节点 判断有无
                        return eq(v,key(h->item)) ? h->item: NULLitem;
                    if(digit(v,w ) == 0){// 选择路径
                        return searchR(h->l,v,w+1);
                    }else{
                        return searchR(h->r,v,w+1);
                    }
                }
                Item STsearch (key v)
                {
                    return searchR(head,v,0);
                }

        线索插入：
                void STinit ()
                {
                    head = (z = NEW(NULLitem, 0, 0, 0));//初始化
                }

                link split(link p; link q; int w)
                {
                    link t = NEW(NULLitem, z, z, 2);

                    switch(digit(p->item,w)*2 + digit(q->item,w)){
                        case 0: t->l = split(p,q,w+1); break;
                        case 1: t-l = p; 
                                t->r = q;
                                break;
                        case 2: t->r = p;
                                t->l =q;
                                break;
                        case 3: t->r = split(p,q,w+1);
                                break;
                    }
                    return t;
                }

                link insertR(link h, Item item, int w)
                {
                    key v = key(item);
                    if(h == z) return NEW(item,z,z,1);//二叉树为空 直接新建
                    if((h->l == z) && (h->r ==z)){// 到叶子节点
                        return split(NEW(item,z,z,1), h, w);
                    }
                    if(digit(v,w) == 0)//向左走 向右走
                        h->l = insertR(h->l, item, w+1);
                    else
                        h->r = insertR(h->r , item, w+1);
                    return h;
                }

                void STinsert(Item item)
                {
                    head = inserR(head, item,0);
                }


        帕氏线索：
             线索有两个缺点：
                    1 单路分支 导致在线索中建立额外的但不需要的节点
                    2 线索中有两种不同类型的节点使代码有些复杂
                搜索:
                    Item searchR(link h, Key v, int w)
                    { 
                        if (h->bit <= w) return h->item;
                        if (digit(v, h->bit) == 0)
                            return searchR(h->l, v, h->bit);
                        else 
                            return searchR(h->r, v, h->bit);
                    }
                    Item STsearch(Key v) 
                    { 
                        Item t = searchR(head->l, v, -1); 
                        return eq(v, key(t)) ? t : NULLitem; 
                    } 

                插入：
                    void STinit()
                    { 
                        head = NEW(NULLitem, 0, 0, -1); 
                        head->l = head; head->r = head;
                    }
                    link insertR(link h, Item item, int w, link p)
                    { 
                        link x; Key v = key(item);
                        if ((h->bit >= w) || (h->bit <= p->bit))
                        { 
                            x = NEW(item, 0, 0, w);
                            x->l = digit(v, x->bit) ? h : x;
                            x->r = digit(v, x->bit) ? x : h;
                            return x; 
                          }
                        if (digit(v, h->bit) == 0)
                             h->l = insertR(h->l, item, w, h);
                        else h->r = insertR(h->r, item, w, h);
                        return h;
                      }
                    void STinsert(Item item)
                      {
                        int i;
                        Key v = key(item); 
                        Key t = key(searchR(head->l, v, -1));
                        if (v == t) return;
                        for (i = 0; digit(v, i) == digit(t, i); i++) ;
                        head->l = insertR(head->l, item, i, head);
                      }
                排序：
                    void sortR(link h, void (*visit)(Item), int w)
                    { 
                        if (h->bit <= w) { visit(h->item); return; }
                        sortR(h->l, visit, h->bit);
                        sortR(h->r, visit, h->bit);
                    }
                    void STsort(void (*visit)(Item))
                    {
                        sortR(head->l, visit, -1); 
                    } 
            多路线索和TST：
                    typedef struct STnode *link;
                    struct STnode { link next[R]; };
                    static link head;
                    void STinit() { head = NULL; }
                    link NEW()
                      { int i;
                        link x = malloc(sizeof *x); 
                        for (i = 0; i < R; i++) x->next[i] = NULL;
                        return x;
                      }
                    Item searchR(link h, Key v, int w)
                      { int i = digit(v, w);
                        if (h == NULL) return NULLitem;
                        if (i == NULLdigit) return v;
                        return searchR(h->next[i], v, w+1);
                      }
                    Item STsearch(Key v) 
                      { return searchR(head, v, 0); } 
                    link insertR(link h, Item item, int w)
                      { Key v = key(item);
                        int i = digit(v, w);
                        if (h == NULL) h = NEW();
                        if (i == NULLdigit) return h;
                        h->next[i] = insertR(h->next[i], v, w+1);
                        return h;
                      }
                    void STinsert(Item item)
                      { head = insertR(head, item, 0); N++; }
            多路线索：
                    
            存在TST的搜索和插入：
                    typedef struct STnode* link;
                    struct STnode { Item item; int d; link l, m, r; };
                    static link head;
                    void STinit() { head = NULL; }
                    link NEW(int d)
                      { link x = malloc(sizeof *x); 
                        x->d = d; x->l = NULL; x->m = NULL; x->r = NULL;
                        return x;
                      }
                    Item searchR(link h, Key v, int w)
                      { int i = digit(v, w);
                        if (h == NULL) return NULLitem; 
                        if (i == NULLdigit) return v;
                        if (i < h->d) return searchR(h->l, v, w);
                        if (i == h->d) return searchR(h->m, v, w+1);
                        if (i > h->d) return searchR(h->r, v, w);
                      }
                    Item STsearch( Key v)
                      { return searchR(head, v, 0); }
                    link insertR(link h, Item item, int w)
                      { Key v = key(item);
                        int i = digit(v, w);
                        if (h == NULL) h = NEW(i); 
                        if (i == NULLdigit) return h;
                        if (i < h->d) h->l = insertR(h->l, v, w);
                        if (i == h->d) h->m = insertR(h->m, v, w+1);
                        if (i > h->d) h->r = insertR(h->r, v, w);
                        return h;
                      }
                    void STinsert(Key key)
                      { head = insertR(head, key, 0); }

        TST中部分匹配搜索：
                char word[maxW];
                void matchR(link h, char *v, int i)
                { 
                    if (h == z) return; 
                    if ((*v == '\0') && (h->d == '\0')) 
                    { word[i] = h->d; printf("%s ", word); }
                    if ((*v == '*') || (*v == h->d)) 
                    { word[i] = h->d; matchR(h->m, v+1, i+1); }
                    if ((*v == '*') || (*v < h->d)) 
                    matchR(h->l, v, i);
                    if ((*v == '*') || (*v > h->d)) 
                    matchR(h->r, v, i);
                }
                void STmatch(char *v)
                { matchR(head, v, 0); }

        符号表ADT的TST插入：
                #define internal(A) ((A->d) != NULLdigit)
                link NEWx(link h, int d)
                  { link x = malloc(sizeof *x); 
                    x->item = NULLitem; x->d = d;
                    x->l = NULL; x->m = h; x->r = NULL;
                    return x;
                  }
                link split(link p, link q, int w)
                  { int pd = digit(p->item, w), 
                        qd = digit(q->item, w);
                    link t = NEW(NULLitem, qd);
                    if (pd < qd) { t->m = q; t->l = NEWx(p, pd); }
                    if (pd == qd) { t->m = split(p, q, w+1); }
                    if (pd > qd) { t->m = q; t->r = NEWx(p, pd); }
                    return t;
                  }
                link insertR(link h, Item item, int w)
                  { Key v = key(item);
                    int i = digit(v, w);
                    if (h == NULL) 
                      return NEWx(NEW(item, NULLdigit), i);
                    if (!internal(h))
                      return split(NEW(item, NULLdigit), h, w); 
                    if (i < h->d) h->l = insertR(h->l, v, w);
                    if (i == h->d) h->m = insertR(h->m, v, w+1);
                    if (i > h->d) h->r = insertR(h->r, v, w);
                    return h;
                  }
                void STinsert(Key key)
                  { int i = digit(key, 0);
                    heads[i] = insertR(heads[i], key, 1); 
                  }

        符号表ADT的TST搜索：
                Item searchR(link h, Key v, int w)
                { int i = digit(v, w);
                    if (h == NULL) return NULLitem; 
                    if (internal(h))
                    {
                        if (i < h->d) return searchR(h->l, v, w);
                        if (i == h->d) return searchR(h->m, v, w+1);
                        if (i > h->d) return searchR(h->r, v, w);
                    }
                    if eq(v, key(h->item)) return h->item;
                    return NULLitem;
                }
                Item STsearch(Key v)
                { return searchR(heads[digit(v, 0)], v, 1); }

        文本字符串索引算法：

















