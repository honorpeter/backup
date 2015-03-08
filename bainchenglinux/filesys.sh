文件和目录管理：
    文件及元数据：
        一组stat函数：
        <sys/types.h>
        <sys/stat.h>
        <unistd.h>
        int stat(const char *path,struct stat *buf);
        int fstat(int fd,struct stat *buf);
            返回文件描述符的信息
        int lstat(const char *path,struct stat *buf);
            这个函数和stat一样只是 它返回的值链接符号本身的信息

        <sys/stat.h>
        struct stat{
            dev_t st_dev;       //ID of device containing the file
                                如果是网络文件系统 NFS 值为0
            ino_t st_ino;       //inode number
            mode_t st_mode;     //permissions
            nlink_t st_nlink;   //number of hard links  硬连接数 
            uid_t st_uid;       //user ID of the owner
            gid_t st_gid;       //group ID of owner
            dev_t st_rdev;      //device Id (if special file)
            off_t st_size;      //total size in bytes
            blksize_t st_blksize;//blocksize of filesystem IO
                                表示有效文件IO首选块大小 最佳用户缓冲块
            time_t st_atime;     //last ccess time
            time_t st_mtime;    //last modification time
            time_t st_ctime;    //last status change time
        };

        OK  0 failed -1     errno:
        例 ：判断文件类型  详见：function/filesys/type.c
    权限：
            <sys/types.h>
            <sys/stat.h>
            int chmod(const char *path, mode_t mode);
            int fchomd(int fd,mode_t mode);
            OK 0 failed -1
        所有权：
            <sys/types.h>
            <unistd.h>
            int chown(cosnt char *path,uid_t owner,gid_t group);
            int lchown(cosnt char *path,uid_t owner,gid_t group);
            int fchown(int fd,uid_t owner,gid_t group);
    扩展属性：
        和不同的文件系统有关
        属性由  命名空间 键值 值 组成
            命令空间：
                system
                security
                trusted
                user
            返回扩展属性：
                <sys/types.h>
                <sys/attr/xattr.h>
                ssize_t getxattr(cosnt char *path,const char *key,
                                void *value, size_t size);
                ssize_t lgetxattr(cosnt char *path,const char *key,
                                void *value, size_t size);
                ssize_t fgetxattr(int fd,const char *key,
                                void *value, size_t size);
                函数将属性的值放在value 大小是size
                如果size为0 则会设置size的大小 但不会设置value
                failed -1
                    ERANGE size太小 缓冲区不够 保存键值
            设置扩展属性 必须拥有足够的权限：
                <sys/types.h>
                <attr/xattr.h>
                int setxattr(const char *path,const char *key,
                            const void *value, size_t size,int flags);
                int lsetxattr(const char *path,const char *key,
                            const void *value, size_t size,int flags);
                int fsetxattr(int fd,const char *key,
                            const void *value, size_t size,int flags);
                将键key的值设置为value 大小是size
                flags指定方式：
                    XATTR_REPLACE
                    XATTR_CREATE
                    m默认0 两个都包含
                OK 0 failed -1
            获取文件扩展属性集：
                <sys/types.h>
                <attr/xattr.h>
                ssize_t listxattr(const char *path,
                                char *list,size_t size);
                ssize_t llistxattr(const char *path,
                                char *list,size_t size);
                ssize_t flistxattr(int fd,
                                char *list,size_t size);
                    OK 0 failed -1
                    将属性集 存放在list缓冲区 大小是size
                    每个属性都已 \0 结尾
        目录：
            获取当前目录：
                char *getcwd(char *buf,size_t size);
                将当前的目录的绝对路径存放到buf缓冲区 大小是size
                返回一个指向buf的指针
                char *swd;
                swd=getcwd(NULL,0);
                    这样c库默认 找一片区域 把名字存放在哪里
                free(swd);  需要释放
                failed NULL
            改变当前目录
               <unistd.h> 
               int chdir(const char *path);
               int fchdir(int fd);
                    一般会先打开 swd_fd=open(".",O_RDONLY);
               OK 0 failed -1

            创建目录：
                <sys/types.h>
                <sys/stat.h>
                int mkdir(const char *path, mode_t mode);
                OK 0 failed -1
            删除目录：
                <unistd.h>
                int rmdir (const char *path);
                OK 0 failed -1
                删除的时候 目录里面必须什么都没有 空目录
                才可以删除
                errno：
                    ENOTEMPTY   目录不为空
            去读目录内容：
                先创建目录流：
                <sys/types.h>
                <dirent.h>
                DIR *opendir(const char *name);
                目录和文件描述符信息几乎一样 所以可以得到文件描述符
                #define _BSD_SOURCE
                <sys/types.h>
                <dirent.h>
                int dirfd(DIR *dir);

            从目录流读取：
                <sys/types.h>
                <dirent.h>
                struct dirent *readdir(DIR *dir);
                调用成功的时候 会返回dir指向的下一个目录项
                struct dirent{
                    ino_t d_ino;
                    off_t d_off;
                    unsigned short d_reclen;
                    unsigned char d_type;
                    char d_name[256];
                };
                连续调用这个函数 可以遍历所有的目录项 返回NULL
                失败时 也会返回NULL 所以要设置errno为0
            关闭目录流：
                <sys/types.h>
                <dirent>
                int closedir(DIR *dir);
                OK 0 failed -1

                搜索目录寻找存在指定项 function/filesys/find_file_in_dir.c
    链接：
        硬链接：
            创建：
                <unistd.h>
                int link(const char *oldpath,const char *newpath);
                OK 0 failed -1
                errno:
                    EEXIST      以存在将不会覆盖原来的目录项
                    EXDEV       在不同的文件系统上
        软链接：
            创建：
                <unistd.h>
                int symlink(const char *oldpath,const char *newpath);
                OK 0 failed -1
            解除链接：
                <unistd.h>
                int unlink(const char *pathname);
                OK 0 failed -1   不会删除目录 
                rmdir()删除目录
            c语言提供的remove函数 可以文件目录。。。
                <stdio.h>
                int remove(const *char *path);
                OK 0 failed -1
            拷贝和移动文件：
                拷贝 没有系统调用 自己实现
            移动：
                <stdio.h>
                int rename(const char *oldpath,constchar *newpath);
                    这两个地方必须 位于同一个文件系统
                OK 0 failed -1
    设备节点：
        每一个设备就像一个 文件一个 有inode 也就是设备节点 
            可以像文件一个打开 读写
        每一个设备 有一个主设备号和次设备号 主设备号会载入内存
        特殊设备节点：
            空设备  /dev/null       主设备号 1      次3
                    所有read请求都会返回    EOF
            零设备  /dev/zero               1          5
                    .....           .......null
            满设备  /dev/full               1           7
                            ...     ...     '\0'
        随机数生成器：
            /dev/random     /dev/urandom    主1 次8 and 9
    带外通信：
        进程如何读取串口设备的远端硬件信息：
        usys/ioctl.h>
        int ioctl(int fd,int request,...);
            request特殊请求代码 由内核进程预定义执行那种操作
                ret = ioctl(fd,CDROMEJECT,0);
    监视文件事件：
        初始化inotify
            <sys/inotify.h>
            int inotify_init1(int flags);
            flags:
                通常是 0 
                    IN_CLOEXEC  对新文件描述符设置执行后关闭
                IN_NONBLOCK
                OK 返回文件描述符 failed -1
        监视：
            添加一个监视：
                <sys/inotify.h>
                int inotify_add_watch(int fd,
                                        const char *path,
                                        uint32_t mask);
                    mask:
                        IN_ACCESS       READ FORM FILE
                        IN_MODIFY
                        IN_ATTRIB       CHANGE THE ATTR
                        IN_CLOSE_WRITE
                        IN_CLOSE_NOWRITE
                        IN_OPEN
                        IN_MOVED_FROM       DELETE FILE FORM DIR
                        IN_MOVED_TO         文件已添加到监视目录
                        IN_CREATE       文件已在监视目录创建‘
                        IN_DELETE
                        IN_DELETE_SELF
                        IN_MOVE_SELR
                        IN_ALL_EVENTS
                        IN_MOVE
        inotify事件：
                <sys/inotify.h>
                struct inotify_event{
                    int wd;     //这文件描述符的事件 inotify_add_watch 
                                    返回值
                    uint32_t mask;
                    uint32_t cookie;
                    uint32_t len;
                    char name[];
                };

                name是变长数组c99

        删除inotify监视：
            <inotify.h>
            int inotify_rm_watch(int fd,uint32_t wd);
        摧毁inotify实例：
            int ret;
            ret = close(fd);
