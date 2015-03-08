数据类型关系：
    基本元素 ：    静态数组     动态分配数组        链式结构
    在这些基本元素  之上 又有 堆栈 队列 树
所以 下面 正确。。。
经典抽象数据类型：
    都有三种实现方案：
    1. 使用静态数组
    2. 使用动态分配的数组
    3. 动态分配的链式结构
        三种方式的优缺点：
            静态数组：
               只能在编译之前确定个数  不能使用变量作为个数
                一编译好 就已经不能改变 放在 data段 
            动态分配的数组：
                 可以使用变量确定个数  程序运行的时候分配 放在heap区
                 这个也可以无限个 但需要检查 当用完的时候 再分配一个大的
                    复制过去
            链式结构：
                程序运行的时候分配 放在heap区  可以无限个
    
单链表：
    使用一个 root指针指向第一个节点 最后的一个节点指向NULL
        如果使用 一个头节点的话 浪费空间   和 也要考虑这个特殊情况
       
    节点    和      头指针
    节点类型：
        typedef	struct	NODE	{
	        struct	NODE	*link;
	        int		value;
        } Node;
    头指针：
        Node *root;
    插入链表：
        insert1.c
        insert2.c
        insert3.c
双链表：
    节点类型：
        typedef struct NODE{
            struct NODE *fwd;
            struct NODE *bwd;
            int value;
        } Node;      
    root指针：
        1 可以使用两个root指针 
        2 声明一个变量 value不能使用 fwd指向第一个节点
            bwd从末尾指向第一个节点
                这样有点浪费空间 
                    如果是动态声明头节点的话：节约空间
                        Node *root;
                        root = malloc(sizeof(Node)-sizeof(int));
                另一种方法：
                    声明一个 只包含指针的结构 根指针就是这类结构之一
                    每一个节点包含这类结构的一个
                    struct DLL_NODE;
                    struct DLL_POINTERS{
                        struct DLL_NODE *fwd;
                        struct DLL_NODE *bwd;
                    };
                    struct DLL_NODE{
                        struct DLL_POINTERS pointers;
                        int value;
                    };
        每一个链表的末尾 都指向NULL


堆栈：
    数组实现堆栈    详见 function/datastru/stack/a_stack.c
        只能在编译之前确定个数  不能使用变量作为个数
        一编译好 就已经不能改变 放在 data段 
    分配动态数组实现：      详见function/datastru/stack/d_stack.c
        可以使用变量确定个数  程序运行的时候分配 放在heap区
    链表实现：      详见function/datastru/stack/l_stack.c
        可以无限个

队列：
    数组实现队列：
        详见：function/datastru/queue/a_queue.c
    分配动态数组实现：
        和数组实现基本一样
    链表实现：
        详见：function/datastru/queue/l_queue.c

树：    只考虑二叉树    
    数组实现二叉树：
        没有实现删除操作 很麻烦 
        详见：  function/datastru/tree/a_tree.c
    动态分配数组实现：
        和数组一样
    链表实现：
        详见：   function/datastru/tree/l_tree.c
        删除操作：
            。。。。。。

实现泛型：
    超级堆栈：
        和类型无关
           使用宏定义实现 
            还可以使用 void指针实现 强制类型转化
          队列 数也都可以实现 但有问题：
            命名冲突：
                is_stack_full
                is_queue_full
                .
                .
                .
                push_int
                push_float
                .
                .
                .
            数据不在受保护了 可以直接访问

        详见： function/datastru/void/g_client.c
        
            
 
