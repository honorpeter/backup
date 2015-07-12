#ifndef SEQ_INCLUDED
#define SEQ_INCLUDED

#define T Seq_T
typedef struct T *T;

//创建并返回一个空序列  hint是对新序列将包含值的最大数目的估计  如果该值
//未知 可以用0
extern T Seq_new(int hint);
/*
 * 创建并返回一个序列 用函数的非NULL指针参数 来初始化序列中的值 参数列表结束
 * 于一个NULL指针参数
 * Seq_T names;
 * names = Seq_seq("c","ML","c++","Icon",NULL);
 */
extern T Seq_seq(void *x, ...);
/* 
 * 释放序列*seq 并将*seq清零
 * 如果seq *seq为空指针 造成已检查的运行错误
 */
extern void Seq_free(T *seq);

extern int Seq_length(T *seq);

/*
 * 返回seq中第i个值
 */
extern void *Seq_get(T seq, int i);
/*
 * 将第i个值改为x 并返回先前的值    i大于等于N 已检查的运行错误
 */
extern void *Seq_put(T seq, int i, void *x); 
/*
 * 将x添加到 seq的低端并返回x
 * 并将所有现存值 索引都加1 长度加1 
 */
extern void *Seq_addlo(T seq, void *x);
/*
 * 将x添加到 seq的高端并返回x 长度加1 
 */
extern void *Seq_addhi(T seq, void *x);

/*
 * 删除并返回seq低端的值    将其余所有值的索引都减1
 */
extern void *Seq_remlo(T seq);
/*
 * 长度减1 去掉最后一位 返回
 */
extern void *Seq_remhi(T seq);
#undef T
#endif 
