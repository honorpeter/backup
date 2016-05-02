float *g();
        means the same things as *(g())
        g is a function that returns a pointer to a float

float (*h)();
        declares h to be a pointer to a function returning a float

(void(*)())0   
        pointer to function returning void 
        void(*)()   是个 返回值为 void；  参数为空 （
                        这样些也成   void(*)(void) ）的函数指针
        注意 是个 函数指针   
        然后  把0 强制转换为 这个类型的指针
        然后 取  值   *(void(*)())  
        这个时候   就是   取得了   一个函数指针  类型为  返回值为 
                        void；  参数为空
replace fp by (void(*)())0
    (*(void (*))0)();

((void*)0)
        is a null pointer constant.



Operators don't always have the precedence you want


watch those semicolons:
                1 if(a[i]>bi)   ;
                    big = a[i];
                2 if(n < 2)
                        return 
                    logrec.date = x[0];
                    logrec.time = x[1];
                    logrec.code = x[2];
                3 struct logrec{
                        int date;
                        int time;
                        int code;
                    }
                    main ()
                    {
                    }
the dangling else problem:
        consider followings:
            if(x == 0)
                if(y == 0) error();
            else{       //the else is belong to the second if
                z = x+y;
            }

            The reason is the rule that an else is always associated which
                the closed unmatched if inside the pair of braces.

            
            if(x == 0){
                if(y == 0) error();
            }
            else{       
                z = x+y;
            }
            this can work finely











