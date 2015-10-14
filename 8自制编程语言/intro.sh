Flex
    
    Attention:
        if two patterns match the same thing, it prefers the pattern that ap
            pears first in the flex program

        When you input the word by the stdin to the flex 
            pressing ctrl + d marks end
                flex count.l
                gcc lex.yy.l -lfl
    Sections:
        Consists of three sections: separated by %% lines
            The first:
                declarations and option settings.
                    C code inside of %{ and %}
            The second:
                patterns and actions,
                    each pattern is at the beginning of the line , followed 
                    by the C code to execute
                        the variable yytext is set to point to the
                        input text that the pattern just matched
            The third:
                C code that is copied to the generated scanner 

                yylex() :
                    execute the scanning
                    and return the values.
        Tokens and Values:
            scanner returns a stream of tokens, each token actually has 
                two parts, the token and the token’s value.

            The token is a small integer
                token 0 means end-of-file   Other is arbitrary
                    but define it by hand in first section
                        please see: define.l


Bison:
        three-part structure:
            Declarations:
                C parser enclosed in %{ and %} .    
                %token token declarations
                    telling bison the names of the symbols in
                    the parser that are tokens.
            Rules: 
                the rules in simplified BNF

            C code:
           














