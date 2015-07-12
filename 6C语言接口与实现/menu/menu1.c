#include<stdio.h>
#include<stdlib.h>    


#define CMD_LEN 1024

int help ();
int version ();
int quit ();

typedef struct DataNode {
    char *cmd;
    char *desc;
    int (*handler)();
    struct DataNode *next;
} tDataNode;

tDataNode allCmd[] = {
    {"help","This is help command",help,&allCmd[1]},
    {"version","This version is 1.0 ",NULL,&allCmd[2]},
    {"quit","This is quit command ",quit,NULL}
};


int main(int argc, const char *argv[])
{
    char cmd[CMD_LEN];
    while(1){
        printf("Please input a command>>\n");
        scanf("%s",cmd);

        tDataNode *p = allCmd;
        while(p != NULL)
        {       
            if( strcmp(p->cmd,cmd) == 0) {
                printf("%s\n",p->desc);
                if (p->handler != NULL) {
                    p->handler();
                }
                break;
            }
            p = p -> next;
        }
    }
    return 0;
}

int help ()
{
    printf("help command\n");
}
int version ()
{
    printf("version command\n");
}
int quit ()
{
    exit(1);
}
