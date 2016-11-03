Algorithms:
    The STL contains many nonmember functions for working with containers
    Algorithm Groups:
            The STL divides the algorithm library into four groups:
                Nonmodifying sequence operations
                Mutating sequence operations
                Sorting and related operations
                Generalized numeric operations

    functions:
        std::min:
        std::max:
                Return the largest
                std::max(3.14,2.73)
                std::max<int>(0, FLAGS_resize_height)
        std::iter_swap:
                Exchange values of objects pointed to by two iterators
                    int myints[]={10,20,30,40,50 };              
                                            //   myints:  10  20  30  40  50
                    std::vector<int> myvector (4,99);            
                                            // myvector:  99  99  99  99

                    std::iter_swap(myints,myvector.begin());     
                                            //   myints: [99] 20  30  40  50
                                            // myvector: [10] 99  99  99

                    std::iter_swap(myints+3,myvector.begin()+2); 

        std::swap:
                Exchange values of two objects
                int x=10, y=20;                              // x:10 y:20
                std::swap(x,y);                              // x:20 y:10

                std::vector<int> foo (4,x), bar (6,y); // foo:4x20 bar:6x10
                std::swap(foo,bar);                    // foo:6x10 bar:4x20

        std::shuffle:
                Randomly rearrange elements in range using generator
                #include <iostream>     // std::cout
                #include <algorithm>    // std::shuffle
                #include <array>        // std::array
                #include <random>       // std::default_random_engine
                #include <chrono>       // std::chrono::system_clock

            int main () {
                std::array<int,5> foo {1,2,3,4,5};

                // obtain a time-based seed:
                unsigned seed = std::chrono::system_clock::now().time_since_epoch().count();

                shuffle (foo.begin(), foo.end(), std::default_random_engine(seed));

                std::cout << "shuffled elements:";
                for (int& x: foo) std::cout << ' ' << x;
                std::cout << '\n';

                return 0;
            }                
                
                









