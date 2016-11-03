#include <stdio.h>
#include <stdlib.h>
/*计算一个正整数的平方根
 * a(i+1) = [ a(i) + n/a(i) ] / 2
 * 第一个近似值 是 1
 * 后面的近似值 可以通过上面的函数获得
 * */
int main ()
{
    float last_guess;
    float new_guess;
    float number;

    printf( "Please input a number \n" );
    scanf( "%f" , &number );
    //%d %ld  整形长整形
    //%f %lf  
    //%c %s 字符 字符串

    if (number < 0) {
        printf("Can't compute the square root of a negative number \n");
        return EXIT_FAILURE;
    }

    new_guess = 1;
    do {
        last_guess =  new_guess;
        new_guess = ( last_guess + number / last_guess ) / 2;
        printf( "%.15ef \n" , new_guess);
    } while (new_guess != last_guess);

    printf ( "The root of the %g is %g \n" , number , new_guess);
    //c语言中 printf %g 表示打印一个浮点型数 
    //%c 字符 %s 字符串 %d %o %x 十进制 八进制 十六进制整形
    return EXIT_SUCCESS;

}
