#include<stdio.h>
//计算数列的第n项
//1 1 2 3 5 8 。。。。。
long fibonacci(int n)
{
    if (n <= 2) {
        return 1;
    }
    return fibonacci(n - 1) + fibonacci(n - 2);
}

int main(int argc, const char *argv[])
{
    
    int n = 3;
    int b;
    b = fibonacci(n);
    printf("%d\n",b);

    return 0;
}
