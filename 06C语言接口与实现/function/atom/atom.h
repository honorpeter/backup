#ifndef ATOM_INCLUDED
#define ATOM_INCLUDED
//头文件 
extern       int   Atom_length(const char *str);
                    //返回 原子参数的长度  str是原子的返回地址
extern const char *Atom_new   (const char *str, int len);
                    //len str的字节数   返回指向 把str添加到原子表中 的地址
                    //从不返回NULL  原子总是 0 字符结尾 必要时添加0字符
extern const char *Atom_string(const char *str);
                    //将以0结尾的字符窜 放到原子表中    返回所在地址
extern const char *Atom_int   (long n);
                    //返回对应于以字符串表示长整数n的原子

#endif
