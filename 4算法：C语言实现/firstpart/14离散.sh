离散:
        由两部分组成:
            离散函数: 将搜索的关键字转化为表中的地址
            解决冲突: 离散函数将不同的关键字 放到同一个地址

        离散函数:
            要求: 尽可能的让每个关键字 平均分配到一个地址 冲突最小
                  哈希函数 应该考虑关键字的全部位 特别是由字符组成的位 
                        所以下面的 a = 127为素数 这样取摸的时候 不会只关注
                        前几位 而不关心全部的位 
            字符串关键字的哈希函数:
                对关键字中的每个字符进行一次乘法 和 一次加法
                    M为哈希数组的长度
                int hash(char *v, int M)
                {
                    int h = 0, a = 127;
                    for(; *v != '\0', v++){
                        h = (a * h + *v) % M;
                    }
                    return h;
                }
            用于字符串关键字的通用哈希函数:
                
                int hashU(char *v, int M)
                {
                    int h, a = 31415, b =27183;
                    for(h = 0; *v != '\0'; v++, a = a*b %(M - 1)){
                        h = a(a*h + *v) % M;
                    }
                    return h;
                }
            其他类型  整数 浮点数...
                介于s和t之间的浮点数:
                    #define hash(v,M) (((v-s)/(t-s))*M)
                对于整数关键字:
                    #define hash(v,M) (v % M)
                如果M不是素数:
                    #define hash(v,M) ((int)(.616161*(float)v) % M)
                    #define hash(v,M) ((16161 *(unsigned) v) % M)

     冲突解决:
            链地址法:
               当不同的关键字 映射到同一个地址时  使用链表将他们连接起来。
               /function/hash/addr.c
            线性探测法：
                如果我们可以估计将要填入散列表的元素数目 有足够的内存空间
                可以容纳 那么可以选择这个了
                
                当发生冲突的时候 将这个关键字 存储到更高的地址区 
                /function/hash/line.c
            双重散列表：
                开放地址法的一种 另一种 
                当发生冲突的时候  使用第二个散列函数 来确定搜索增量 
                和开发地址法 不同的是 当他遇到冲突的时候搜索增量为1 
                表的大小应该与搜索增量互质
            动态散列表：
                随着散列表中关键字数目增多 搜索性能会不断下降
                所以 当表快要满时 使表的大小加倍

                动态散列插入  用于线性探测
                    void expand();
                    void STinsert(Item item)
                    {
                        key v = key(item);
                        int i = hash(v,M);
                        while(!null(i)) i = (i+1) %M;
                        st[i] = item;
                        if(N++ >= M/2) expand();
                    }
                    void expand()
                    {
                        int i;
                        Item *t = st;
                        init(M+M);
                        for(i = 0; i < M/2; i++){
                            if(key(t[i]) != key(NULLitem))
                                STinsert(t[i]);
                        }
                        free(t);

                    }
                 


                













