C++ string 用法详解:
    #include<string>
    string 使用:
        string并不是一个单独的容器，只是basic_string 模板类的一个typedef 
                而已，相对应的还有wstring
                string 其实相当于一个保存字符的序列容器
        充分使用string 操作符:
            string 重载了许多操作符，包括 +, +=, <, =, , [], <<, >>等
                #include <string>
                #include <iostream>
                using namespace std;
                int main()
                {
                    string strinfo="Please input your name:";
                    cout << strinfo ;
                    cin >> strinfo;
                    if( strinfo == "winter" )
                        cout << "you are winter!"<<endl;
                    else if( strinfo != "wende" )
                        cout << "you are not wende!"<<endl;
                    else if( strinfo < "winter")
                        cout << "your name should be ahead of winter"<<endl;
                    else
                        cout << "your name should be after of winter"<<endl;
                    strinfo += " , Welcome to China!";
                    cout << strinfo<<endl;
                    cout <<"Your name is :"<<endl;
                    string strtmp = "How are you? " + strinfo;
                    for(int i = 0 ; i < strtmp.size(); i ++)
                        cout<<strtmp[i];
                    return 0;
                }
            有了这些操作符，在STL中仿函数都可以直接使用string作为参数，例如 
            less, great, equal_to 等，因此在把string作为参数传递的时候，它
            的使用和int 或者float等已经没有什么区别了
                map<string, int> mymap; //以上默认使用了 less<string>

        有了 operator + 以后，你可以直接连加:
                string strinfo="Winter";
                string strlast="Hello " + strinfo + "!";
                在开始的两项中，必须有一项是 string 对象 系统遇到"+"号
                    发现有一项是string 对象。 系统把另一项转化为一个临时 
                    string 对象。 
                    等式是由左到右开始检测执行，如果开始两项都是const char
                   程序自己并没有定义两个const char 的加法，编译的时候肯定
                   就有问题了
                有了操作符以后，assign(), append(), compare(), at()等函数:
                at()函数还有一个功能，那就是检查下标是否合法，如果是使用：
                    string str="winter";//下面一行有可能会引起程序中断错误
                    str[100]='!';//下面会抛出异常:throws: out_of_range
                    cout<<str.at(100)<<endl;
    string find 函数:
             find 查找 rfind 反向查找 
             find_first_of 查找包含子串中的任何字符，返回第一个位置 
             find_first_not_of 查找不包含子串中的任何字符，返回第一个位置 
             find_last_of 查找包含子串中的任何字符，返回最后一个位置 
             find_last_not_of 查找不包含子串中的任何字符，返回最后一个位置
             以上函数都是被重载了4次，以下是以find_first_of 函数为例说明他
             们的参数，其他函数和其参数一样，也就是说总共有24个函数 ：
        size_type find_first_of(const basic_string& s, size_type pos = 0)
        size_type find_first_of(const charT* s, size_type pos, size_type n)
        size_type find_first_of(const charT* s, size_type pos = 0)
        size_type find_first_of(charT c, size_type pos = 0)
            所有的查找函数都返回一个size_type类型，这个返回值一般都是所找
            到字符串的位置，如果没有找到，则返回string::npos。有一点需要特
            别注意，所有和string::npos的比较一定要用string::size_type来使
            用，不要直接使用int 或者unsigned int等类型

            find_first_of 是给定一个要查找的字符集，找到这个字符集中任何
                一个字符所在字符串中第一个位置
                #include <string>
                #include <iostream>
                using namespace std;
                int main()
                {
                    string strinfo=" //*---Hello Word!......------";
                    string strset="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
                    int first = strinfo.find_first_of(strset);
                    if(first == string::npos)
                    {
                        cout<<"not find any characters"<<endl;
                        return -1;
                    }
                    int last = strinfo.find_last_of(strset);
                    if(last == string::npos)
                    {
                        cout<<"not find any characters"<<endl;
                        return -1;
                    }
                    cout << strinfo.substr(first, last - first + 1)<<endl;
                    return 0;
                }
                
                然后用substr 来的到中间的一部分，用于输出结果
    string insert, replace, erase:
             string只是提供了按照位置和区间的replace函数，而不能用一个
                string字串来替换指定string中的另一个字串

     更改内容:
            s.assign(str); //直接
            s.assign(str,1,3);//如果str是”iamangel” 就是把”ama”赋给字串
            s.assign(str,2,string::npos);
                    //把字符串str从索引值2开始到结尾赋给s
            s.assign(“gaint”); //不说
            s.assign(“nico”,5);//把’n’ ‘I’ ‘c’ ‘o’ ‘\0’赋给符串
            s.assign(5,’x’);//把五个x赋给字符串
            

            把字符串清空的方法有三个：s=””;s.clear();s.erase()
            增加字符（增加是在尾巴上），函数有 +=、append()、push_back()。
                s+=str;//加个字符串
                s+=”my name is jiayp”;//加个C字符串
                s+=’a’;//加个字符

                s.append(str);
                s.append(str,1,3);//不解释了 同前面的函数参数assign的解释
                s.append(str,2,string::npos)//不解释了
                
                s.append(“my name is jiayp”);
                s.append(“nico”,5);
                s.append(5,’x’);

                s.push_back(‘a’);//这个函数只能增加单个字符
                                对STL熟悉的理解起来很简单
 C++字符串和C字符串的转换:
        C++提供的由C++字符串得到对应的C_string的方法是使用data()、c_str()和
            copy()，其中，data()以字符数组的形式返回字符串内容，但并不添加’
            \0’。c_str()返回一个以‘\0’结尾的字符数组，而copy()则把字符的
            内容复制或写入既有的c_string 或字符数组内。C++字符串并不以’\0
            ’结尾。
            这几个函数的namespace 是 std::string::c_str
        c_str:
                std::string hh = "xiaoyan";
                std::string *hhPo = &hh;
                const char *p = hhPo -> c_str();    这里要加const 类型需要
                        因为p和 hh表示同一个地方 如果修改hh  *p也会改变

                还可以：
                const char *p = hh.c_str();

            

String class:
        Constructors:
            .....
                
The string Class Input 
        For C-style strings,
                char info[100];
                cin >> info;
                cin.getline(info, 100);
                cin.get(info, 100);
                // read a word
                // read a line, discard \n
                // read a line, leave \n in queue
        For string object:
                string stuff;
                cin >> stuff;
                getline(cin, stuff);
                // read a word
                // read a line, discard \n


                










