#include <stdio.h>
#include <stdlib.h>
int main(int argc, const char *argv[])
{
        size_t 
        strlen(char *string) 
        {
            int length = 0;
            //字符串 指针指向第一个字符的前面
            while(*string++ != '\0')
            {
                length += 1;
            }
            return length;
        }
        char *love = "xiaoyan is a good girl";
        size_t len = strlen( love );
        printf("%d\n",len);
    return 0;
}
