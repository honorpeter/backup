放在磁盘上的文件 进行搜索 
    索引顺序访问：
    B树：
            B树的定义以及初始化：
                typedef struct STnode* link;
                typedef struct
                { Key key; union { link next; Item item; } ref; } 
                entry;
                struct STnode { entry b[M]; int m; };
                static link head;
                static int H, N; 
                link NEW()
                { link x = malloc(sizeof *x); 
                    x->m = 0;
                    return x; 
                }
                void STinit(int maxN) 
                { head = NEW(); H = 0; N = 0; }

        B树搜索：
                Item searchR(link h, Key v, int H)
                { int j;
                    if (H == 0)
                    for (j = 0; j < h->m; j++)
                        if (eq(v, h->b[j].key)) 
                        return h->b[j].ref.item;
                    if (H != 0)
                    for (j = 0; j < h->m; j++)
                        if ((j+1 == h->m) || less(v, h->b[j+1].key))
                        return searchR(h->b[j].ref.next, v, H-1);
                    return NULLitem;
                }
                Item STsearch(Key v)
                { return searchR(head, v, H); }

        B树插入：
                link insertR(link h, Item item, int H)
                 { int i, j; Key v = key(item); entry x; link u;
                    x.key = v; x.ref.item = item;
                    if (H == 0)
                      for (j = 0; j < h->m; j++)
                        if (less(v, h->b[j].key)) break;
                    if (H != 0)
                      for (j = 0; j < h->m; j++)
                        if ((j+1 == h->m) || less(v, h->b[j+1].key))
                          {
                            u = insertR(h->b[j++].ref.next, v, H-1);
                            if (u == NULL) return NULL;
                            x.key = u->b[0].key; x.ref.next = u;
                            break;
                          }
                    for (i = ++(h->m); (i > j) && (i != M); i--) 
                      h->b[i] = h->b[i-1];
                    h->b[j] = x;
                    if (h->m < M) return NULL; else return split(h);
                  }
                void STinsert(Item item)
                  { link t, u = insertR(head, item, H); 
                    if (u == NULL) return;
                    t = NEW(); t->m = 2; 
                    t->b[0].key = head->b[0].key; 
                    t->b[0].ref.next = head;
                    t->b[1].key =  u->b[0].key;
                    t->b[1].ref.next = u;
                    head = t; H++;
                  }




        B树节点分裂：
                link split(link h)
                { int j; link t = NEW();
                    for (j = 0; j < M/2; j++)
                    t->b[j] = h->b[M/2+j]; 
                    h->m = M/2; t->m = M/2; 
                    return t;    
                }

可扩展散列：
        初始化：
            typedef struct STnode* link;
            struct STnode { Item b[M]; int m; int k; };
            static link *dir;
            static int d, D, N; 
            link NEW()
            { link x = malloc(sizeof *x); 
                x->m = 0;  x->k = 0;
                return x; 
            }
            void STinit(int maxN) 
            { 
                d = 0; N = 0; D = 1;
                dir = malloc(D*(sizeof *dir));
                dir[0] = NEW(); 
            }
        搜索：
            Item search(link h, Key v)
            { int j;
                for (j = 0; j < h->m; j++)
                if (eq(v, key(h->b[j])))
                    return h->b[j];
                return NULLitem;
            }
            Item STsearch(Key v)
            { return search(dir[bits(v, 0, d)], v); }
        插入：
            link split(link h)
            { int j; link t = NEW();
                while (h->m == M)
                {
                    h->m = 0; t->m = 0; 
                    for (j = 0; j < M; j++)
                    if (bits(h->b[j], h->k, 1) == 0)
                        h->b[(h->m)++] = h->b[j]; 
                    else t->b[(t->m)++] = h->b[j]; 
                    t->k = ++(h->k);
                    if (t->m == M) h = t;
                }
                insertDIR(t, t->k);
            }
            void insert(link h, Item item)
            { int i, j; Key v = key(item); 
                for (j = 0; j < h->m; j++)
                if (less(v, key(h->b[j]))) break;
                for (i = (h->m)++; i > j; i--) 
                h->b[i] = h->b[i-1];
                h->b[j] = item;
                if (h->m == M) split(h);
            }
            void STinsert(Item item)
            { insert(dir[bits(key(item), 0, d)], item); }

    目录插入：
            void insertDIR(link t, int k)
            { int i, m, x = bits(t->b[0], 0, k);
                while (d < k) 
                { link *old = dir;
                    d += 1; D += D;
                    dir = malloc(D*(sizeof *dir));
                    for (i = 0; i < D; i++) dir[i] = old[i/2];        
                    if (d < k) dir(bits(x, 0, d) ^ 1) = NEW();
                }
                for (m = 1; k < d; k++) m *= 2; 
                for (i = 0; i < m; i++) dir[x*m+i] = t;        
            }
















