/*
 * 随机队列的实现 
 */
#include <stdlib.h>
#include "GQ.h"
static Item *s;
static int N;
void RQinit(int maxN)
  { s = malloc(maxN*sizeof(Item)); N = 0; }
int RQempty()
  { return N == 0; }
void RQput(Item x)
  { s[N++] = x; }
void RQupdate(Item x)
  { } //这里不好写啊
Item RQget()
  { Item t;
    int i = N*(rand()/(RAND_MAX + 1.0));
    t = s[i]; s[i] = s[N-1]; s[N-1] = t;    
    return s[--N]; 
  }


