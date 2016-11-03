预处理：
        
Space matter in macro definitions:
        #define f (x)   ((x)-1)
            perhaps:    f(x)    represents
                        ((x)-1)
            or perhaps f represents:
                        (x) ((x)-1)

            In this case the latter answer is correct because there is a 
                space between f and the last definition above 


Macros  are not functions:
           For instance, suppose abs had been defined this way:
                #define abs(x)  x>0?x:-x
            and imagine the result of evaluating abs(a-b). The expression
                a-b>0?a-b:-a-b
            which gives the wrong answer    -a-b    should be -(a-b)
                ab(a) + 1
            would expand into
                a>0?a:-a+1
            which is clearly wrong  Defining abs correctly:
                    #define abs(x)      ((x)>0?(x):-(x))
        if the abs is a function that will be ok
            ......

            #define toupper (c) \
                ((c)>='a' && (c) <= 'z'? (c)+('A'-'a')):(c)
            it will be surprise anyone who tries to use toupper(*p++)
                    it will always p++


Macros are not statements:
            #define assert(e)   if(!e) assert_error(__FILE__,__LINE__)
        if(x > 0 && y > 0)
            assert(x>y);
        else
            assert(y>x);
        expands into somethings like this:
            if(x > 0 && y > 0)
                if(!(x>y))
                    assert_error("foo.c",37);
                else
                    if(!(y>x))
                        assert_error("foo.c",39);

        it's wrong
        it is possible to avoid this proble by eclosing the body of the 
            assert macro in braces

            #define assert(e)   {if(!e) assert_error(__FILE__,__LINE__)};
                This raises a new problem you can expand it

        The right way to define assert is far from obvious: make the body
            of assert look like an expression and not a statement:
                #define assert(e)   \
                    ((void)((e)||_assert_error(__FILE__,__LINE__)))

Macros are not type definitions:
        it just replace . typedef is working better















