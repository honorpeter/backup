#include<stdio.h>
#include<stdlib.h>    
#include "linklist.h"

#define CMD_LEN 1024

int Help();

tDataNode head[] = {
    {"help","This is help command",Help,&head[1]},
    {"version","This version is 1.0 ",NULL,NULL},
};

int main(int argc, const char *argv[])
{
    char cmd[CMD_LEN];
    while(1){
        printf("Please input a command>>\n");
        scanf("%s",cmd);

        tDataNode *p = FindCmd(head,cmd);

        if (p == NULL) {
            printf("This is a wrong cmd\n");
            continue;
        }
        printf("%s\n",p->desc);
        if (p->handler != NULL) {
            p->handler();
        }
    }
    return 0;
}

int Help ()
{
    ShowAllCmd(head);
}
