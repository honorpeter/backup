/*对于  关键字的值是不同的小整数    堆存储在数组中的数据项进行排序
 * 并按关键字进行索引 
 */
static Item *st;
static int M = maxKey;      //动态数组的大小　maxKey  定义在 Item.h中
void STinit(int maxN)
{
    int i;
    st = malloc((M+1)*sizeof(Item));
    for(i = 0; i <= M;i++){
        st[i] = NULLitem;
    }
}

int STcount()
{
    int i, N = 0;
    for(i = 0; i < M; i++){
        if(st[i] != NULLitem) N++;
    }
    return N;
}

void STinsert(Item item)
{
    st[key(item)] = item;
}

Item STsearch(Key v)
{
    return st[v];
}

void delete(Item item)
{
    st[key(item)] = NULLitem;
}

Item select(int k)
{
    int i;
    for(i=0; i < M; i++){
        if(st[i] != NULLitem ){
            if(k-- == 0) return st[i];
        }
    }
}

void STsort(void (*visit)(Item))
{
    int i;
    for(i = 0 ;i < M; i++){
        if(st[i] != NULLitem ) visit(st[i]);
    }
}








