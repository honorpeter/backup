/*下堆栈的数组实现
 * 这个实现有很多的不完善  push没有检查是否已经满了 
 *
 * */
#include<stdlib.h>    
#include"Item.h"
#include"STACK.h"

static Item *s;     //存放开始的地方 声明为static 很有深意
static int N;       //存放元素个数  声明为static

void STACKinit(int maxN)
{
    s = malloc(maxN * sizeof(Item));
    N = 0;
}

int STACKempty()
{
    return N == 0;
}

void STACKpush(Item item)
{
    s[N++] = item;
}

Item STACKpop()
{
    return s[--N];
}










