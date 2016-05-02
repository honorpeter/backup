#define pfs search
void pfs(Graph G, Edge e)
  { link t; int v, w;
    GQput(e); pre[e.w] = cnt++;
    while (!GQempty())
      {
        e = GQget(); w = e.w; st[w] = e.v; 
        for (t = G->adj[w]; t != NULL; t = t->next)
          if (pre[v = t->v] == -1)
            { GQput(EDGE(w, v)); pre[v] = cnt++; }
          else if (st[v] == -1)
            GQupdate(EDGE(w, v));
      }
  }
