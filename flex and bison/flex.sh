Read from the file:
        yyin = fopen(argv[1], "r")

        When a lex scanner reached the end of yyin , it called yywrap() .
Reading Several Files:
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

The I/O Structure of a Flex Scanner:
        Input to a Flex Scanner:

The Flex Library:
    Define:
        default version of yywrap
Options:
        %option noyywrap
            it not to call yywrap
            















