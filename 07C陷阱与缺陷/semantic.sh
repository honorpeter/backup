Pointer and arrays:
    参见 c语言/datatype.sh 
Pointer are not arrays
        char *r;
        strcpy(r,s);
        strcat(r,t);
    it doesn't work  because r doesn't point anywhere.
    Let's try against, allocating some memory for r;
        char r[100];
        strcpy(r,s);
        strcat(r,t);

Array declartions as parameters:
        char hello[]="hello";

        passing that array to a fucntion:
            printf("%s\n",hello);   
        is precisely equivalent to passing the address of its initial
         charcter
            printf("%s\n",&hello[0]);

        And in other words:
            int strlen(char s[]){}

        is precisely equivalent to writing
            int strlen(char *s){}


NULL pointers are not null strings:
        For documentation , this value is often given symbolically:
            #define NULL 0
        when you assigned 0 to a pointer variable , you must not ask what is
            in the memory it addresses. it valid to write:
                if(p == (char *) 0) ...
            but is is not valid to write:
                if(strcmp(p,(char *) 0)==0) ..
            because strcmp always looks at the memory addressed by its
            arguments
    
Counting and asymetric bounds:
        counting ranges of integers:
            17 <= x <= 37       37-17+1
            17 < x <= 37       37-17
            17 <= x < 37       37-17
            17 < x < 37       37-17-1


Order of evaluation:
        it is what gurantees that
            if(count != 0 && sum/count < smallaverage)
                printf("average < %g",smallaverage);
        will not cause "divide by zero " error even if count is zero


        the &&      || operators are important for ensuring that tests 
            are applied in the right sequence



            i = 0;
            while(i < n)
                y[i] = x[i++];
       there is no guarantee that the address of y[i] will be evaluated 
            before i is incremented . On some implementation it will ;
            on others it won't
            this one will work fine:
                i = 0;
                while(i < n){
                    y[i] = x[i];
                    i++;
                }
            
Integer overflow:
        One corrent way of doing test wheater a+b might overflow :
            if((unsigned)a + (unsigned)b > INT_MAX){
                cmplain();
            }












