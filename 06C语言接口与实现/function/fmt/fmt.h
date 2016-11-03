#ifndef FMT_INCLUDED
#define FMT_INCLUDED
#include<stdarg.h>    
#include<stdio.h>
#include "except.h"

#define T Fmt_T
typedef void (*T)(int code, va_list *app,
                int put(int c,void *cl), void *cl,
                unsigned char flags[256], int width, int precision);

extern  char    *Fmt_flags;
extern  const    Except_T Fmt_Overflow;


/*
 * 按照第三个参数fmt给出的格式串来格式化 其第四个和后序参数
 * 并调用 put来输出每个格式化完毕的字符c    c当做unsigned char 处理
 */
extern  void    Fmt_fmt(int put(int c, void *cl), void *cl,
                        const char *fmt, ...);

extern  void    Fmt_vfmt(int put(int c, void *cl), void *cl,
                        const char *fmt, va_list ap);
#undef T        //因为这个是包含在其他的文件之中的 所以需要取消定义
                //宏的定义域为整个文件


#endif 
