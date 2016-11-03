/* 
 * 只使用一个链表  不会full
 * front 指向最面 
 * rear 指向最后一个
 */
/*
** A queue implemented with a linked list.  This queue has no size
** limit.
*/
#include "queue.h"
#include <stdio.h>
#include <assert.h>

/*
**	Define a structure to hold one value.  The link field will
**	point to the next value on the queue.
*/
typedef	struct	QUEUE_NODE {
	QUEUE_TYPE	value;
	struct QUEUE_NODE *next;
} QueueNode;

/*
**	Pointers to the first and the last nodes on the queue.
*/
static	QueueNode	*front;
static	QueueNode	*rear;

/*
**	destroy_queue
*/
void
destroy_queue( void )
{
	while( !is_empty() )
		delete();
}

/*
**	insert
*/
void
insert( QUEUE_TYPE value )
{
	QueueNode	*new_node;

	/*
	** Allocate a new node, and fill in its fields.
	*/
	new_node = (QueueNode *)malloc( sizeof( QueueNode ) );
	assert( new_node != NULL );
	new_node->value = value;
	new_node->next = NULL;

	/*
	** Insert it at the end of the queue.
	*/
	if( rear == NULL ){
		front = new_node;
	}
	else {
		rear->next = new_node;
	}
	rear = new_node;
}

/*
**	delete
*/
void
delete( void )
{
	QueueNode	*next_node;

	/*
	** Remove a node from the front of the queue.  If this is the
	** last node, set rear to NULL too.
	*/
	assert( !is_empty() );
	next_node = front->next;
	free( front );
	front = next_node;
	if( front == NULL )
		rear = NULL;
}

/*
**	first
*/
QUEUE_TYPE first( void )
{
	assert( !is_empty() );
	return front->value;
    //这里应该将 先指向下一个 然后 释然这个空间
}

/*
**	is_empty
*/
int
is_empty( void )
{
	return front == NULL;
}

/*
**	is_full
*/
int
is_full( void )
{
	return 0;
}
