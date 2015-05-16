快速排序是一种分治法：
        是一种自顶向下的排序方法  从上到下后 便已经拍好序了
        将数组划分为两个部分    然后分别对这两个数组进行排序 递归处理子文件

        基本的：
            将需要排序的序列看做一课树
            将它划分为两个 在向下划分。。。。直到为叶子节点
            然后 选择遍历方式
            int partition(Item a[], int l, int r);
            void quicksort(Item a[], int l, int r)
            {
                int i;
                if( r <= l) return ;
                i = partition(a , l, r);
                quicksort(a, l, i-1);   //遍历左子树
                quicksort(a, i+1, r);   //遍历右子树
            }
        划分：
            int partition(Item a[], int l,int r)
            {
                int i = l - 1, j = r; Item v = a[r];//这里-1 下面++i
                            //v保存划分元素 i j分别为左右扫描指针
                for( ; ;){      //交换左右的元素 大的在右小的在左
                    while(less(a[++i],v)) ;//在左边寻找 小于v的 
                    while(less(v,a[--j])) if( j == l) break;
                                            //从右边寻找
                    if(i >= j) break;       //j 必须大圩=i
                    exch(a[i],a[j]);
                }
                exch(a[i],a[r]);        //交换最后一个元素
                return i;

            }
            划分过程是 不稳定的 快速算法的效率取决于 划分的结果
        非递归的快速排序：
            #define push2(A,B) push(B);push(A);
            void quicksort(Item a[], int l, int r)
            {
                int i;
                stackinit();
                push2(l,r);
                while(!stackempty()){
                    l = pop(); 
                    r = pop();
                    if(r <= l) continue;
                    i = partition(a,l,r);
                    if(i-l > r-i){  //把较大的子文件 压入到栈中
                                    //保证栈中的每个元素不会超过它下面元素
                                    //大小的一般    so 栈中只需要容纳lgN个
                        push2(l,i-1);
                        push2(i+1,r);
                    }else{
                        push2(i+1,r);
                        push2(l,i-1);
                    }
                }

            }
    改进快速排序：
        小的子文件：
            上面的快速排序 产生的子文件太小了 所以让它大一点
            当最小的子文件 小于等于M的时候  使用插入排序 进行排序
            只需要 ：       M 在5 到25之间比较好
                将if( r <= l) return ;  改为:
                    if(r-1 <= M) insertion(a,l,r);
        三者取中划分：
            改进 划分的过程中 尽可能的让划分元素为中位数
            改进： 从文件中取出三个元素 使用三个元素的中间元素为划分元素

            #define M 10
            void quicksort(Item a[], int l, int r)
            {
                int i;
                if(r-l <= M) return ;
                exch(a[(l+r)/2],a[r-1]);    //选择中间的数来作为划分元素
                compexch(a[l],a[r-1]);
                compexch(a[l],a[r]);
                compexch(a[r-1],a[r]);

                i = partition(a,l,i-1);
                quicksort(a,l,i-1);
                quicksort(a,i+1,r);
            }

            void sort(Item a[],int l, int r)
            {
                quicksort(a,l,r);
                insertion(a,l,r);//先大致拍好序 在进行插入排序 这样函数栈的
                                //空间不会使用太大
            }
    重复关键字：
            当需要排序的文件中有很多的 重复的关键字的时候排序效率很低了
            
            使用三路划分的快速排序改进：
                三路划分：
                    扫描时 将遇到的左子文件中与划分元素相等的元素放在文件的
                    最左边  将遇到的右子文件中与。。。。。。。。。。。。。
                    最右边          
                    当两个指针相遇时 相等值的关键字的精确位置 就知道了
                    我们只需要 将所有关键字值 与 划分元素交换即可
                        将两边的与划分元素一样的都放在划分元素两边
                        然后递归调用 与划分元素 不同的关键字

                #define eq(A,B) (!less(A,B) && !less(B,A))
                void quicksort(Item a[], int l, int r)
                {
                    int i, j,k, p, q;
                    Item v;
                    if(r <= l) return ;
                    v =a[r]; 
                    i = l - 1;
                    j = r;
                    p = l - 1;
                    q = r;
                    for(;;){
                        while(less(a[++i],v)) ;
                        while(less(v,a[--j])) if(j == l) break;
                        if(i >= j) break;
                        exch(a[i],a[j]);
                        if(eq(a[i],v)) { p++; exch(a[p],a[i]);}
                        if(eq(v,a[j])) { q--; exch(a[q],a[j]);}
                    }
                    exch(a[i],a[r]);
                    j = i - 1;
                    i = i + 1;
                    for(k = l; k < p; k++,j--) exch(a[k],a[j]);
                    for(k = r-1; k > q; k--,i++) exch(a[k],a[i]);
                    quicksort(a,l,j); //对较小关键字的调用
                    quicksort(a,i,r);//对较大关键字的调用

                }
                将数组划分为三个部分：
                    比划分元素小的元素： a[l] ...a[j]
                                相等。： a[j+1]..a[i-1]
                                大的  ： a[i]... a[r]

    字符串和向量：
            字符串排序
                1 使用系统提供的qsort()函数
                     int compare(void *i,void *j)
                     {
                         return strcmp(*(Item *)i, *(Item *j));
                     }
                     void sort(Item a[],int l, int r)
                     {
                         qsort(a,r-l+1,sizeof(Item),compare);
                     }
                2 strcmp开销很到 他是一个一个比较的。。
                    是用三路划分 。。可以提高30% ~35%
    选择：
            选择出 第k大小的元素
            当i=k时  停止递归  或者 r <= l时
            if(i == k) return a[i];
            select(Item a[],int l, int r, int k)
            {
                int i;
                if(r <= l) return ;
                i = partition(a,l,r);
                if(i > k) select(a,l,i-1,k);
                if(i < k) select(a,i+1,r,k);
            }

            非递归选择算法：
            select(Item a[], int l, int r)
            {
                while( r > l){
                    int i = partition(a,l,r);
                    if( i >= k) r = i-1;
                    if(i <= k) l = i+1;
                }
            }








