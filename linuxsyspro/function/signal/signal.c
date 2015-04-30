#include<stdio.h>
#include<stdlib.h>    
#include <unistd.h>
#include <signal.h>

static void signal_handler(int signo)
{
    printf("Caught SIGINT");
    exit(EXIT_SUCCESS);
}

int main(int argc, const char *argv[])
{
    if (signal(SIGINT,signal_handler) == SIG_ERR) {
        fprintf(stderr, "Cannot handle SIGINT\n");
        exit(EXIT_FAILURE);
    }

    for(;;)
        pause();
    return 0;
}
