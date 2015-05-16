#include<stdlib.h>    
#include "Item.h"
typedef struct STnode * link;
struct STnode{
    Item item;
    link l;
    link r;
    int N;          //是关键字
};

static link head , z;   //head是一个亚节点  
                        // z is a null pointer

link NEW(Item item, link l, link r, int N)
{
    link x = malloc(sizeof(*x));
    x-> item = item;
    x-> l = l;
    x-> r = r;
    x-> N = N;
    return x;
}

void STinit()
{
    head = (z = NEW(NULLitem,0,0,0));
}
        
int STcount()
{
    return head -> N;
}
Item searchR(link h, key v)
{
    key t = key(h -> item);
    if (h==z) {
        return NULLitem;        // 树为空的处理方式
    }
    if eq(v,t) return h->item;
    if less(v,t) 
        return searchR(h->l,v);
    else 
        return searchR(h->r,v);
}

Item STsearch(key v)
{
    return searchR(head,v);
}
link insertR(link h, Item item)     //item 这里应该传出key
{
    key v = key(item), t = key(h -> item);
    if(h==z)    return NEW(item ,z ,z,1);   //if the tree is null insert
                                            // z is null pointer
    if less(v, t)
        h -> l = insertR(h->l, item);
    else
        h -> r = insertR(h->r, item);
    (h->N)++;
    return h;
}

void STinsert(Item item)
{
    head = insertR(head, item);
}








