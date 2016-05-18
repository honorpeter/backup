stack:
    容器接口类，提供对其他容器的包装接口，仅允许对容器进行stack操作时使用。
        1.	empty	判断stack是否为空
        2.	pop	移除stack中top位置的元素
        3.	push	在stack的top位置加入一个元素
        4.	size	返回stack中的元素个数
        5.	top	返回指向stack中top位置元素的const引用

            int main()
            {
                stack<string> ss;
                
                ss.push("C++");
                ss.push("Perl");
                ss.push("Java");
                
                ss.pop();
                
                const string& lang = ss.top( );
                cout << "ss.top() = "  << lang << endl;
                return 0;
            }
            









