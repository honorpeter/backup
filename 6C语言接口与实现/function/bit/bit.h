#ifndef BIT_INCLUDED
#define BIT_INCLUDED

#define T Bit_T
typedef struct T *T;

/*
 * 创建一个包含length个比特 的新向量    并将所有比特为都设置为0
 * 该向量表示了从0 到 length-1的所有整数    传递负的length值 是一个已检查的
 * 运行错误
 */
extern  T       Bit_new(int length);
/*
 * 返回set中的比特位数
 */
extern  int     Bit_length(T set);
/*
 * 返回set中1的数目 即置位的比特数
 */
extern  int     Bit_count(T set);

/*
 * 释放*set and make set = null
 */
extern  void    Bit_free(T *set);

//集合中的 单个比特的操作
/*
 * 返回比特位n  
 */
extern  int     Bit_get(T set, int n);
/*
 * 将比特位n设置为bit 并返回原来的
 */
extern  int     Bit_put     (T set, int n, int bit);

//操作集合中连续的比特序列
/*
 * 将有所lo到hi的比特位清零     包括边界
 */
extern  void    Bit_clear   (T set, int lo, int hi);
extern  void    Bit_set     (T set, int lo, int hi);
/*
 * lo到hi取反
 */
extern  void    Bit_not     (T set, int lo, int hi);

//集合之间的 包含与被包含之间的关系
extern  int     Bit_lt      (T s,   T t);
extern  int     Bit_eq      (T s,   T t);
extern  int     Bit_leq     (T s,   T t);

//遍历每个比特位
extern  void    Bit_map     (T set, void apply(int n, int bit, void *cl
            ), void *cl);

//集合之间的取集合之间的关系
extern  T       Bit_union   (T s,   T t);
//返回交集
extern  T       Bit_inter   (T s,   T t);
extern  T       Bit_minus   (T s,   T t);
extern  T       Bit_diff    (T s,   T t);

#undef T
#endif 








