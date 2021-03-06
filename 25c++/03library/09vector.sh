vector是一个十分有用的容器:
        头文件#include<vector>

    1、vector对象的定义和初始化
            在vector中主要有四种定义和初始化的方法：

    1.1、定义空的vector
            定义的方法为：
                vector<T> v;
    1.2、定义一个vector的副本
            定义的方法为：
                vector<T> v1(v);
    1.3、定义并初始化
            定义的方法为：
                vector<T> v2(n, i);
        定义了长度为n的vector v2，并且每个元素都是i。

    1.4、定义并指定初始长度
            定义的方法为：
                vector<T> v3(n)；
                采用的初始化方法为默认初始化。

    1 基本操作:
            创建vector对象，vector<int> vec;

            尾部插入数字：vec.push_back(a);

            使用下标访问元素，cout<<vec[0]<<endl;记住下标是从0开始的。

            使用迭代器访问元素.

                vector<int>::iterator it;
                for(it=vec.begin();it!=vec.end();it++)
                    cout<<*it<<endl;

                for(auto val : it)  c++11遍历方法
                    cout val

            插入元素：    
                vec.insert(vec.begin()+i,a);在第i+1个元素前面插入a;

            删除元素：    
                vec.erase(vec.begin()+2);删除第3个元素

                vec.erase(vec.begin()+i,vec.end()+j);
                                        删除区间[i,j-1];区间从0开始

            向量大小:vec.size();

            清空:vec.clear();


        2 vector的元素不仅仅可以使int,double,string,还可以是结构体
            要注意：结构体要定义为全局的，否则会出错下面是一段简短的程序代码
            #include<stdio.h>
            #include<algorithm>
            #include<vector>
            #include<iostream>
            using namespace std;

            typedef struct rect
            {
                int id;
                int length;
                int width;

            　　//对于向量元素是结构体的，可在结构体内部定义比较函数，
                    //下面按照id,length,width升序排序。
            　　bool operator< (const rect &a)  const
                {
                    if(id!=a.id)
                        return id<a.id;
                    else
                    {
                        if(length!=a.length)
                            return length<a.length;
                        else
                            return width<a.width;
                    }
                }
            }Rect;

            int main()
            {
                vector<Rect> vec;
                Rect rect;
                rect.id=1;
                rect.length=2;
                rect.width=3;
                vec.push_back(rect);
                vector<Rect>::iterator it=vec.begin();
                cout<<(*it).id<<' '<<(*it).length<<' '<<(*it).width<<endl;    
                return 0;

            }
        3  算法

            使用reverse将元素翻转：需要头文件#include<algorithm>
                reverse(vec.begin(),vec.end());将元素翻转(在vector中，
                如果一个函数中需要两个迭代器， 一般后一个都不包含.)
            使用sort排序：需要头文件#include<algorithm>，
                sort(vec.begin(),vec.end());(默认是按升序排列,即从小到大).

            可以通过重写排序比较函数按照降序比较，如下：
                定义排序比较函数：
                
                bool Comp(const int &a,const int &b)
                {
                    return a>b;
                }
                调用时:sort(vec.begin(),vec.end(),Comp)，这样就降序排序。









