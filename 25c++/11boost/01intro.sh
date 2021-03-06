安装：
        快捷安装：
            编译release版本的库文件
            ./bootstrap.sh
            sudo ./b2 install
                默认安装到 /usr/local/include   lib
        完全安装：
            完全编译 安装所有调试版 发行版的静态 和 动态库
            。。。。
            sudo ./b2 --buildtype=complete install
        定制安装：
            ...
            sudo ./b2 --show-libraries

            ./b2 --with-date_time --buildtype=complete install
                    只安装date_time库
                    ....


C++ Boost库简介:
        boost是一个准标准库，相当于STL的延续和扩充，它的设计理念和STL比较
            接近，都是利用泛型让复用达到最大化。不过对比STL，boost更加实用。
            STL集中在算法部分，而boost包含了不少工具类，可以完成比较具体的
            工作。
        boost主要包含一下几个大类：
            字符串及文本处理、容器、迭代子(Iterator)、算法、函数对象和
            高阶编程、泛型编程、模板元编程、预处理元编程、并发编程、
            数学相关、纠错和测试、数据结构、输入/输出、跨语言支持、
            内存相关、语法分析、杂项。 有一些库是跨类别包含的，
            就是既属于这个类别又属于那个类别。
        在文本处理部分，conversion/lexcial_cast类用于“用C++”的方法实现数字
            类型和字符串之间的转换。 主要是替代C标准库中的 atoi、 itoa之
            类的函数。当然其中一个最大的好处就是支持泛型了。
        format库提供了对流的“printf-like”功能。printf里使用%d、%s等等
            的参数做替换的方法在很多情况下还是非常方便的，STL的iostream
            则缺乏这样的功能。format为stream增加了这个功能，并且功能比原始
            的printf更强。
        regex，这个不多说了，正则表达式库。如果需要做字符串分析的人就会理
            解正则表达式有多么有用了。
        spirit，这个是做LL分析的框架，可以根据EBNF规则对文件进行分析。
            做编译器的可能会用到。一般人不太用的到。
        tokenizer库。我以前经常在CSDN上看到有人问怎么把一个字符串按逗号
            分割成字符串数组。也许有些人很羡慕VB的split函数。现在，
            boost的tokenizer也有相同的功能了，如果我没记错的话，这个
            tokenizer还支持正则表达式，是不是很爽？
        array: 提供了常量大小的数组的一个包装，喜欢用数组但是苦恼数组定位
            确定数组大小等功能的人这下开心了。
        dynamic_bitset，动态分配大小的bitset，我们知道STL里有个bitset，
            为位运算提供了不少方便。可惜它的大小需要在编译期指定。
        graph。提供了图的容器和相关算法。
        multi_array提供了对多维数组的封装，应该还是比较有用的。
        并发编程里只有一个库，thread，提供了一个可移植的线程库，不过在
            Windows平台上我感觉用处不大。因为它是基于Posix线程的，在
            Windows里对Posix的支持不是很好。
        数学和数值 类里，包含了很多数值处理方面的类库 比如rational分数类，
            random随机数类，等等。
        static_assert，提供了编译器的assert功能。
        test库，一个单元测试框架，非常不错。
        concept_check提供了泛型编程时，对泛型量的一点检查，不是很完善，
            不过比没有好。
        数据类型类any，一个安全的可以包含不同对象的类。把它作为容器的元
            素类型，那么这个容器就可以包含不同类型的元素。比用void *要安全。
        compressed_pair，跟STL里的pair差不多。不过对空元素做了优化。
        tuple可以让函数返回多个值。

        pool:内存池，不用害怕频繁分配释放内存导致内存碎片
        smart_ptr:智能指针，这下不用担心内存泄漏的问题了吧。不过
            C++里的智能指针都还不是十全十美的，用的时候小心点了，不要做
            太技巧性的操作了。  shared_ptr
        date_time，这个是平台、类库无关的实现，如果程序需要跨平台，可以
            考虑用这个。
        timer，提供了一个计时器，虽然不是Windows里那种基于消息的计时器，
            不过据说可以用来测量语句执行时间。
        MPI












