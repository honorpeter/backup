/*
** A program that uses the less error-prone memory allocator.
*/
#include "alloc.h"

void
function()
{
	int	*new_memory;

	/*
	** Get space for a bunch of integers
	*/
	new_memory = MALLOC( 25, int );
	/* ... */
}
int main(int argc, const char *argv[])
{
    function();
    return 0;
}
