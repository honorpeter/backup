Are characters signed or unsigned?
        when acompiler converting a char to an int has a choice: should
            it treat the char as a signed or an unsigned ?
            if the former it should expand the char to an int by replicating
                the sign bit; if the latter it should fill the extra bit
                positions with zeroes
                you had better decleration it unsigned char

Shift operators:
        if the item being shifted is n bits long, then the shift count must
            be greater than or equal to zero and strictly less than n
        For example  if an int is 32bits    and n is an int ,it is legal to
            write n<<31 and n<<0    but not n<<32 ro n<<-1

        Note that a right shift of a signed integer is generally not 
            equivalent to division by a power of two
            (-1) >> 1 != -1/2=0

Memory location zero:
        A null pointer does not point to any object. Thus it is ellegal to
            use a null pointer for nay purposes other than assignment and 
            comparison

        What actually happens in this case varies from one C implementation
            to another. Some implementations impose hardware read pretection
            on location 0   Other implementations allow location 0 to be
            read but not written. Other implementations allow location 0 to
            be read and written. Misusing a null pointer on such an 
            implementation may well overwrite part of the systerm causing
            complete mayhem

How does division truncate:
            q = a / b;
            r = a % b;
        a maybe be negative
        when you use hash table you had better declare n as unsigned
How big is a random number?
        rand function
        1. between 0 and 2power32 -1
        2. between 0 and 2power15

        ANSI C defines a constant RAND_MAX equal to the largest random 
        number















