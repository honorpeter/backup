/*
 * 这将列队看做 一个向下增长的一个列队
 * front指向最前的  rear指向最后一个
 */
/*
** A queue implemented with a static array.  The array size can
** be adjusted only by changing the #define and recompiling
** the module.
*/
#include "queue.h"
#include <stdio.h>
#include <assert.h>

#define	QUEUE_SIZE	100	/* Max # of values on the queue */
#define	ARRAY_SIZE	( QUEUE_SIZE + 1 )	/* Size of array */
/*实际 数组比存值 多了 一个 这样可以分别出 那个 full和empty
*/
/*
**	The array that holds the values on the queue, and pointers
**	to the front and rear of the queue.
*/
static	QUEUE_TYPE	queue[ ARRAY_SIZE ];
static	size_t		front = 1;
static	size_t		rear = 0;

/*
**	insert
*/
void
insert( QUEUE_TYPE value )
{
	assert( !is_full() );
	rear = ( rear + 1 ) % ARRAY_SIZE;
        //取余 这样不可以无限的增长 小于 数组的长度
        //front 也取余这样可以 当做一个循环 不会出数组长度
        //一直循环
	queue[ rear ] = value;
}

/*
**	delete
*/
void
delete( void )
{
	assert( !is_empty() );
	front = ( front + 1 ) % ARRAY_SIZE;
}

/*
**	first
*/
QUEUE_TYPE first( void )
{
	assert( !is_empty() );
	return queue[ front ];
}

/*
**	is_empty
*/
int
is_empty( void )
{
	return ( rear + 1 ) % ARRAY_SIZE == front;
}

/*
**	is_full
*/
int
is_full( void )
{
	return ( rear + 2 ) % ARRAY_SIZE == front;
}
