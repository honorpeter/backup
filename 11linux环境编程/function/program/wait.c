#include<stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(int argc, const char *argv[])
{
    int status;
    pid_t pid;
    if(!fork())
        return 1;   //结束子进程

    pid = wait(&status);

    if(pid == -1){
        perror("wait");
    }
    printf("pid=%d \n",pid);
    
    if (WIFEXITED(status)) {
        printf("Normal termial with exit status = %d\n",
                WEXITSTATUS(status));
    }
    if (WIFSIGNALED(status)) {
        printf("killed by signal = %d%s\n",WTERMSIG(status),
                WCOREDUMP(status)?"dumped core":"");
    }
    if (WIFSTOPPED(status)) {
        printf("stoped by signale = %d\n",WSTOPSIG(status));
    }
    if (WIFCONTINUED(status)) {
        printf("Continued\n");
    }
    return 0;
}
