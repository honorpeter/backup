/*
 * 数组实现的这个二叉树
 *  如果有 很多节点没有值的话 很浪费空间
 * 存储方式：
 *                              1
 *              2                               3
 *        4           5                 6               7
 *  8          9  10        11      12      13      14      15
 *      因为数组以0开头所以 忽略0
 *          节点n的双亲节点n/2
 *          节点n的左孩子是2n
 *          节点n的右孩子是2n+1
 *     如果不忽略 0元素：
 *          节点n的双亲节点是   (n+1)/2-1
 *          节点n的左孩子是     2n+1
 *                  右          2n+2
 */
/*
 *
** A binary search tree implemented with a static array.  The
** array size can be adjusted only by changing the #define and
** recompiling the module.
*/
#include "tree.h"
#include <assert.h>
#include <stdio.h>

#define	TREE_SIZE	100	/* Max # of values in the tree */
#define	ARRAY_SIZE	( TREE_SIZE + 1 )

/*
**	The array that holds the values in the tree.
*/
static	TREE_TYPE	tree[ ARRAY_SIZE ];

/*
** left_child 
**	Compute the subscript of the left child of a node.
*/
static int
left_child( int current )
{
	return current * 2;
}

/*
** right_child
**	Compute the subscript of the right child of a node.
*/
static int
right_child( int current )
{
	return current * 2 + 1;
}

/*
** insert
    算法可以自写  这里：
        如果树为空
            把新值 作为根节点插入
        否则：
            如果新值小于当前节点的值
                把新值插入到当前节点的左子树
            否则：
                把新值插入到当前节点的右子树
*/
void
insert( TREE_TYPE value )
{
	int	current;

	/*
	** Ensure the value is nonzero, because zero indicates an
	** unused node.
	*/
	assert( value != 0 );

	/*
	** Start with the root node.
	*/
	current = 1;

	/*
	** Go to the proper subtree until we reach a leaf.
	*/
	while( tree[ current ] != 0 ){
		/*
		** Go to the left or right subtree, as appropriate.
		** (And make sure we don't have a duplicate value!)
		*/
		if( value < tree[ current ] )
			current = left_child( current );
		else {
			assert( value != tree[ current ] );
			current = right_child( current );
		}
		assert( current < ARRAY_SIZE );
	}
	
	tree[ current ] = value;
}

/*
** find
*/
TREE_TYPE *
find( TREE_TYPE value )
{
	int	current;

	/*
	** Start with the root node.  Until we find the value,
	** go to the proper subtree.
	*/
	current = 1;

	while( current < ARRAY_SIZE && tree[ current ] != value ){
		/*
		** Go to the left or right subtree, as appropriate.
		*/
		if( value < tree[ current ] )
			current = left_child( current );
		else
			current = right_child( current );
	}
	
	if( current < ARRAY_SIZE )
		return tree + current;
	else
		return 0;
}

/*
** do_pre_order_traverse
**	Do one level of a pre-order traverse.  This helper function
**	is needed to save the information of which node we're
**	currently processing; this is not a part of the client's
**	interface
*/
/*
 * callback 这个函数 执行对节点的操作
 */
static void
do_pre_order_traverse( int current,
    void (*callback)( TREE_TYPE value ) )
{
	if( current < ARRAY_SIZE && tree[ current ] != 0 ){
		callback( tree[ current ] );
		do_pre_order_traverse( left_child( current ),
		    callback );
		do_pre_order_traverse( right_child( current ),
		    callback );
	}
}

/*
** pre_order_traverse
*/
void
pre_order_traverse( void (*callback)( TREE_TYPE value ) )
{
	do_pre_order_traverse( 1, callback );
}
