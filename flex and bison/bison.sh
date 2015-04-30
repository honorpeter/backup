bison consists of three parts:
        The first:
            Definition Section:
                %{ %} 
                    the is C code copied verbatim to C file
                %code blocks
                    %union  %start  %token  %type  %left  %right %nonassoc

        The second:
            Rules Section:
                
        The third:
            User Subroutines Section:
Command options:
    bison -d        to generate the head file.
                

    Actions:
        
    Embedded Actions:
        can cause shift/reduce or reduce/reduce conflicts
            %%
            thing:
            abcd | abcz ;
            abcd: 'A' 'B' { somefunc(); } 'C' 'D' ;
            abcz: 'A' 'B' 'C' 'Z' ;



when reduced:
            When a pointer reaches the end of a rule, the rule is reduced
            每次读入一个终结符  按着语法规则走  当到达语法规则尾部的时候
                进行归约    压入一个非终结符 看是否进行归约
when conflicts:
            There is a conflict if a rule is reduced when there is more than
                    one pointer
            就是当 归约的时候 有两种规则    则产生冲突
Kinds of Conflicts:

No lookahead:
        reduce/reduce:  example:
            start: x
                |  y
                ;
            x:  A ↑ ;
            y:  A ↑ ; 
       
        shift/reduce:
            start:  x
                |   y R;
            x:  A ↑ R
            y:  A ↑ ;

Lookahead:
    Define exactly when the reduction 
        takes place with respect to token lookahead
            Here is a reduce/reduce conflict:
                start: x B
                    |  y B;
                x:  A ↑ ;
                y:  A ↑;

            But there is no conflict here
                start: x B
                    |  y C;
                x:  A ↑ ;
                y:  A ↑;
            The reason the second example has no conflict is that a bison 
                parser can look ahead
                one token beyond the A
Default:
        first is ok
        Bison resolves shift/reduce conflicts in favor of the shift,

Common Examples of Conflicts:
    
    Expression Grammars:
        expr: TIRMINAL
            | expr '-' expr ;

            (expr - expr) - expr
            which is left associative

            expr - (expr - expr)
            which is right associative.
    IF/THEN/ELSE:
        stmt:   IF '(' cond ')' stmt
            |   IF '(' cond ')' stmt ELSE stmt
            |   TERMINAL;
        coud:   TERMINAL;

            In terms of pointers this is as follows:
                stmt: IF ( cond ) stmt ↑ ;
                stmt: IF ( cond ) stmt ↑ ELSE stmt ;

    Nested List Grammar:
        


          

        













