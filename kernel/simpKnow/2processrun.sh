 一个写好的程序  怎么翻译 连接 执行

 1 预处理
    gcc -E -o hello.cpp hello.c         -E选项只执行 预处理命令
 2 编译
    gcc -x cpp-output -S -o hello.s hello.cpp  生成汇编代码
    gcc -x assembler -c hello.s -o hello.o  生成二进制文件  ELF格式文件
 3 连接
    gcc -o hello hello.o            生成可执行文件      ELF格式的文件


动态静态库加载：
    默认是加载 动态库
     -static 只加载静态文件


可执行文件内部是什么：
                                PE          window
    目标文件格式：a.out   COFF         
                                ELF         linux


    ELF分类：
        重定位文件
                    .o文件      
        可执行文件
                    
        共享文件
                    动态链接


    ELF格式：
        ELF header

        Section 1
        ...
        Section 2




        readefl -h hello        查看一个文件的header
        ELF header:     记录很多的信息
            Magic:
            Class:
            Data:
            Version:
            OS/ABI:
            ABI Version
            Type:
            Machie:
            Version
            Entry point address:        入口地址
            Start of program headers:
            Start of section headers
            ....

执行过程：
        在shell环境中执行一个程序：
            int main (int argc, char *arg[], char *envp[])
            shell可以将 选项 和shell环境变量传递给 mian函数
                shell会调用execve()系统调用将这些传递过去
        动态链接： 可执行程序装在时动态连接     运行时动态连接
            生成共享库：
                gcc -shared shi.c -o shi.so     生成shi.so共享文件

            可执行程序装载：
                编译的时候连接：
                    gcc main.c -o mian -L /usr/lib -l shi.so -ldl
                    -L指定目录  -l指定文件名    -ldl动态加载器
            运行时动态连接
                需要修改main.c 使用dlopen()函数。。。。
            


            









