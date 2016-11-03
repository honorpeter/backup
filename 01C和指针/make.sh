开发工具：
make
    make命令和makefile文件：
        makefile的语法：
            makefile文件 由一组 依赖关系和和规则构成
                每一个依赖关系 有一个目标文件和一组该目标文件所依赖的文件
        make命令的选项和参数
            -k
                发现错误的时候仍然执行
            -n
                让make 输出将要执行的步骤 不执行
            -f  
                告诉makefile的名字是什么 默认是Makefile

            1 依赖关系
                myapp: main.o 2.o 3.o 
                main.o: main.c a.h
                2.o: 2.c a.h b.h
                3.o: 3.c b.h c.h
            2 规则：
                make命令内置很多默认规则
                可以定义一些外部规则
                注意：空格和tab是有区别的
                    规则所在行 必须以tab开头  行尾不能有空格
                例：

                myapp: main.o 2.o 3.o 
                    gcc -o myapp main.o 2.o 3.o
                main.o: main.c a.h
                    gcc -c main.c
                2.o: 2.c a.h b.h
                    gcc -c 2.c
                3.o: 3.c b.h c.h
                    gcc -c 3.c
            makefile文件中的注释：
                #
            makefile文件中的宏
                定义宏： MACRONAME=value 
                引用：    ${MACRONAME} or $(MACRONAME)
                其他宏：
                    $?  列出当前目标所 依赖的文件列表中比单签目标文件
                        还要 新的文件
                    $@  当前目标的名字
                    $<  当前依赖文件的名字
                    $*  步包括后缀名的当前依赖的文件名字
            特殊字符：
                -   告诉make忽略所有错误
                @   打印到输出窗口内容

        多个目标：
            在makefile中增加clean来删除不需要的文件爱你
            增加 install来将程序到另一个目录
                #where to insall
                INSTDIR = /usr/local/bin
                install: myapp
                   @if [ -d ${INSTDIR} ] ;\
                   then \
                    cp myapp ${INSTDIR} ;\
                else \
                    echo "Sorry "
               fi

                clean:
                    -rm main.o 2.o 3.o
        内置规则：
            该变内置规则：
                make CC=gcc CFLAGS="-Wall -g"   foo
                ......
                .SUFFIXES:  .cpp
                .cpp.o:
                $(cc) -xc++ $(CFLAGS) -I$(INCLUDE) -c $<
        用make命令管理函数库：
                
        makefile文件和子目录
        。。。。


        makefile中使用变量:
            In some other versions of make, variables are called macros
            声明：
                    objects = main.o kbd.o command.o display.o /
                    insert.o search.o files.o utils.o
            调用：
                    $(objects)

                Simply expanded variables are defined by lines using 
                        ‘:=’ or ‘::=’

                variable is a recursively expanded variable:
                    For example,
                            foo = $(bar)
                            bar = $(ugh)
                            ugh = Huh?
                            all:;echo $(foo)
                        will echo ‘Huh?’
        让make自动推导:
            只要make看到一个[.o]文件，它就会自动的把[.c]文件加在依赖关系中

    赋值：
        :=   :
                foo := $(bar)
                将bar的值赋给foo
        条件赋值：
            foo ?= 1
                只有当foo变量还没有被定义的时候，才会将1的值赋给foo。 

        The call Function:
            You can write a complex expression as the value of a variable, 
                    then use call to expand it with different values.
            syntax:
                    $(call variable,param,param,…)

                    This macro simply reverses its arguments:

                    reverse = $(2) $(1)           #$(1) 代表a $(2) 代表b
                    
                    foo = $(call reverse,a,b)       
        The shell function:
            contents := $(shell cat foo)
                sets contents to the contents of the file foo, with a space 
                (rather than a newline) separating each line. 

        自带函数：
            wildcard:
            在Makefile规则中，通配符会被自动展开。但在变量的定义和函数引用
                时，通配符将失效。这种情况下如果需要通配符有效，就需要使用
                函数“wildcard”，它的用法是：$(wildcard PATTERN...) 
                在Makefile中，它被展开为已经存在的、使用空格分开的、匹配此
                    模式的所有文件列表。
                $(wildcard *.c)”来获取工作目录下的所有的.c文件列表
                $(patsubst %.c,%.o,$(wildcard *.c))”，首先使用“wildcard”
                    函数获取工作目录下的.c文件列表；之后将列表中所有文件名
                    的后缀.c替换为.o
                    objects := $(patsubst %.c,%.o,$(wildcard *.c))
                    foo : $(objects)
                        cc -o foo $(objects)
            wildcard : 扩展通配符
            notdir ： 去除路径
                    dir=$(notdir $(src))
            patsubst ：替换通配符

            error:
                    #判断文件是否存在 和 空 比较一下
                    ifeq ($(wildcard $(CONFIG_FILE)),)
                        
                        $(error $(CONFIG_FILE) not found. )
                    endif
            foreach:
                遍历加载动态库：
                LDFLAGS += $(foreach librarydir,$(LIBRARY_DIRS),\
                    -L$(librarydir)) $(PKG_CONFIG) \
		            $(foreach library,$(LIBRARIES),-l$(library))
                PYTHON_LDFLAGS := $(LDFLAGS) $(foreach library,\
                    $(PYTHON_LIBRARIES), -l$(library))
                遍历加载头文件：
                COMMON_FLAGS += $(foreach includedir,$(INCLUDE_DIRS),\
                        -I$(includedir))
                    把变量INCLUDE_DIRS(空格分割) 遍历 赋值给 includedir 
                
                    

                    
        Makefile  $@, $^, $<
            $@  表示目标文件
            $^  表示所有的依赖文件  注意依赖
            $<  表示第一个依赖文件   依赖
            $?  表示比目标还要新的依赖文件列表  依赖
                
    包含其他文件：
            include $(hhh)


    递归 make
            对于规模比较大的程序，需要多个人在多个目录下进行开发。
                如果只用一个 Makefile 来维护就会比较麻烦，因此可以在每个
                目录下建立自己的 Makefile ，然后在总控 Makefile 中调用子
                目录的 Makefile 文件。

        目录结构如下：

        .
        ├── add
        │   ├── add_float.c
        │   ├── add.h
        │   ├── add_int.c
        │   └── Makefile
        ├── main.c
        ├── Makefile
        └── sub
            ├── Makefile
            ├── sub_float.c
            ├── sub.h
            └── sub_int.c
        1.递归调用的方式

        add：
            cd add && $(MAKE)
        它等价于

        add：
            $(MAKE) -C add
        2.总控Makefile

        CC = gcc
        CFLAGS = -O2
        TARGET = cacu
        export OBJSDIR = $(shell pwd)/objs

        $(TARGET):$(OBJSDIR) main.o
            $(MAKE) -C add
            $(MAKE) -C sub
            $(CC) -o $(TARGET) $(OBJSDIR)/*.o

        $(OBJSDIR):
            mkdir -p $@

        main.o:%.o:%.c
            $(CC) -c $< -o $(OBJSDIR)/$@ $(CFLAGS) -Iadd -Isub

        clean:
            -$(RM) $(TARGET)
            -$(RM) $(OBJSDIR)/*.o
        如果总控 Makefile 中的一些变量需要传递给下层的 Makefile，
            可以使用 export 命令。如：export OBJSDIR = ./objs

        3.子目录Makefile的编写

        Add 目录下的 Makefile 如下：

        OBJS = add_int.o add_float.o
        all:$(OBJS)

        $(OBJS):%.o:%.c
            $(CC) -c $< -o $(OBJSDIR)/$@ $(CFLAGS)

        clean:
            $(RM) $(OBJS)
        Sub 目录下的 Makefile 如下：

        OBJS = sub_int.o sub_float.o
        all:$(OBJS)

        $(OBJS):%.o:%.c
            $(CC) -c $< -o $(OBJSDIR)/$@ $(CFLAGS)

        clean:
            $(RM) $(OBJS)
                
    gdb 调试：
        启动gdb
             cc -g -o debug1 debug2.c
                -g

            启动
             gdb debug1

        运行一个程序：
             run
        栈跟踪；
             backtrace
        检查变量：
            print j
        

    使用help

















                
