/*
** Insert into an ordered, singly linked list.  The arguments are
** a pointer to the root pointer for the list, and the value to
** insert.
*/
#include <stdlib.h>
#include <stdio.h>
#include "singly_linked_list_node.h"

#define	FALSE	0
#define TRUE	1
/*
 * 函数 传递指针的指针 便可以修改root指针了
 */

int
sll_insert( Node **rootp, int new_value )//这里传递 指针的指针 便可修改root
{
	Node	*current;
	Node	*previous;
	Node	*new;

	/*
	** Get the pointer to the first node.
	*/
	current = *rootp;
	previous = NULL;    //这里设置为NULL 可以通过判断这个是否是 头节点

	/*
	** Look for the right place by walking down the list
	** until we reach a node whose value is greater than
	** or equal to the new value.
	*/
	while( current != NULL && current->value < new_value ){
		previous = current;
		current = current->link;
	}

	/*
	** Allocate a new node and store the new value into it.
	** In this event, we return FALSE.
	*/
	new = (Node *)malloc( sizeof( Node ) );
	if( new == NULL )
		return FALSE;
	new->value = new_value;

	/*
	** Insert the new node into the list, and return TRUE.
	*/
	new->link = current;
	if( previous == NULL )
		*rootp = new;
	else
		previous->link = new;
	return TRUE;
}
