C++学习之map类型:
    头文件：#include <map> //注意，STL头文件没有扩展名.h
    map是一类关联式容器，它是模板类
        自动建立Key － value的对应。key 和 value可以是任意你需要的类型，
            但是需要注意的是对于key的类型，唯一的约束就是必须支持<操作符。

    map对象是模板类，需要关键字和存储对象两个模板参数:
        map<key, values>
        map<string, int> word_count; // 定义了一个空的map对象word_count;
    数据的插入:
        第一种：用insert函数插入pair数据。
            Map<int, string> mapStudent;
            mapStudent.insert(pair<int, string>(1, “student_one”));
            mapStudent.insert(pair<int, string>(2, “student_two”));
            map<int, string>::iterator  iter;
            for(iter = mapStudent.begin(); iter != mapStudent.end(); iter++)
            {
                Cout<<iter->first<<”   ”<<iter->second<<end;
            }
        第二种：用insert函数插入value_type数据：:
            Map<int, string> mapStudent;
            result = mapStudent.insert(map<int, string>::value_type (1, “student_one”));
                插入成功的话result.second应该是true的，否则为false。
                它的第一个变量返回的是一个map的迭代器，如果插入成功的话
                    result.second应该是true的，否则为false。
                    Pair<map<int, string>::iterator, bool> result;
            mapStudent.insert(map<int, string>::value_type (2, “student_two”));

        第三种：用数组方式插入数据: 可以覆盖 以前有的键值 上两种不行
            Map<int, string> mapStudent;
            mapStudent[1] =  “student_one”;
            mapStudent[2] =  “student_two”;
            mapStudent[3] =  “student_three”;

    map的大小:
        Int nSize = mapStudent.size(); 已经插入了多少数据

    数据的遍历:
            第一种：应用前向迭代器，上面举例程序中到处都是了
            第二种：应用反相迭代器
                map<int, string>::reverse_iterator  iter;
                for(iter = mapStudent.rbegin(); iter != mapStudent.rend(); iter++)
                {
                    Cout<<iter->first<<”   ”<<iter->second<<end;
                }
            第三种：用数组方式，:
                int nSize = mapStudent.size()
                //nIndex 看你插入的开始值了
                for(int nIndex = 0; nIndex < nSize; nIndex++)
                {
                    Cout<<mapStudent[nIndex]<<end;
                }

    数据的查找（包括判定这个关键字是否在map中出现）:
            第一种：用count函数来判定关键字是否出现
                    返回值只有两个，要么是0，要么是1
            第二种：用find函数来定位数据出现位置，它返回一个迭代器
                    map<int, string>::iterator iter;
                    iter = mapStudent.find(1);
                    if(iter != mapStudent.end())
                    {
                        Cout<<”Find, the value is ”<<iter->second<<endl;
                    }
                    Else
                    {
                        Cout<<”Do not Find”<<endl;
                    }
            第三种： Lower_bound函数 Upper_bound函数
    数据的清空与判空:
            清空map中的数据可以用clear()函数，判定map中是否有数据可以用
                empty()函数，它返回true则说明是空map
    数据的删除:
            到erase函数，它有三个重载了的函数
                 Int n = mapStudent.erase(1);//如果删除了会返回1，否则返回0
            //用迭代器，成片的删除
            //一下代码把整个map清空
            mapStudent.earse(mapStudent.begin(), mapStudent.end());

     排序:
            STL中默认是采用小于号来排序的，以上代码在排序上是不存在任何问题
                的，因为上面的关键字是int型，它本身支持小于号运算，在一些
                特殊情况，比如关键字是一个结构体，涉及到排序就会出现问题，
                因为它没有小于号操作，insert等函数在编译的时候过不去
#include <map>
#include <string>
#include <iostream>

using namespace std;

typedef struct tagStudentInfo
{
    int      nID;
    string   strName;
    //重载小于函数
    bool operator < (tagStudentInfo const& _A) const
    {
        //这个函数指定排序策略，按nID排序，如果nID相等
            //的话，按strName排序
        if(nID < _A.nID)  return true;
        if(nID == _A.nID) return strName.compare(_A.strName) < 0;
        return false;
    }
}StudentInfo, *PStudentInfo;  //学生信息
int main()
{
    int nSize;
    //用学生信息映射分数
    map<StudentInfo, int> mapStudent;
    map<StudentInfo, int>::iterator iter;
    StudentInfo studentInfo;
    studentInfo.nID = 1;
    studentInfo.strName = "student_one";
    mapStudent.insert(pair<StudentInfo, int>(studentInfo, 90));
    studentInfo.nID = 2;
    studentInfo.strName = "student_two";
    mapStudent.insert(pair<StudentInfo, int>(studentInfo, 80));

    for (iter=mapStudent.begin(); iter!=mapStudent.end(); iter++)
        cout<<iter->first.nID<<endl<<iter->first.strName<<endl<<iter->second<<endl;

}















