#undef assert
#ifdef NDEBUG       // 如果定义了 NDEBUG 就关闭断言
#define assert(e) ((void)0)     //这个函数什么都没有代表关闭
#else
#include "except.h"
extern void assert(int e);      //将断言 改变为了 异常
                                //如果传入 assert的值为 false那么触发异常
#define assert(e) ((void)((e)||(RAISE(Assert_Failed),0)))
#endif
