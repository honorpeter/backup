数组array与vector的比较:
        array 定义的时候必须定义数组的元素个数;而vector 不需要；且只能包含
            整型字面值常量，枚举常量或者用常量表达式初始化的整型const对象，
            非const变量以及需要到运行阶段才知道其值的const变量都不能用来定
            义数组的维度.
        array 定义后的空间是固定的了，不能改变；而vector 要灵活得多，
            可再加或减.
        vector有一系列的函数操作，非常方便使用.和vector不同，数组不提供 
            push——back或者其他的操作在数组中添加新元素，数组一经定义就不允
            许添加新元素； 若需要则要充许分配新的内存空间，再将员数组的元
            素赋值到新的内存空间。 数组和vector不同，一个数组不能用另一个
            数组初始化，也不能将一个数组赋值给另一个数组；

    std.array:
            1.	at	返回array中指定位置数据的引用
                    声明的时候指定 几个
                        array<string, 5> arr = {"C++", "Java", "PHP"};
                        string& lang = arr.at(2);
                        cout << "arr.at() = " << lang << endl;
            2.	back	返回array中最后一个数据的引用，array不能为空
            3.	begin	返回指向array开始位置的迭代器
                    array<string, 5> arr = {"C++", "Java", "PHP", "Lisp", "Ruby"};
                    array<string, 5>::iterator itor = arr.begin();
                    string lang = *itor;
                    cout << "arr.begin() = " << lang << endl;
            4.	cbegin	返回指向array开始位置的const迭代器
            5.	cend	返回指向array结尾之后位置的const迭代器
            6.	crbegin	返回指向array反方向开始位置的const迭代器
            7.	crend	返回指向array反方向结尾之后位置的const迭代器
            8.	data	返回指向array中第一个数据的指针
            9.	empty	判断array是否为空
                    空为1 非空为0
            10.	end	返回指向array结尾之后位置的迭代器
            11.	fill	清空array并复制指定数据到array
                        array<string, 2> arr = {"C++", "Java"};
                        arr.fill("Haskell");
                        都变为 Haskell
            12.	front	返回array中第一个数据的引用
            13.	max_size	返回array的数据个数
            14.	operator[]	返回array中指定位置数据的引用
                    下标访问
            15.	rbegin	返回指向array反方向开始位置的迭代器
            16.	rend	返回指向array反方向结尾之后位置的迭代器
            17.	size	返回array的数据个数
            18.	swap	交换两个array的数据
                array<string, 5> arr = {"C++", "Java", "PHP", "Lisp", "Ruby"};
                array<string, 5> arr2 = {"Oracle", "SQLServer"};
                arr.swap(arr2);
                    









