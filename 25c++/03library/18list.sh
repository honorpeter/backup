list:
        顺序容器类，是一个双向链表，允许高效插入和删除容器中任何位置的元素。
        1.	assign	给list赋值
        2.	back	返回list中最后一个数据的引用
        3.	begin	返回指向list开始位置的迭代器
        4.	cbegin	返回指向list开始位置的const迭代器
        5.	cend	返回指向list结尾之后位置的const迭代器
        6.	clear	移除list中的所有数据
        7.	crbegin	返回指向list反方向开始位置的const迭代器
        8.	crend	返回指向list反方向结尾之后位置的const迭代器
        9.	emplace	在list的指定位置插入一个数据
        10.	emplace_back	在list的最后面插入一个数据
        11.	emplace_front	在list的最前面插入一个数据
        12.	empty	判断list是否为空
        13.	end	返回指向list结尾之后位置的迭代器
        14.	erase	从list中移除指定位置或范围的数据
        15.	front	返回list中第一个数据的引用
        16.	get_allocator	返回创建list的Allocator的拷贝
        17.	insert	在list中插入数据
        18.	max_size	返回list的最大size
        19.	merge	合并两个list并排序
        20.	operator=	用另一个list的数据替换list的数据
        21.	pop_back	移除list中的最后一个数据
        22.	pop_front	移除list的第一个数据
        23.	push_back	在list的最后增加一个数据
        24.	push_front	在list的最前面插入数据
        25.	rbegin	返回指向list反方向开始位置的反向迭代器
        26.	remove	从list中移除指定数据
        27.	remove_if	从list中移除符合条件的数据
        28.	rend	返回指向list反方向结尾之后位置的反向迭代器
        29.	resize	更改list的大小(size)
        30.	reverse	反转list中的数据
        31.	size	返回list的大小
        32.	sort	对list中的数据排序
        33.	splice	删除另一个list的数据插入到list的指定位置
        34.	swap	交换两个list的数据
        35.	unique	移除list中的重复数据

                list<string> slist;
                list<string> slist2;
                list<string>::iterator itor;
    
                slist.assign(3, "c++");
                for (itor = slist.begin(); itor != slist.end(); ++itor) {
                    cout << "slist value = "  << *itor << endl;
                } 
    









