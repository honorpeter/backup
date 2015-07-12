#ifndef TABLE_INCLUDED
#define TABLE_INCLUDED

#define T Table_T
typedef struct T *T;

/*  hint 用于估计 新的表中预期会容纳的表象数目  无论hint值为何 所有的表可以
 *  容纳任意数目的表项 但准确的hint值可以提高性能
 * hint 未负值 是一个已检查的运行错误
 * 每个表都可以有自身的hash和cmp函数
 * 如果hash是NULL函数指针 那么假定新表中的键是原子
 * cmp用于比较键值是否相等的函数
 */
extern T        Table_new(int hint,
                            int cmp(const void *x, const void *y),
                            unsigned hash(const void *key));

extern void     Table_free(T *table);
//返回表中键的数目
extern int      Table_length(T table);
//添加一对 键值对
extern void *   Table_put(T table, const void *key, void *value);
//取得键值
extern void *   Table_get(T table , const void *key);
//移出
extern void *   Table_remove(T table, const void *key);

//以未指定的顺序 对table中的每个键值对 调用apply指向的函数
extern void     Table _map(T table, 
                        void apply(const void *key,void **value, void *cl ),
                        void *cl);
extern void **  Table_toArray(T table,void *end);

static void vfree(const void *key, void **value,
        void *cl)
{
    FREE(*value);
}


#undef T
#endif











