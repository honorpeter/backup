在标准库std中  可以使用std::fstream调用各种函数
fstream:
        #include <fstream>  
        ofstream         //文件写操作 内存写入存储设备   
        ifstream         //文件读操作，存储设备读区到内存中  
        fstream          //读写操作，对打开的文件可进行读写操作 

打开文件的方式在iOS类(所以流式I/O的基类)中定义:
                
                    ios::in	为输入(读)而打开文件
                    ios::out	为输出(写)而打开文件
                    ios::ate	初始位置：文件尾
                    ios::app	所有输出附加在文件末尾
                    ios::trunc	如果文件已存在则先删除该文件
                    ios::binary	二进制方式
            打开文件的属性同样在ios类中也有定义：
                
                    0	普通文件，打开操作
                    1	只读文件
                    2	隐含文件
                    4	系统文件
    很多程序中，可能会碰到ofstream out("Hello.txt"), ifstream in("..."),
        fstream foi("...")这样的的使用，并没有显式的去调用open（）函数就
        进行文件的操作，直接调用了其默认的打开方式，因为在stream类的构造
        函数中调用了open()函数,并拥有同样的构造函数，所以在这里可以直接使
        用流对象进行文件的操作，默认方式如下：
            ofstream out("...", ios::out);  
            ifstream in("...", ios::in);  
            fstream foi("...", ios::in|ios::out);  
    关闭文件:
            in.close(); 成员函数
            析构函数将会自动调用关闭函数close
文本文件的读写：
        类ofstream, ifstream 和fstream 是分别从ostream, istream 和iostream
            中引申而来的。这就是为什么 fstream 的对象可以使用其父类的成员
            来访问数据。成员函数(cin 和 cout)来进行输入输出。如下面的例
            题所示，我们使用重载的插入操作符<<
        
        #include <fiostream.h>  
        int main () {  
            ofstream out("out.txt");  
            if (out.is_open())   
            {  
                out << "This is a line.\n";  
                out << "This is another line.\n";  
                out.close();  
            }  
            return 0;  
        }  
        //结果: 在out.txt中写入：  
        This is a line.  
        This is another line   
    从文件中读入数据也可以用与 cin>>的使用同样的方法:
        #include <iostream>  
        #include <fstream>  
        #include <stdlib.h>  
        using namespace std;
     
        int main () {  
            char buffer[256];  
            ifstream in("test.txt");  
            if (! in.is_open())  
            { cout << "Error opening file"; exit (1); }  
            while (!in.eof() )  
            {  
                in.getline (buffer,100);  
                cout << buffer << endl;  
            }  
            return 0;  
        }  
        //结果 在屏幕上输出  
            This is a line.  
            This is another line 

去读全部文件：
    std::ifstream infile(argv[2]);
    
    while(infile >> filename ){ // >>每次读取一行
        std::cout << filename;
    }
        
状态标志符的验证(Verification of state flags):
        除了eof()以外:
            bad()
                如果在读写过程中出错，返回 true 。例如：当我们要对一个不是
                打开为写状态的文件进行写入时，或者我们要写入的设备没有剩余
                空间的时候。
            fail()
                除了与bad() 同样的情况下会返回 true 以外，加上格式错误时
                也返回true ，例如当想要读入一个整数，而获得了一个字母的时候
            eof()
                如果读文件到达文件末尾，返回true。
            good()
                这是最通用的：如果调用以上任何一个函数返回true 的话，
                此函数返回 false 。

获得和设置流指针:
    使用以下成员函数来读出或配置这些指向流中读写位置的流指针
        tellg() 和 tellp()
            这两个成员函数不用传入参数，返回pos_type 类型的值(根据ANSI-C++
            标准) ，就是一个整数，代表当前get 流指针的位置 (用tellg) 或 put
            流指针的位置(用tellp).
        seekg() 和seekp()
            这对函数分别用来改变流指针get 和put的位置。两个函数都被重载
            为两种不同的原型：
            seekg ( pos_type position );
            seekp ( pos_type position );
                使用这个原型，流指针被改变为指向从文件开始计算的一个绝对位
                置要求传入的参数类型与函数 tellg 和tellp 的返回值类型相同。
            seekg ( off_type offset, seekdir direction );
            seekp ( off_type offset, seekdir direction );
                使用这个原型可以指定由参数direction决定的一个具体的指针
                开始计算的一个位移(offset)。它可以是：
                ios::beg	从流开始位置计算的位移
                ios::cur	从流指针当前位置开始计算的位移
                ios::end	从流末尾处开始计算的位移

二进制文件:
            write ( char * buffer, streamsize size );
            read ( char * buffer, streamsize size );
    // reading binary file  
    #include <iostream>  
    #include <fstream.h>  
      
    const char * filename = "test.txt";  
      
    int main () {  
        char * buffer;  
        long size;  
        ifstream in (filename, ios::in|ios::binary|ios::ate);  
        size = in.tellg();  
        in.seekg (0, ios::beg);  
        buffer = new char [size];  
        in.read (buffer, size);  
        in.close();  
          
        cout << "the complete file is in a buffer";  
          
        delete[] buffer;  
        return 0;  
    }  
    //运行结果：  
    The complete file is in a buffer  
            
缓存和同步:
        当文件被关闭时: 在文件被关闭之前，所有还没有被完全写出或
                读取的缓存都将被同步。
        当缓存buffer 满时:缓存Buffers 有一定的空间限制。当缓存满时，
                它会被自动同步。
        控制符明确指明:当遇到流中某些特定的控制符时，同步会发生。
                这些控制符包括：flush 和endl。
        明确调用函数sync(): 调用成员函数sync() (无参数)可以引发立即同步。
            这个函数返回一个int 值，等于-1 表示流没有联系的缓存或操作失败。

    
iostream: istream ostream
    iostream 定义了三个标准对象：   << >>操作符重载了
        cout 
        cin
        cerr
        clog

istream  ostream 类继承了 ios
ifstream 类继承了 istream    
ofstream ...      ostream 
fstream ...       iostream
                    









