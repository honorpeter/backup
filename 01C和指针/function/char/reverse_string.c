#include<stdio.h>
void reverse_string(char *string)
{
    char *last_char;
    //把last_char指向最后一个字符
    for(last_char = string; *last_char != '\0'; last_char++)
        ;
    last_char--;
    /*交换string和last_char指向的字符 然后string前进一步 last_char后退一步
     * 在两个指针相遇或擦肩而过之前重复过程
     */
    while( string < last_char ){
        char temp;
        temp = *string;
        *string++ = *last_char;
        *last_char-- = temp;
    }

}
char a[] = "xiaoyan is a good girl";
int main(int argc, const char *argv[])
{
    reverse_string (a);
    printf("%s\n",a);
    return 0;
}
