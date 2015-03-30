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
                

    Actions:
        
    Embedded Actions:
        can cause shift/reduce or reduce/reduce conflicts
            %%
            thing:
            abcd | abcz ;
            abcd: 'A' 'B' { somefunc(); } 'C' 'D' ;
            abcz: 'A' 'B' 'C' 'Z' ;

    Shift/Reduce Conflicts:
        
    Interchanging Precedence:
        













