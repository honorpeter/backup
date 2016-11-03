可执行文件的创建——预处理、编译和链接:
        gcc 

ELF文件格式 :
    查看ELF文件的头部
        readelf -h hello
            ELF header                        ELF header
            Program header table (optional)   Program header table
            Section 1                         Segment 1
            ...                               Segment 2
            Section n                         ...
            Section header table              Section header table 
    查看该ELF文件依赖的共享库:
        ldd main 
                readelf -d 也可以看依赖的so文件
        readelf -d main  
            
    可执行程序的执行环境:
        Shell会调用execve将命令行参数和环境参数传递给可执行程序的main函数

        int execve(const char * filename,char * const argv[ ],
                char * const envp[ ]);
    动态链接:
            可执行程序装载时动态链接和运行时动态链接，
        编译成libshlibexample.so共享文件
                gcc -shared shlibexample.c -o libshlibexample.so -m32
        加载 装载时动态连接 文件
            gcc main.c -o main -L/path/to/your/dir -lshlibexample -ldl -m32
            文件包含的时候 只需要使用include"hh.h"

        运行时动态连接文件:
            export LD_LIBRARY_PATH=$PWD #将当前目录加入默认路径
            否则main找不到依赖的库文件，当然也可以将库文件copy到默认路径下。

            文件使用的方法:
                    /* Use Dynamical Loading Lib */
                void * handle = dlopen("libdllibexample.so",RTLD_NOW);
                        //打开动态连接文件
                if(handle == NULL)
                {
                    //打开失败处理
                    printf("Open Lib libdllibexample.so Error:%s\n",dlerror());
                    return   FAILURE;
                }
                int (*func)(void);  //声明函数指针
                char * error;
                func = dlsym(handle,"DynamicalLoadingLibApi");//在动态文件中
                                    //寻找函数地址  赋值给func
                if((error = dlerror()) != NULL)
                {
                    printf("DynamicalLoadingLibApi not found:%s\n",error);
                    return   FAILURE;
                }    
                printf("Calling DynamicalLoadingLibApi() function of libdllibexample.so!\n");
                func();  //调用函数
                dlclose(handle);       //关闭函数

        另一种方法添加动态链接库:
                sudo bash -c "echo /usr/local/cuda/lib64/ > /etc/ld.so.conf.d/cuda.conf"
                将链接库的目录 放到 链接库的加载目录中 
                sudo ldconfig
                重新加载






            
    











