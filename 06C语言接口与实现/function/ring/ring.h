#ifndef RING_INCLUDED
#define RING_INCLUDED

#define T Ring_T
typedef struct T *T;

/*
 * create a NULL ring
 */
extern  T   Ring_new(void);
/*
 * end with NULL pointer
 * like:
 *      Ring_T names;
 *      names = Ring_ring("Lists","Table",NULL);
 */
extern  T   Ring_ring(void *x, ...);

/*
 * 如果 ring 或  *ring是空指针 已检查的运行错误
 */
extern  void    Ring_free(T *ring);
extern  int     Ring_length(T ring);

extern  void    *Ring_get(T ring, int i);
/*
 * 将第i个值改为x
 */
extern  void    *Ring_put(T ring, int i, void *x);

/* 
 * 将x的值添加到ring中的pos位置 并返回x
 */
extern  void    *Ring_add(T ring, int pos, void *x);

/*
 * 等效于 Ring_add(ring,1,x);
 */
extern  void    *Ring_addlo(T ring, void *x);
// Ring_add(ring, 0, x);
extern  void    *Ring_addhi(T ring, void *x);

/*
 * 删除i的值    返回这个值 将其右侧的值 减一
 */
extern  void    *Ring_remove(T ring, int i);

//equal Ring_remove(ring, 0);
extern  void    *Ring_remlo(T ring);
extern  void    *Ring_remhi(T ring);

/*
 * 如果n为正值 ring将向右选装n个值 各个值的索引加n然后堆ring的长度取摸
 * 如果n为负值， you know
 */
extern  void    Ring_rotate(T ring, int n);




#undef T
#endif 





