Utility:
        定义重载的关系运算符，简化关系运算符的写入，它还定义了pair类型，
            该类型是一种模板类型，可以存储一对值。这些功能在库的其他地方使用
        header:<utility>

        namespace std
        类： pair

        functions:
            swap     Exchange values of two objects 
                    // swap algorithm example (C++11)
                #include <iostream>     // std::cout
                #include <utility>      // std::swap

                int main () {
                
                int x=10, y=20;                  // x:10 y:20
                std::swap(x,y);                  // x:20 y:10
                
                int foo[4];                      // foo: ?  ?  ?  ?
                int bar[] = {10,20,30,40};//foo: ?  ?  ?  ? bar: 10 20 30 40
                std::swap(foo,bar);   // foo: 10 20 30 40   bar: ?  ?  ?  ?

                std::cout << "foo contains:";
                for (int i: foo) std::cout << ' ' << i;
                std::cout << '\n';

                return 0;
            }
            make_pair Construct pair object 
                // make_pair example
                #include <utility>      // std::pair
                #include <iostream>     // std::cout

                int main () {
                    std::pair <int,int> foo;
                    std::pair <int,int> bar;

                    foo = std::make_pair (10,20);
                    bar = std::make_pair (10.5,'A'); 

                    std::cout << "foo: " << foo.first << ", " << foo.second << '\n';
                    std::cout << "bar: " << bar.first << ", " << bar.second << '\n';

                return 0;
            }
                output:
                    foo: 10, 20
                    bar: 10, 65
            forward   Forward argument 
            move     Move as rvalue 
            move_if_noexcept   Move if noexcept (function template )
            declval       Declaration value (function template )









