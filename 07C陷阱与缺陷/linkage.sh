Declartions vs definitions
        int a;
                it will allocates storage for it the value is 0
        int a = 6;
                it allocate memory for a  the value is 6
        extern int a;
                will not allocate memory

Name conflicts and the static modifier
        if a function f calls function g  and only  f needs to be able to
            call g ,we can put f and g in the same file and make g static

Arguments parameters    and return values
        int i;
        char c;

        for(i = 0; i < 5; i++){
            scanf("%d",&c);//这里有毛病
            printf("%d",i);
        }
        printf(" \n");
        return 0;

        无限循环下去        因为每次的scanf会 刷新i的内存 因为c为一个字节

Checking extern types:
        One file contains the declartion:
            extern int n;
        and the other contains the definition:
            long n;

        This ia not a valid C program because the same external name is 
            declared with two differnt types in the two files.
            however many implementations will fail to detect this error
            the compiler handles each of these file separately
            The linker probably doesn't know anything about C so it doesn't
            how to compare the types of the two definition of n

            char filename[]="/etc/paswd";
                    this filename doesn't have memory like a variable name
                    /etc/paswd\0

            extern char *filename;
                    but filename have memory

Header files:
        头文件 不应该被重复包含     因为 会出现 多次定义某个变量
            











