#include "pq.h"
typedef int Item;
static int N, pq[maxPQ+1], qp[maxPQ+1];
void exch(int i, int j)
  { int t;
    t = i; i = j; j = t;
    t = qp[i]; qp[i] = qp[j]; qp[j] = t;
  }
void PQinit() { N = 0; }
 int PQempty() { return !N; }
void PQinsert(int k)
  { qp[k] = ++N; pq[N] = k; fixUp(pq, N); }
 int PQdelmax()
  { 
    exch(pq[1], pq[N]); 
    fixDown(pq, 1, --N); 
    return pq[N+1]; 
  }
void PQchange(int k)
  { fixUp(pq, qp[k]); fixDown(pq, qp[k], N); }

