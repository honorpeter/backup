= is not ==
    c uses = to assignment and uses == for comparison
    
    instead of 
        if(x == y)
                foo();  
    write:
        if((x = y) != 0)
                foo();
        This will help make your intensions plain

& and ! are not && or ||

Greedy lexical analysis:
    tokens:
        one character long:
            + - / * .....
        several characters long:
            /*  ++ .....
    when a C compiler encounters a / followed by an * , it must be able to
        decide whether to treat these two characters as two separate tokens
        or as one token
        C resolves this with a simple rule:
            repeatly bite off the biggset possible piece

        for instance:
            a---b
        means:
            a -- - b
        rather than:
            a - --b

        y = x/*p;   //in fact  /* begins a commment 
                        the compiler will simply gobble program text until
                        the */ appears
        the rigth way:
            y = x / *p;     //p points at the divisor

        compiler treats 
            a=-1;
        as meaning
            a =- 1;
        not 
            a = -1;
Integer constants
        If the first character is the digit 0 , that constant is token to 
            be in octal

Strings and characters
    single and quotes mean very different things in C
    
    A character enclosed in single quotes is a integer
    A string enclosed int double quotes is a pointer

        















