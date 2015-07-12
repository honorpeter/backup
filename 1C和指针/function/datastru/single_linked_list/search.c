#include<stdio.h>
#include "node.h"
/*
 * 实现不分类型查找 单链表
 * 这个函数 传递一个链表root指针 value 和一个函数 变可以实现 不分类型查找
 * compare函数写的时候 要符合一定的规范
 */
Node *search_list(Node *node, void const *value, 
        int (*compare)(void const *, void const *))
{
    while(node != NULL){
        if( compare(&node->value, value)==0)
            break;
        node = node -> link;
    }
    return node;
}
/* 
 * 写一个compare函数做例子      这个实现了查找整形的数
 */
int compare_ints(void const *a, void const *b)
{
    if( *(int *)a == *(int *)b)     //这里要强制类型转换
        return 0;
    else
        return 1;
}

//使用这两个函数：
 desired_node = search_list(root ,&desired_value, 
         compare_ints);
    
