/*
** Insert a value into a doubly linked list.  rootp is a pointer to
** the root node, and value is the new value to be inserted.
** Returns: 0 if the value is already in the list, -1 if there was
** no memory to create a new node, 1 if the value was added
** successfully.
*/
#include <stdlib.h>
#include <stdio.h>
#include "doubly_linked_list_node.h"


/*  使用 一个变量存储 root指针 
 * 插入分几种情况：
 *      按照是否修改root指针讨论
 *          中间位置    都不修改
 *          开始位置    修改头位置的root指针
 *          结束位置    修改尾部的root
 *          又是结尾 又是开头 两个都修改
 *      使用this表示当前的元素
 *      next指向下一个元素
 *          插入新元素的时候在这两之间插入 
 * 这里不能向单链表那样 可以传递指针的指针 因为是从 一头开始遍历的
 * 传入一头的root指针  修改的时候  还可能会修改另一个root
 * 如果要使用指针的指针的话 需要传入 两头的指针 麻烦 
 *      不过可以试试
 */
int
dll_insert( Node *rootp, int value )
{
	Node	*this;
	Node	*next;
	Node	*newnode;

	/*
	** See if value is already in the list; return if it is.
	** Otherwise, allocate a new node for the value ("newnode"
	** will point to it). "this" will point to the node that the
	** new value should follow, and "next" will point to the one
	** after it.
	*/
	for( this = rootp; (next = this->fwd) != NULL; this = next ){
		if( next->value == value )
			return 0;
		if( next->value > value )
			break;
	}
	newnode = (Node *)malloc( sizeof( Node ) );
	if( newnode == NULL )
		return -1;
	newnode->value = value;

	/*
	** Add the new node to the list.
	*/
    //可以提取这里面的共同 项 见4
	if( next != NULL ){
		/*
		** Case 1 or 2: not at end of the list 
		*/
		if( this != rootp ){	   /* Case 1: not at front */
			newnode->fwd = next;
			this->fwd = newnode;
			newnode->bwd = this;
			next->bwd = newnode;
		}
		else {			   /* Case 2: at front */
			newnode->fwd = next;
			rootp->fwd = newnode;
			newnode->bwd = NULL;
			next->bwd = newnode;
		}
	}
	else {
		/*
		** Case 3 or 4: at end of the list
		*/
		if( this != rootp ){	   /* Case 3: not at front */
			newnode->fwd = NULL;
			this->fwd = newnode;
			newnode->bwd = this;
			rootp->bwd = newnode;
		}
		else {			   /* Case 4: at front */
			newnode->fwd = NULL;
			rootp->fwd = newnode;
			newnode->bwd = NULL;
			rootp->bwd = newnode;
		}
	}
	return 1;
}
