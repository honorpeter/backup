#ifndef LIST_INCLUDED
#define LIST_INCLUDED

#define T list_T
typedef struct T *T;

struct T{               //节点声明
    T rest;             //指向下一个节点
    void *first;        //指向  链表的内容  声明一个指针可以节省空间 
                        //  指向任何类型
};

extern T        List_append(T list, T tail);    //
extern T        List_copy(T list);              //也需要给头指针内存
extern T        List_list(void *x, ...);        //初始化一个链表
                                                //需要事先 声明一个存储
                                                // 头指针的内存 这个函数
                                                // 只返回头指针的地址
extern T        List_pop(T list, void **x);
extern T        List_push(T list, void *x); //将x添加到 list后面
extern T        List_reverse(T list);
extern int      List_length(T list);
extern void     List_free(T *list);
extern void     List_map(T list,    
                        void apply(void **x,void *cl), void *cl);

extern void **  List_toArray(T list, void *end);//end放在最后
#undef T
#endif






