/*约瑟夫问题： 所有人占成一个圈 然后按顺序数数 每数到第5的人出局 
                        直到剩下一个人
*
* 输入 两个数 多少个人  查几个删除一个
*/
        
#include<stdio.h>
#include<stdlib.h>    

struct node{
    int item;
    struct node *next;
};

int main(int argc, const char *argv[])
{
    int i, N = atoi(argv[1]), M = atoi(argv[2]);

    struct node *t = malloc(sizeof(*t)), *x = t;
    t -> item = 1; t->next = t;

    for (i = 2; i <= N; i++) {
        x = (x->next = malloc(sizeof*x));
        x-> item =i;
        x->next =t;
    }

    while(x != x->next){
        for (i = 1; i < M; i++) {
            x = x->next;
        }
        x ->next = x->next ->next;
        N--;
    }
    printf("%d\n",x->item);
    return 0;
}











