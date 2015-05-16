Batcher奇偶归并排序：
    这个算法 基于两种操作
        比较 交换操作       完美混洗操作

    完美混洗和完美逆混洗
        完美混洗：
            将 两个数组A B合并为一个数组C
            C 的1 3  5 7 。。。元素是B数组的一次序列  其他位置是A
            
                code:
                将数组a 从l到r  进行混洗
                使用了一个辅助数组 aux  
                    先将 数组a 混洗的结果放到 aux中 
                    然后 是a等于aux  
                shuffle(itemType a[], int l, int r)
                {
                    int i, j, m = (l+r)/2;
                    for(i = l, j = 0; i <= r; i += 2, j++){ //将混洗结果放到
                                                            //aux中
                                                            //把a分为两部分
                        aux[i] = a[l+j];
                        aux[i+1] = a[m+1+j];
                    }
                    for(i = 1; i <= r; i++)
                        a[i] = aux[i];

                }
        完美逆混洗：
            和上面的相反        将C分解为A B
                
                code:
                    操作过程基本一样
                    unshuffle(itemType a[], int l, int r)
                    {
                        int i, j, m = (l+r)/2;

                        for(i =l, j = 0; i <= r; i+=2, j++ ){
                            aux[l+j] = a[i];
                            aux[m+1+j] = a[i+1];
                        }
                        for(i = 1; i <= r; i++)
                             a[i] = aux[i];

                    }
    

        Batcher奇偶归并排序：   递归实现 
                                分为先序处理
                                后序处理
            mergeTD(itemType a[], int l, int r)
            {
                int i, m = (l + r)/2;
                if(r == l+1)    comexch(a[l],a[r]);//先序处理
                if( r < l + 2) return ;

                unshuffle(a,l,r);                   //先序处理 
                mergeTD(a,l,m);
                mergeTD(a,m+1,r);
                shuffle(a,l,r);
                for(i = l + 1; i < r; i += 2){  //后序处理
                    comexch(a[i],a[i+1]);
                }
            }
            
            非递归实现：
                mergeTD(itemType a[], int l, int r)
                {
                    int i, j,k, N = r-l-1;
                    for(k = N/2; k > 0; k /= 2){
                        for(j = k %(N/2); j+k < N; j+=(k+k)){
                            for(i = 0; i < k; i++){
                                comexch(a[l+j+i],a[l+j+i+k]);
                            }
                        }
                    }
                }
非适应性排序：
        它所执行的操作 序列只依赖于输入的个数   而不依赖关键字的值


    排序网：
           只通过 比较 交换 

           batcher奇偶排序：
            void batchrsort(itemType a[], int l, int r)
            {
                int i, j,k,p, N = r-l+1;
                for(p = 1; p < N ; p +=p){
                    for(k = p; k > 0; k/=2){
                        for(j = k%p; j+k < N; j += (k+k)){
                            for(i = 0; i < k; i++){
                                if((j+i)/(p+p) == (j+i+k)/(p+p))
                                    comexch(a[l+j+i],a[l+j+i+k])
                            }
                        }
                    }
                }
            }


外部排序：
        平衡多路归并

        三路平衡归并
        














