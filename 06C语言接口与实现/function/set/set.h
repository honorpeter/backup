#ifndef SET_INCLUDED
#define SET_INCLUDED

#define T Set_T
typedef struct T *T;

//分配初始化　并返回一个新的Ｔ实例
//hint 预计多少。。
extern T    Set_new(int hint, int cmp(const void *x, const void *y),
                    unsigned hash(const void *x));
//释放*set指针　并将其赋值为 NULL
//并不释放集合中的成员  该工作可以通过set_map（）函数完成
extern void Set_free(T *set);

//返回成员的数目
extern int  Set_length(T set);
//如果member在接合中返回1 否则返回0
extern int  Set_member(T set,const void *member);
//添加到集合中
extern void Set_put(T set, const void *member);
//移除成员
extern void *Set_remove(T set, const void *member);
extern void Set_map(T set, void apply(const void *member,void *cl),
                    void *cl);
extern void **Set_toArray(T set, void *end);

/* 
 * s和t必须指定相同的比较函数和hash函数
 * 返回一个副本
 */
// 返回s+t
extern T    Set_union(T s, T t);
//  返回 s*t
extern T    Set_inter(T s, T t);
//返回 s-t
extern T    Set_minus(T s, T t);
// 返回 s / t
extern T    Set_diff(T s, T t);
#undef T
#endif









