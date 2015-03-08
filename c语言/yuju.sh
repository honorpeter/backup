循环语句：
    for
    while
    do  while

条件语句：
    if
    switch

其他语句
    break           只能退出一层循环
    continue        也是只能退出一层循环
    return 
    空语句
    goto语句

退出多层循环：
    1 使用 goto
        while(condition){
            while(condition){
                while(condition){
                    if(some disater) {
                        goto:quit;
                    }
                }
            }
        }
        quit: ;
    2 把所有循环放在一个函数中 可以使用 return语句离开这个函数
