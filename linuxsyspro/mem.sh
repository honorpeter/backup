内存管理：
        动态内存分配：
        c库提供的三个函数：
            malloc
            realloc
            calloc
            free
    对齐：
            数据对齐是指数据在内存中的存储排列方式。
                如果内存地址A是2的n次幂的整数倍  我们就说A是n字节对齐
                对齐 相当于 一行一行的往下排    每行的大小是2的n次方 
                                                一共整数陪 个行
        预对齐内存分配：
            #define _XPOEN_SORCE 600
            #define _GUN_SORCE
            <stdlib.h>
            int posix_memalign(void **memptr,
                                size_t alignement,
                                size_t size);
                调用成功的时候 返回size字节的动态内存 并保证是按照alignement
                进行对齐的 alignement必须是2的整数幂
            返回地址 保存在memptr中
            OK 0 failed -1  不会设置errno的值 而是直接返回错误号
                char *buf;
                int ret;

                ret =posix_memalign(&buf,256,1024);
                if(ret){
                    fprintf(stderr,"posix_memalign",strerror(ret));
                    return -1;

                }
                free(buf);  需要使用free释放
        对齐：
            标准类型：
                    按照定义 对齐就行了
            动态内存
                    按照定义 对齐就行了
            复杂数据类型：
                    结构体：
                        和它成员中 最大的那个类型是一样的  不够填充
                        如果按照 降序来定义的话 可以减少空间
                        也可以使用 -Wpadded选项来 优化这个
        匿名内存映射：
            当你需要的内存空间很多的情况下 就考虑  这个映射把
            每次 申请内存会分给你一个 页的 大小的空间  所以说 需要大的空间
            就考虑这个
            使用完之后就可以释放了

            创建映射：
                <sys/mmap.h>
                void *p;
                p = mmap(NULL,          //do not care where
                        512*1024,       //512kb
                        PROT_READ,
                        MAP_ANONYOUS | MAP_PRIVATE, //和文件内存映射 就多了
                                                    //一个MAP_ANONYOUS
                        -1,
                        0);
                    if(p == MAP_FAILED)
                        perror("mmap");
                    else
                            .....
    高级内存分配：
        修改管理内存的参数：
            <malloc.h>
            int mallopt(int param,int value);
                 OK not 0    failed 0
            param:
                M_CHECK_ACTION
                    MALLOC_CHECK_环境变量 它的值
                M_MMAP_MAX  
                    动态内存请求的最大内存映射数    为0禁止内存分配
                    当达到设定的值的时候 只能在 堆中进行分配
                M_MMAP_THRESHOLD
                    该值决定  匿名映射来分配 
                    为0 一起分配都使用 匿名映射 不再使用堆
                M_MXFAST
                    fast bin的最大大小  是堆中特殊的内存块 永远不和
                        临近的内存块合并 也永远不归还给系统
                M_PERTURB
                    支持内存定位 它可以帮助检查内存管理错误 
                M_TOP_PAD
                    调整数据段的大小时 所使用的填充字节数   
                    glibc维护的内存
                M_TRIM_THRESHOLD
            使用这些参数的时候 必须写在malloc函数之前
                int ret;
                ret mallopt(M_MMAP_THRESHOLD,64*1024);
                if(!ret)
                    fprintf(stderr,"mallopt failed\n");
                    //下面就可以使用malloc在 mallopt分配好的空间上分配了
                还有其他函数显示 mallopt分配的空间
                <malloc.h>
                size_t malloc_usable_size(void *ptr);
                    查询一块已分配内存中有多少可用的字节
                    int malloc_trim(size_t padding);
                        强制glibc归还所有的可释放的动态内存给内核
        调试内存分配：
            MALLOC_CHECK_=1 ./hh            设置这个值 然后执行程序
                当它为 0 时 存储系统会忽略所有错误
                        1   stderr
                        2   立刻abort终止
        获取统计信息：
            <malloc.h>
            struct mallinfo mallinfo(void);
                struct malloinfo{
                int arena;      //size of data segment used by malloc
                int ordblks;    //number of free chunks
                int smblks;     //number of fast bins
                int hblks;      //number of anonymous
                int hblkhd;     //size of anonymous mappings
                int usmblks;    //maximu tatal allocated  size
                int fsmblk;     //size of available fast bins
                int uordblks;   //size of total allocated space
                int fordblks;   //szie of available chunks
                int keepcost;   //size of trimable space
                };

    基于栈的分配：
            <alloca.h>
            void *alloca(size_t size);
                OK  返回指向这里的指针 Failed NULL
                当调用它的函数返回时 自动释放
                不可移植
        把字符串复制到栈中
            char *dup;

            dup = alloca(strlen(song)+1);
                            //将song指向的内存 考到栈中
            strcpy(dup,song);
            return;
            
            or  strdup linux 特有的
            #define _GUN_SORCE
            <string.h>
            char *strdupa(const char *s);
            char *strndupa(const char *s,size_t n); 会在后面加NUL
        变长数组：
            使用方式：
                for(i=0;i<n;++i){
                    char foo[i+1];
                    // use foo
                }
                foo是一个有i+1个char的数组 每次循环时 都会自动创建 foo循环
                    结束释放 但alloca分配的直到函数返回才释放
                    如果使用alloca 写这个for循环 很站空间
    内存操作：
        字节设置：
            <string.h>
            void *memset(void *s,int c size_t n);
            将 s指向的前n个字节设置为 c 并返回s
        字节比较：
            <string.h>
            int memcmp(const void *s1,const void *s2,size_t n);
            > 0     0   <0
            由于存在结构填充 通过这个函数来比较 结构体 是不可靠的
            可以一个一个的比较结构体的元素
                int compar_dinghies(struct dinghy *a,struct dinghy *b){
                    int ret;
                    if(a->nr_oars < b->nr_oars)
                        return -1;
                    ret = strcmp(a->boat_name,b->boat_name);
                    if(ret)
                        return ret;
                }
        字符移动：
            <string.h>
            void *memccpy(void *dst,const void *src,int c,size_t n);
                在前n中 找到字节c就停止复制
                    找到c返回c下一个字节 指针   没找到NULL
            #define _GUN_SORCE
            <string.h>
            void *memccpy(void *dst,const void *src,size_t n);
                返回指向 被复制的最后一个字节的下一个字节
            void *memmove(void *dst,const void *src,size_t n);
                这个函数 可以安全处理区域重叠问题
            void *memcpy(void *dst,const *void *src,size_t n);
                不支持重叠
           
        字节查找：
            <string.h> 
            void *memchr(const void *s,int c,size_t n);

            #define _GUN_SORCE
            <string.h>
            void *memrchr(const void *s,int c,size_t n);
                返回指向第一个匹配c的字节指针 failed null
                memrchr反向搜索
            
            #define _GUN_SORCE
            <string.h>
            void memmem(const void *haystack,
                        size_t haystacklen,
                        const void *needle,
                        size_t needlelen);
                    在一块内存中搜索任意字节的数据
                    返回第一个指向的指针
        字节加密：
            #define _GUN_SORCE
            <string.h>

            void *memfrob(void *s,size_t n);
                前n个字节都与 42进行异或操作来加密
                该函数的返回s
            再次对相同的区域 变可以解密
    内存锁定：
        必须拥有root权限
        不让这个地址换出 内存
        锁定部分地址空间
            <sys/mman.h>
            int mlock(const void *addr,size_t len);
            OK 0 failed -1
                errno;
                    RLIMIT_MEMLOCK  有限制。。。。
        锁定全部地址空间：
            int mlockall(int flags);
                flags:
                    MCL_CURRENT
                        将所有现在已映射的页面 锁定在进程的地址空间内
                    MCL_FUTURE
                        将未来的映射的也锁定
        内存解锁：
            <sys/mman.h>
            int munlock(const void *addr,size_t len);
            int munlockll(void);
            
        该页在物理内存中吗
            <unistd.h>
            <sys/mman.h>
            int mincore(void *start,
                        size_t length,
                        unsigned char *vec);
                        ....... vec接收返回信息 。。。。

