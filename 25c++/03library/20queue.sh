queue:
        容器接口类，提供对其他容器的包装接口，提供对前后两端元素的有限制访
                问，可在back增加元素和在front移除元素。
        1.	back	返回指向queue中最后一个元素的引用
        2.	empty	判断queue是否为空
        3.	front	返回指向queue最前面的第一个元素的引用
        4.	pop	移除queue中最前面的第一个元素
        5.	push	在queue的最后面加入一个元素
        6.	size	返回queue中的元素个数
            int main()
            {
                queue<string> que;
            
                que.push("Java");
                que.push("C++");
                que.push("Perl");
    
                const string& lang = que.back( );
                cout << "que.back() = "  << lang << endl;
                return 0;
            }
        









