#include<stdio.h>
//该函数的作用是 将一个整型的数 打印成字符的形式 输出
//递归 以函数里面的自己调用为分界线  以上操作是 顺序执行下去
//一下 操作  是 到这执行过来  
//判断语句是 执行到哪里
void binary_to_ascii(unsigned int value)
{
    unsigned int quotient;

    quotient = value /10;
    if (quotient != 0) {
        binary_to_ascii(quotient);
    }
    putchar(value % 10 + '0');//加上 0 的字符编码 便可以实现以字符的形式打印
}
int main(int argc, const char *argv[])
{
   
    unsigned int a= 12345;
    binary_to_ascii(a); 
    return 0;
}

