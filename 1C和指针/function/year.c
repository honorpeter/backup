#include <stdio.h>
/*判断是否为闰年
 * 输入一个数 输出这个数是否为闰年
 * 没有检查 输入的数 是否值整形
 * */
int main(int argc, const char *argv[])
{
    int year;
    char leap_year;

    printf("Please input a year\n");
    scanf("%d",&year);
    
    if(year % 400 == 0)
        leap_year = 1;
    else if (year % 100 == 0)
        leap_year = 0;
    else if (year % 4 == 0)
        leap_year = 1;
    else 
        leap_year = 0;

    if(leap_year)
        printf("%d is \n",year);
    else
        printf("%d is not\n",year);
    return 0;
}
