基本的数据结构：
    数组：
        使用数组来 找出 10000之内的素数
            /function/datatype/sushu.c

    链表：
        约瑟夫问题： 所有人占成一个圈 然后按顺序数数 每数到第5的人出局 
                        直到剩下一个人
            /function/datatype/circular.c

        链表中头和尾节点/指针的常规用法：
            循环链表： 永远非空
                头插入 初始化： head->next = head;
                在x节点后插入t节点：t->next = x->next; x->next = t;
                删除x后的节点：     x->next = x->next->next;
                循环遍历：          t = head;
                    do{...t = t->next;}while(t != head);
                判断是否只有一个元素：
                    if(head -> next ==head)
            头指针 尾节点为空：
                初始化： head = NULL    详细见c语言link
                在x节点后插入t节点：
                    if( x == NULL) {head = t; head ->next = NULL;}
                    else{ t -> next = x-> next; x -> next = t;}
                删除x后的节点：
                    t = x -> next; x->next = t-> next;
                循环遍历：
                    for( t = head; t != NULL; t = t->next)
                判断是否为空:
                        if(head == NULL)

            有哑元头节点 尾节点为空
                初始化：
                        head = malloc(sizeof *head); 可以改进 见c语言
                        head -> next = NULL;
                在x节点后插入t节点：
                        t - > next = x-> next;
                        x -> next = t;
                删除x节点后的节点：
                        x -> next = x->next ->next;
                循环遍历：
                        for(t = head ->next; t != NULL; t = t ->next)
                判断是否为空：
                        if( head -> next == NULL)
            使用头指针 和 头节点 各有各自的好处 
                详见 c语言/link
                    头指针：
                        可以添加其他的选项
                            比如 链表中有几个元素   现在指向第几个。。。
                        做接口的时候 不容易实现 详见c语言/link
                    头节点：
                        有点浪费空间
                        接口容易实现
            链表接口与实现：
                    /function/list.h  list.c testlist.c
        
    字符串：
            基本字符串处理函数：
            索引数组版本：
                计算字符串的长度：
                    for(i = 0; a[i]!= 0;  i++) ; return i;
                复制：
                    for(i = 0; (a[i]=b[i]) != 0; i++);
                比较：
                    for(i = 0; a[i] == b[i]; i++)
                        if(a[i]==0) return 0;
                        return a[i] - b[i];
                    
            指针版本：
                字符串长度：
                    b =a; while( *b++); return b-a+1;
                复制：
                    while( *a++ = *b++);
                比较：
                    while( *a++ = *b++)
                    if(*(a-1)==0) return 0;
                    return *(a-1) - *(b-1);
    图：
        表现形式：
            邻接矩阵
                二维的一个数组
            邻接表

                        

     




















