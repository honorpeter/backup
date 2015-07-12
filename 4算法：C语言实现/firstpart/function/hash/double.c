void STinsert(Item item)
{
    key v = key(item);
    int i = hash(v,M);
    int k = hashtwo(v,M);
    while(!null(i)) i = (j+k) %M;
    st[i] = item;
    N++;
}

Item STsearch(key v)
{
    int i = hash(v,M);
    int k = hash(v,M);
    while(!null(i)){
        if eq(v,key(st[i])) return st[i];
        else 
            i = (i + k) % M;
    }
    return NULLitem;
}














