set:
        关联容器类，集合中每个元素都是唯一的，自动根据key值排序。
        1.	begin	返回指向set中第一个元素的迭代器
        2.	cbegin	返回指向set中第一个元素的const迭代器
        3.	cend	返回指向set的结尾位置之后位置的const迭代器
        4.	clear	清空set
        5.	count	返回set中指定键对应的元素个数
        6.	crbegin	返回指向set的反方向开始位置的const迭代器
        7.	crend	返回指向set的反方向结尾位置之后位置的const迭代器
        8.	emplace	插入一个元素(不执行copy或move操作)到set
        9.	emplace_hint	插入一个元素(不执行copy或move操作)到set，有位置
        10.	empty	如果set为空，返回true
        11.	end	返回指向set的结尾位置之后位置的迭代器
        12.	equal_range	返回迭代器对，表示指定key的lower_bound和upp
        13.	erase	从set中移除指定位置或范围的数据
        14.	find	返回指向set中指定key的元素位置的迭代器
        15.	get_allocator	返回创建set的Allocator的拷贝
        16.	insert	在set的指定位置插入一或多个元素
        17.	key_comp	返回用于对set的key排序的比较对象的拷贝
        18.	lower_bound返回指向set中大于等于指定key的第一个元素的位置的迭代器
        19.	max_size	返回set的最大长度
        20.	operator=	使用另一个set的拷贝替换set中的元素
        21.	rbegin	返回指向set的反方向开始位置的迭代器
        22.	rend	返回指向set的反方向结尾位置之后位置的迭代器
        23.	size	返回set中的元素个数
        24.	swap	交换两个set中的元素
        25.	upper_bound	返回指向set中大于指定key的第一个元素的位置的迭代器
        26.	value_comp	返回用于对set的元素排序的比较对象的拷贝

            int main()
            {
                set<string> langs;
                vector <string> v;
    
                langs.insert("Perl");
                langs.insert("C++");
                langs.insert("Java");
  
                langs.insert(langs.end(), "Scala");
  
                v.push_back("PHP");
                v.push_back("Java");
                langs.insert(v.begin(), v.end());
  
                for (const auto& p : langs) 
                    cout << "lang : " << p << endl;
                return 0;
            }
                









