static link *heads, z;
static int N, M;
void STinit(int max)
{
    int i;
    N = 0;
    M = max / 5;
    heads = malloc(M * sizeof(link));
    z = NEW(NULLitem, NULL);
    for(i = 0; i < M; i++)
        heads[i ] = z;
}

Item STsearch(key v)
{
    return searchR(heads[hash(v,M)],v);
}

void STinsert(key v)
{
    int i = hash(key(item),M);
    heads[i] = NEW(item,heads[i]);
    N++;
}

void STdelete(Item item)
{
    int i = hash(key(item),M);
    heads[i ] = deleteR(heads[i],item);
}













