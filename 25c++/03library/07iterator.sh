#include <iterator>  :
        迭代器类型:
            Input iterator、Output iterator、Forward iterator、
                Bidirectional iterator、Random access iterator。
            Input（输入）迭代器:
                读取    

        function: Iterator operations
            advance Advance iterator (function template )
            distance Return distance between iterators (function template )
                std::list<int> mylist;
                for (int i=0; i<10; i++) mylist.push_back (i*10);
                std::list<int>::iterator first = mylist.begin();
                std::list<int>::iterator last = mylist.end();

                std::cout << "The distance is: " << std::distance(first,
                                last) << '\n';
            begin Iterator to beginning (function template )
            end Iterator to end (function template )
            prev Get iterator to previous element (function template )
            next Get iterator to next element (function template )
        class:
            std::iterator_traits
            class template  Traits class defining properties of iterators.

                #include <iostream>     // std::cout
                #include <iterator>     // std::iterator_traits
                #include <typeinfo>     // typeid
                int main() {
                    typedef std::iterator_traits<int*> traits;
                    if (typeid(traits::iterator_category)==
                            typeid(std::random_access_iterator_tag))
                    std::cout << "int* is a random-access iterator";
                    return 0;
                }
            member:
                


        Iterator generators
            back_inserter 
                Construct back insert iterator (function template )
                front_inserter Constructs front insert iterator 
                        (function template )
                inserter Construct insert iterator (function template )
                make_move_iterator Construct move iterator 
                        (function template )
                    std::vector<int> foo,bar;
                    for (int i=1; i<=5; i++)
                    { foo.push_back(i); bar.push_back(i*10); }
                    
                    std::copy (bar.begin(),bar.end(),back_inserter(foo));

                    std::cout << "foo contains:";
                    for ( std::vector<int>::iterator it = foo.begin(); it!= foo.end(); ++it )
	                    std::cout << ' ' << *it;
                    std::cout << '\n';

                    foo contains: 1 2 3 4 5 10 20 30 40 50


            









