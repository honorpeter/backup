基数排序：
        每次只对关键字的一块进行处理的排序方法成
    位 字节和字
        #define bitsword 32
        #define bitsbyte 8
        #define bytesword 4
        #define R (1 << bitsbyte)       //R为  有一个字节 全为0
                                        //这样可以用R-1提取 使用& 

        从二进制A中提取第B个 位        
        A为4个字节

        #define digit(A,B)
        ((A) >> (bitsword -((B)+1)*bitsbyte)) & (R-1)

二进制的快速排序：
     思路：
            对一个数组中的数进行排序：
            首先对数组中的每一个数中 的第一个位 操作 0在前 1在后
            这样一次 对后面的每个位进行操作
        quicksortB(int a[], int l, int r, int w)
        {
            int i = 1, j = r;
            if(r <= l || w > bitsword) return ;
            while(j != i){          //交换左右边 位相反的两个数
                while(digit(a[i],w) == 0 && (i < j)) i++;
                while(digit(a[j],w) == 1 && (j < i)) j--;
                exch(a[i],a[j]);
            }

            if(digit(a[r],w) == 0)j++;      //所有数的某一位都为0的话 在j++
                                            //上面有个j--
            quicksortB(a,l,j-1,w+1);        //将0 1 分开的两组分别排序
            quicksortB(a,j,r,w+1);
                
        }
        void sort(Item a[], int l, int r)
        {
            quicksortB(a,l,r,0);
        }

    MSD基数排序：
        #define bin(A) l+count[A]
        void radixMSD(Item a[], int l, int r, int w)
        { 
            int i, j, count[R+1]; 
            if (w > bytesword) return;
            if (r-l <= M) { 
                insertion(a, l, r); return;
            }
            for (j = 0; j < R; j++) count[j] = 0;
            for (i = l; i <= r; i++) 
                count[digit(a[i], w) + 1]++;
            for (j = 1; j < R; j++) 
                count[j] += count[j-1];
            for (i = l; i <= r; i++) 
                aux[l+count[digit(a[i], w)]++] = a[i];
            for (i = l; i <= r; i++) a[i] = aux[i];
                radixMSD(a, l, bin(0)-1, w+1);
            for (j = 0; j < R-1; j++)
                radixMSD(a, bin(j), bin(j+1)-1, w+1);
        }








