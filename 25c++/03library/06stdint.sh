This header defines a set of integral type aliases with specific width 
        requirements, along with macros specifying their limits and macro 
        functions to create values of these types.
        <stdint.h>

    Types:
        intmax_t	uintmax_t	
                        Integer type with the maximum width supported.
        int8_t	uint8_t	
        int16_t	uint16_t
        int32_t	uint32_t
        int64_t	uint64_t
                 Integer type with a width of exactly 8, 16, 32, or 64 bits.
        int_least8_t	uint_least8_t	
        int_least16_t	uint_least16_t
        int_least32_t	uint_least32_t
        int_least64_t	uint_least64_t
                Integer type with a minimum of 8, 16, 32, or 64 bits.
        int_fast8_t	uint_fast8_t	
        int_fast16_t	uint_fast16_t
        int_fast32_t	uint_fast32_t
        int_fast64_t	uint_fast64_t
                Integer type with a minimum of 8, 16, 32, or 64 bits.
        intptr_t	uintptr_t	
                Integer type capable of holding a value converted from a 
                void pointer and then be converted back to that type with 
                a value that compares equal to the original pointer.
        
    Macros:
        INTMAX_MIN	Minimum value of intmax_t  
        INTMAX_MAX	Maximum value of intmax_t	
        UINTMAX_MAX	Maximum value of uintmax_t	
        INTN_MIN	Minimum value of exact-width signed type 
        INTN_MAX	Maximum value of exact-width signed type 
        UINTN_MAX	Maximum value of exact-width unsigned type
        INT_LEASTN_MIN	Minimum value of minimum-width signed type
        INT_LEASTN_MAX	Maximum value of minimum-width signed type
        UINT_LEASTN_MAX	Maximum value of minimum-width unsigned type
        INT_FASTN_MIN	Minimum value of fastest minimum-width signed type
        INT_FASTN_MAX	Maximum value of fastest minimum-width signed type
        UINT_FASTN_MAX	Maximum value of fastest minimum-width unsigned type
        INTPTR_MIN	Minimum value of intptr_t  
        INTPTR_MAX	Maximum value of intptr_t  
        UINTPTR_MAX	Maximum value of uintptr_t 

    Limits of other types
        SIZE_MAX	Maximum value of size_t	264-1, or higher
        PTRDIFF_MIN	Minimum value of ptrdiff_t	-(216-1), or lower
        PTRDIFF_MAX	Maximum value of ptrdiff_t	216-1, or higher
        SIG_ATOMIC_MIN	Minimum value of sig_atomic_t  

        .....
    Function-like macros:
        INTMAX_C	expands to a value of type intmax_t
        UINTMAX_C	expands to a value of type uintmax_t
        INTN_C	expands to a value of type int_leastN_t
        UINTN_C	expands to a value of type uint_leastN_t

            INTMAX_C(2012)  // expands to 2012LL or similar 
        




































