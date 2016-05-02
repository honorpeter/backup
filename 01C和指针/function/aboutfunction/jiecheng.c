#include<stdio.h>
int factorial(int n)
{
    if(n <= 0)
        return 1;
    else
        return n*factorial(n-1);
}    
int main(int argc, const char *argv[])
{
    
    int a = 3;
    int b;
    b = factorial(a);
    printf("%d\n",b);
    return 0;
}
