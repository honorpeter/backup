deque:  双端队列    先进先出
        顺序容器类，象vector，也支持快速在容器最前面插入和删除操作。

        1.	assign	清空deque并复制指定元素到deque
                    deq.assign(3, "c++");  进去3个都是c++
                    deq2.push_back("java"); 进去一个
        2.	at	返回deque中指定位置元素的引用
                    const string& str = deq.at(1);
        3.	back	返回deque中最后一个元素的引用
                    const string& str = deq.back();
        4.	begin	返回指向deque开始位置的迭代器
        5.	cbegin	返回指向deque开始位置的const迭代器
        6.	cend	返回指向deque结尾之后位置的const迭代器
        7.	clear	清除deque中所有的元素
        8.	crbegin	返回指向deque反方向开始位置的const迭代器
        9.	crend	返回指向deque反方向结尾之后位置的const迭代器
        10.	emplace	在deque的指定位置插入一个元素
        11.	emplace_back	在deque的最后面插入一个元素
        12.	emplace_front	在deque的最前面插入一个元素
        13.	empty	判断deque是否为空
        14.	end	返回指向deque结尾之后位置的迭代器
        15.	erase	从deque中移除指定位置或范围的元素
        16.	front	返回deque中第一个元素的引用
        17.	get_allocator	返回创建deque的Allocator的拷贝
            deque<string> deq;
            deque<string>::allocator_type allocator = deq.get_allocator( );
            cout << allocator.max_size() << endl;
  
        18.	insert	在deque中插入元素
              deq.insert(deq.begin(), "C++");
        19.	max_size	返回deque的最大size
        20.	operator=	使用另一个deque中的元素替换deque中的元素
                    deq2 = deq;
        21.	operator[]	返回deque中指定位置元素的引用
        22.	pop_back	移除deque中最后一个元素
        23.	pop_front	移除deque中第一个元素
        24.	push_back	在deque的最后增加一个元素
        25.	push_front	在deque的最前面增加一个元素
        26.	rbegin	返回指向deque反方向开始位置的迭代器
        27.	rend	返回指向deque反方向结尾之后位置的迭代器
        28.	resize	更改deque的大小(size)
            deq.push_back("C++");
            deq.resize(6, "0");
    
        29.	shrink_to_fit	更改deque的容量为deque的长度
        30.	size	得到deque的大小
        31.	swap	交换两个deque的元素








