/*
#ifndef STACK_INCLUDE
#define STACK_INCLUDE

typedef struct Stack_T *stack_T;

extern Stack_T Stack_new(void);
extern int Stack_empty(Stack_T stk);
extern void Stack_push(Stack_T stk, void *x);
extern void *Stack_pop(Stack_T stk);
extern void Stack_free(Stack_T *stk);

#endif
*/

#ifndef STACK_INCLUDE
#define STACK_INCLUDE

#define T Stack_T
typedef struct T *T;

extern T    Stack_new(void);
extern int  Stack_empty(T stk);
extern void Stack_push(T stk, void *x);
extern void *Stack_pop(T stk);
extern void Stack_free(T *stk);

#undef T
#endif
