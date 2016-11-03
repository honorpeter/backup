内部排序：
        被排序的文件适合放在内存中

外部排序：  
        从磁带或磁盘上对文件 进行排序成为外部排序

排序算法所需内存空间：
        1 在原位上进行排序 它除了使用一个小堆栈或表外不需要其他空间
        2 使用链表表示或指针 数组索引来引用数据 因此需要额外的空间存储这N
            个指针或索引    
        3 需要足够的空间来存储要排序的数组的副本


基本的排序方法：
    头文件：
            typedef int Item;
            #define key(A) (A)
            #define less(A,B) (key(A)<key(B))
            #define exch(A,B) { Item t =A ;  A=B; B = t;}
            #defien compexch(A,B) if(less(B,A)) exch(A,B)
    选择排序：
        使用一个数 i来分割这个数组  i一次向前移动
            每次移动的时候将i后面最小的元素 放在i的位置
            这样i前面的部分 都是从小到大的排序好的

            i定位 分割 i前面的元素都是 最小的元素 而且还拍好了序
        void selection(Item a[], int l, int r)
        {
            int i, j;
            for(i = l; i < r; i++ ){        //i用来定位
                int min = i;
                for(j = i+1; j < r; j++){   //寻找i后面的最小的元素
                    if(less(a[j], a[min])){
                        min = j;
                    }
                }
                exch(a[i],a[min]);          //把i后面最小的元素 放在i处
            }
        }
    插入排序：
        基本的插入排序：
            使用i来定位 分割
                i前面的元素 使用插入法 进行排序  
                这样之后 i 前面的元素都是有序的所以当i到达 尾部时 已经拍好序
            void insertion(Item a[], int l, int r)
            {
                int i,j;
                for(i = l+1; i <= r; i++){  //i定位 
                    for(j = i;j>l; j--){    //使用插入法 把i前面的元素拍好序
                        compexch(a[j-1],a[j]);
                    }
                }
            }
        改进上面的插入排序：
            1 当碰到一个关键子 它不大于正在插入的数据项关键字时 停止执行
                    compexch操作
            2 把最小的元素放在第一位
                    这样可以while循环一定成立
            3 在内部循环中 它只是 做一个简单赋值 不执行交换操作

            void insertion(Item a[], int l, int r)
            {
                int i
                for(i = r, i >l , i--) compexch(a[i-1],a[i]);
                                    //将最小的元素放在第一位 
                for(i = l+2; i<= r; i++){//将i前面的元素拍好序
                    int j =i;
                    Item v =a[i];
                    while(less(v, a[j-1])){
                        a[j] = a[j-1];
                        j--;
                    }
                    a[j] = v;
                }
            }
        
    冒泡排序：
        也是一种 选择排序 只是将寻找最小项的方式不同
        i定位 分割 i前面的元素都是 最小的元素 而且还拍好了序
            每次交换i后面的元素 将后面的最小项 交换到i处
            void bubble(Item a[], int l, int r)
            {
                int i ,j;
                for( i= l; i < r; i++){//i定位分割
                    for(j=r;j>i;j--){//把最小项 交换到i处
                        compexch(a[j-1],a[j]);
                    }
                }
            }
    小节：
        选择排序 对输入数据不敏感 大概使用N2/2次比较  N次交换

        插入排序 N2/4比较  N2/4次交换   平均情况

        冒泡排序 N2/2比较  N2/2次交换   平均情况 最坏情况

    希尔排序：
        希尔排序是 插入排序的扩展
         1  4   13  40  121     364     1093        3280    9841...
                通项公式： 3*h+1
                根据数据元素的个数 确定最大项 比如是13
                那么 依次对 13 26 39 (13的倍数)位置上的元素进行插入排序
                    再对 14 27 40...
                    再对 15 28 41...
                    .
                    .
                    .

                再对4 8 12 （4的倍数）  位置上的元素进行插入排序
                    .
                    .
                    .

                再 对 1 。。。。
            void shellsort(Item a[], int l, int r )
            {
                int i,j,h;
                for(h = 1;h <= (r-1)/9; h = 3*h+1) ;    //却定最大元素
                                                // 9 是 最多 几个几倍
                for( ; h > 0; h /= 3){
                    for( i = l+h; i<= r; i++){
                        int j=i; Item v = a[i];
                        while(j >= l+h && less(v,a[j - h])){
                            a[j] =a[j-h];
                            j -= h;
                        }
                        a[j] = v;
                    }
                }
            }
            还有一个序列可以提高效率：
                1 8 23 77 281 1073 4193 16577
                4^(n+1)+3*2^n+1 

    指针和索引排序：
            使用一个数组 存放 需要排序的下标或指针
                  按照需要排序的元素大小 来存放

                  原位排序：
                    insitu(dataType data[], int a[], int N)
                    {
                        int i,j,k;
                        for(i = 0; i < N; i++){
                            dataType v = data[i];
                            for(k = i; a[k] != i; k =a[j],a[j] = j){
                                j = k; data[k] = data[a[k]];
                            }
                            data[k] = v;
                            a[k] = k;
                        }
                    }

                 

    











