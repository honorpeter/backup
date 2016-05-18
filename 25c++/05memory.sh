Storage Duration, Scope, and Linkage:
        Automatic storage duration
                Variables declared inside a function definition including 
                    function parameters
        Static storage duration:
                Variables defined outside a function definition or else by 
                    using the keyword static have static storage duration
            Static Duration, External Linkage:
                global variables

                    double warming = 0.3; // warming defined defalut
                    extern double warming; // use warming from another file
                but:
                    static int harry = 300; // static, internal linkage
                                        //other file can't access
            About const:
                In C++ (but not C), a const global variable has internal 
                        linkage by default.
        Thread storage duration (C++11)
                These days multicore processors are common.
                Variables declared with the thread_local keyword
        Dynamic storage duration—Memory
                 allocated by the new operator persists until it is freed 
                 with the delete operator or until the program ends,

                 float * p_fees = new float [20];
                    allocated by new remains in memory until the delete 
                        operator frees it.
        Register Variables:
                register int count_fast; // request for a register variable









