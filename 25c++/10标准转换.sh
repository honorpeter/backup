C++类型转换分为：隐式类型转换和显式类型转换:
    隐式类型转换: 又称为“标准转换”
             算术转换(Arithmetic conversion) : 在混合类型的算术表达式中, 
                    最宽的数据类型成为目标转换类型
                    int ival = 3;
                    double dval = 3.14159;

                    ival + dval;//ival被提升为double类型

            一种类型表达式赋值给另一种类型的对象：目标类型是被赋值对象的类型
                    int *pi = 0; // 0被转化为int *类型
                    ival = dval; // double->int

            将一个表达式作为实参传递给函数调用，此时形参和实参类型不一致：
                    目标转换类型为形参的类型
                    extern double sqrt(double);

                    cout << "The square root of 2 is " << sqrt(2) << endl;
                    //2被提升为double类型：2.0

            从一个函数返回一个表达式，表达式类型与返回类型不一致
                    目标转换类型为函数的返回类型
                    double difference(int ival1, int ival2)
                    {
                        return ival1 - ival2;
                        //返回值被提升为double类型
                    }

    显式类型转换:      “强制类型转换”(cast)
        C     风格： (type-id)
        C++风格： static_cast、dynamic_cast、reinterpret_cast、和const_cast.
        标准C++中有四个类型转换
                static_cast、dynamic_cast、reinterpret_cast、和const_cast。
            static_cast:
                用法：static_cast < type-id > ( expression ) 没有运行时类型
                        检查来保证转换的安全性。

                用于类层次结构中基类和子类之间指针或引用的转换。进行上行转
                    换（把子类的指针或引用转换成基类表示）是安全的；
                    进行下行转换（把基类指针或引用转换成子类指针或引用）时，
                    由于没有动态类型检查，所以是不安全的。
                用于基本数据类型之间的转换，如把int转换成char，把int转换
                    成enum。这种转换的安全性也要开发人员来保证。
                把void指针转换成目标类型的指针(不安全!!)

                static_cast不能转换掉expression的const、volitale、
                        或者__unaligned属性。
            dynamic_cast:
                dynamic_cast < type-id > ( expression )
                Type-id必须是类的指针、类的引用或者void *；如果type-id是类指
                    针类型，那么expression也必须是一个指针，如果type-id是
                    一个引用，那么expression也必须是一个引用。
                在类层次间进行上行转换时，dynamic_cast和static_cast的效果
                    是一样的；在进行下行转换时，dynamic_cast具有类型检查
                    的功能，比static_cast更安全
            const_cast:
                    const_cast<type_id> (expression)
                    该运算符用来修改类型的const或volatile属性。除了const 
                    或volatile修饰之外， type_id和expression的类型是一样的。
    reinterpret_cast:
        reinterpret_cast <new_type> (expression)
        reinterpret_cast运算符是用来处理无关类型之间的转换；它会产生一个新
            的值，这个值会有与原始参数（expressoin）有完全相同的比特位
        什么地方用来作为转换运算符：
            从指针类型到一个足够大的整数类型
            从整数类型或者枚举类型到指针类型
            从一个指向函数的指针到另一个不同类型的指向函数的指针
            从一个指向对象的指针到另一个不同类型的指向对象的指针
            从一个指向类函数成员的指针到另一个指向不同类型的函数成员的指针
            从一个指向类数据成员的指针到另一个指向不同类型的数据成员的指针
            ...
            任何类型的指针之间都可以互相转换
    reinterpret_cast有何作用:
            用来辅助哈希函数
            // expre_reinterpret_cast_Operator.cpp
            // compile with: /EHsc
            #include <iostream>
            // Returns a hash code based on an address
            unsigned short Hash( void *p ) {
	            unsigned int val = reinterpret_cast<unsigned int>( p );
	            return ( unsigned short )( val ^ (val >> 16));
            }
            
            using namespace std;
            int main() {
	            int a[20];
	            for ( int i = 0; i < 20; i++ )
		            cout << Hash( a + i ) << endl;
            }

            //如果跟我一样是64位的系统，可能需要将unsigned int改成 
                unsigned long才能运行。
            train_label.read(reinterpret_cast<char *>(&magic),4);
            
        









