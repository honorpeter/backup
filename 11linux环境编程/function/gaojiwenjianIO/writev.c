#include<stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <sys/uio.h>

int main(int argc, const char *argv[])
{
    struct iovec iov[3];
    ssize_t nr;
    int fd,i;

    char *buf[]={
        "Xiaolong is a good boy\n",
        "xiaoyan is a good gril\n",
        "happy everyday!!\n" };

    fd = open ("data.txt",O_WRONLY | O_CREAT | O_TRUNC);
    if (fd == -1) {
        perror("open");
        return 1;
    }
    for (i = 0; i < 3; i++) {
        iov[i].iov_base = buf[i];
        iov[i].iov_len = strlen(buf[i])+1;//这样可以 读取'0'字符
    }

    nr = writev(fd,iov,3);

    if(nr== -1){
        perror("writev");
        return 1;
    }

    printf("wrote %d byte\n",nr);

    if (close(fd)) {
        perror("close");
        return 1;
    }
    return 0;
}
