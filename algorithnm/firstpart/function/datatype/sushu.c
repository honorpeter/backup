/*计算10000之内的素数   
 * 计算思路
 *      筛选法：
 *          1 让 a[i] = 1 这样表示都是素数
 *          2 从头开始扫描这个数组 把是这个数的倍数都变为0 表示不是素数
 */
#include<stdio.h>

#define N 10000

char a[N];      //设置存储数的数组 

int main(int argc, const char *argv[])
{
    int i, j;
    //讲数组的值都变为1     表示都是素数    从2开始 因为0 1 会让所有变为素数
    for (i = 2; i < N; i++) {
        a[i] = 1;
    }

    //将是i的倍数 的值变为0 表示不是素数

    for (i = 2; i < N; i++) {
        if(a[i]){
            //注意：这里是j*i<N
            for (j = i; j*i < N; j++) {
                a[i*j] = 0;
            }
        }
    }

    //打印
    for (i = 2; i < N; i++) {
        if(a[i]){
            printf("%4d   ",i);
        }
    }

    return 0;
}
