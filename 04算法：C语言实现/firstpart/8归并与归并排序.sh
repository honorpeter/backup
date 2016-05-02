归并：
        将两个独立的文件合并为 一个独立的文件
    选择：  
        与归并相反


两路归并：
        将两个有序的文件 归并为一个有序的文件
        mergeAB(Item c[], Item a[], int N, Item b[], int M)
        {
            int i, j, k;
            for(i = 0,j = 0, k = 0; k < M+N; k++){

                if(i == N){
                    c[k] = b[j++]; continue;
                }
                if(j == M){
                    c[k] = a[i++]; continue;
                }
                c[k] = (less(a[i],b[j])) ? a[i++]:b[j++];
            }
        }
            将A B合并为C    AB有序  C也有序

    抽象原位归并：
        将第二个数组按 倒序方式复制到辅助数组aux中  紧跟在第一个数组后面
            将数组a 排序        l 到 m 为一部分有序的部分  m 到 r也是
                将这两部分合并在一起
                首先 将这个数组 的l-m复制到 aux中  然后将m-r倒叙复制到aux中
                然后 两个指针从aux两头开始扫描 排序结果放到a中
        Item aux[maxN];
        merge(Item a[], int l, int m, int r)
        {
            int i, j, k;
            for(i = m + l; i > l; i--) aux[i-1] = a[i-1];//l-m复制到 aux中 
            for(j = m; j < r; j++) aux[r+m-j] = a[j+1];//r-m倒叙

            for(k = l; k<=r; k++){      //排序 
                if(less(aux[j],aux[i])){
                    a[k] = aux[j--];
                }else{
                    a[k] = aux[i++];
                }
            }
        }


归并排序：
    自顶向下的排序：
        思路：
            将一个数组分为 两部分 在向下分。。。 形成一个二叉树
            遍历二叉树 到叶子节点的时候     从叶子节点开始 向上一直使用
                抽象原位归并排序
        void mergesort(Item a[], int l, int r)
        {
            int m = (r + l) / 2;
            if(r <= l) return ;//叶子节点的判断条件
            mergesort(a,l,m);//遍历左子树
            mergesort(a,m+1,r);//遍历右子树
            merge(a,l,m,r);//抽象原位归并排序
        }
        使用和N成正比的二外空间      与输入顺序无关
    改进：
        和快速排序一样  将小文件使用 插入排序 来改进
                        消除归并时 将数组复制到辅助数组所用的时间
        和上面的思路一样：
            传递两个数组 a aux 当遍历完所有的子节点的时候 
            使用 两路归并排序 进行排序
        Item aux[maxN];
        void mergesortABr(Item a[], Item b[], int l, int r)
        {
            int m = (l+r)/2;
            if(r-l <=10) {
                 insertion(a,l,r);
                 return ;
            }
            mergesortABr(b,a,l,m);
            mergesortABr(b,a,m+1,r);
            mergeAB(a+l,b+l,m-l+1,b+m+1,r-m);//两路归并
        }
        void mergesortAB(Item a[], int l, int r)  //排序的主函数
        {
            int i;
            for(i = l; i <= r; i++) aux[i] =a[i];
            mergesortABr(a, aux, l, r);
        }

    自底向上的归并排序：        非递归排序方法：
        相当于层次遍历
            把数组看做是一个树  按照层次遍历进行排序
                     从底层开始排序     根据树的公式来算
        #define min(A,B) (A < B) ? A : B
        void mergesortBU(Item a[], int l, int r)
        {
            int i, m;
            for(i = 1; m <= r-l; m = m+m){
                for(i = l; i <= r-m; i+=m+m)
                    merge(a,i,i+m-1,min(i+m+m-1,r));
            }
        }
特点：
        归并排序是一种稳定的排序方法
            运行时间与N log N   成正比
        快速排序和堆排序都是不稳定的排序算法

归并排序的链表实现：
    链表归并
        link merge(link a, link b)
        { 
            struct node head; 
            link c = &head;
            while ((a != NULL) && (b != NULL))
                if (less(a->item, b->item)){ 
                    c->next = a; c = a; a = a->next; 
                }else { 
                    c->next = b; 
                    c = b; b = b->next; 
                }
            c->next = (a == NULL) ? b : a;
            return head.next;
        }
    自顶向下 归并排序
        link merge(link a, link b);
        link mergesort(link c)
        { 
            link a, b;
            if (c->next == NULL) return c;
            a = c; b = c->next;
            while ((b != NULL) && (b->next != NULL))
            { c = c->next; b = b->next->next; }
            b = c->next; c->next = NULL;
            return merge(mergesort(a), mergesort(b));
        }
    自底向上 排序：
        link mergesort(link t)
        { 
            link u;
            for (Qinit(); t != NULL; t = u) 
            { u = t->next; t->next = NULL; Qput(t); }
            t = Qget();     
            while (!Qempty())
            { Qput(t); t = merge(Qget(), Qget()); }
            return t;
        }




















