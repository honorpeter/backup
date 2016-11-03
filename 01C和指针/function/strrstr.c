#include<stdio.h>
#include <string.h>
char * strrstr(char const *s1, char const *s2)
{
    register char *last;
    register char *current;

    last = NULL;
    if (*s2 != '\0') {
        current = strstr(s1, s2);

        while(current != NULL ){
            last = current;
            current = strstr(last + 1, s2);
        }
            
    }//End of the if
    return last;
}

char a[]="xiaoyan is a good girl xiaoyan xiaolong";
char b[]="xiaoyan";
int main(int argc, const char *argv[])
{
    char *hh;
    hh = strrstr(a, b);
    printf("%s\n",hh);
    return 0;
}
