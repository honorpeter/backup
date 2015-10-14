Read from the file:
        yyin = fopen(argv[1], "r")

        When a lex scanner reached the end of yyin , it called yywrap() .
            yywrap could adjust yyin and return 0 to resume scanning.
            If that was really the end of the input, it returned 1

        %option noyywrap        at the top of your scanner to tell
                                :it not to call yywrap
        %option noyywrap nodefault yylineno case-insensitive
Input:
    The three levels of input management:
        Setting yyin to read the desired file(s)
            for(i = 1; i < argc; i++) {
                FILE *f = fopen(argv[i], "r");
                if(!f) {
                perror(argv[i]);
                return (1);
                }
                yyrestart(f);
                yylex();
                fclose(f);
                printf("%8d%8d%8d %s\n",lines, words, chars, argv[i]);
            }
                uses yyrestart() to make it the input to the scanner, and
                    calls yylex() to scan it
        Creating and using YY_BUFFER_STATE input buffers
        Redefining YY_INPUT

Flex Scanner Output:
        

Start States and Nested Input Files:
    %x marks IFILE as an exclusive start state 
    Start states declared with %s , 
            in which patterns not marked with any state
            详见：/example/fb2-3.l  包含多重文件夹

Command options:
    flex -o hh.c   hh.l         specify the file name which is created

The Flex Library:
    Define:
        default version of yywrap
Options:
        %option noyywrap
            it not to call yywrap
            
