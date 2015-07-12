#include<stdio.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <sys/types.h>
#include <fcntl.h>
#include <linux/fs.h>
#include <unistd.h>

int main(int argc, const char *argv[])
{
    pid_t pid;
    int i;

    pid = fork();
    if (pid == -1) {
        return -1;  
    }
    else if(pid != 0)
        exit(EXIT_SUCCESS);

    if (setsid()== -1) {
        return -1;
    }

    if (chdir("/")==-1) {
        return -1;
    }

    for (i = 0; i < NR_OPEN; i++) {
        close(i);
    }
        
    // redirect fd's 0 1 2 to /dev/null
    open("/dev/null",O_RDWR);
    dup(0);
    dup(0);

    //do its daemon thing
    return 0;
}
