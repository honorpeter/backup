stringstream介绍：       sstream 头文件
        C++引入了ostringstream、istringstream、stringstream这三个类
        istringstream，由 istream 派生而来，提供读 string 的功能。 
        ostringstream，由 ostream 派生而来，提供写 string 的功能。 
        stringstream，由 iostream 派生而来，提供读写 string 的功能。
            因此具有 流操作 和字符串操作


stringstream  特定的操作
        stringstream strm; // 创建自由的 stringstream 对象
        stringstream strm(s); //创建存储 s 的副本的 stringstream 对象，
                            其中 s 是 string 类型的对象
        strm.str()  //返回 strm 中存储的 string 类型对象
        strm.str(s)  //将 string 类型的 s 复制给 strm，返回  void 

stringstream  提供的转换和／或格式化    整形 字符串相互转化

            int val1 = 512, val2 = 1024;
            ostringstream format_message;
            // ok: converts values to a string representation
            format_message << "val1: " << val1 << "\n"<< "val2: " 
                        << val2 << "\n"; 
    









