ios_base:
        namespace std:
        1.	flags	设置或返回当前flag设置
                cout << cout.flags( ) << endl;
                cout.flags( ios::dec | ios::right );    设置
                cout << cout.flags( );
        2.	getloc	返回区域设置
                cout << cout.getloc( ).name( ).c_str( ) << endl;
        3.	imbue	更改区域设置
                    double x = 123.45;
                    cout << x << endl;
                    cout.imbue(locale("french_france"));
                    cout << x << endl;
                output:
                    123.456
                    123,456
  
        4.	iword	将一个值保存作为一个iword.
                
        5.	precision	指定或返回浮点数的显示位数
                float i = 100.23456789F;
                cout.precision(6);
                cout << i << endl;
                cout << fixed << i << endl;
    
        6.	pword	保存一个值为一个pword.
                
        7.	register_callback	注册一个回调函数
                ios_base_register_callback.cpp
                #include <iostream>
                using namespace std;
  
                void callback(ios_base::event e, ios_base& stream, int arg) 
                {
                    cout << "enter callback..." << endl;
                    switch (e) 
                    {
                        case ios_base::erase_event:
                            cout << "an erase event" << endl;
                            break;
                        case ios_base::imbue_event:
                            cout << "an imbue event" << endl;
                            break;
                        case ios_base::copyfmt_event:
                            cout << "an copyfmt event" << endl;
                            break;
                    };
                }
                
                int main()
                {
                    cout.register_callback(callback, 3);
                    cout.imbue(locale("german"));
                    
                    return 0;
                }
        8.	setf	设置新的格式flags
        9.	sync_with_stdio	同步iostream和stdio
        10.	unsetf	清除格式flags
        11.	width	设置或得到输出流的长度
                   cout.width(10);
        12.	xalloc	指定一个变量是流的一部分









