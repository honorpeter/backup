#include<stdio.h>
//函数原型的声明
//使用转移表    当设计一个微型的计算器的时候  使用 switch 每种情况
//对应一个函数 但使用转移变可以方面了
double add(double ,double);
double sub(double ,double);
double mul(double ,double);
double div(double ,double);
    .
    .
    .
//函数指针的初始化
double (*oper_func[])(double, double)={
    add,sub,mul,div........
};

resutl = oper_func[oper](col1,col2);
//oper表示 + - * /的代号 1 2 3 4 。。。。
//要防止 非法访问
