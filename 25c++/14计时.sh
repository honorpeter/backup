使用boost timer简单计时：
    
    #include<boost/timer.hpp>
    boost::timer t;
    //计时代码
     std::cout << "time is " << t.elapsed()<<"s" << std::endl;

使用cpu_timer统计：

        #include <boost/timer/timer.hpp>  
        #include <iostream>  
        using namespace boost::timer;  
        using namespace std;  
        int main()  
        {  
          //关于cpu_timer，比timer精度更高  
            cpu_timer t;  
            for(int i=0;i<10000;i++)  
                for(int j=0;j<1000;j++);  
        //t.format()默认6位小数，  
        //默认输出格式为"%ws wall,%us user+%ss system=%ts CPU (%p%)\n"  
        //%w 为墙上时间  
        //%u 为用户CPU时间  
        //%s 为系统CPU时间  
        //%t 为总计CPU时间  
        //%p  为总计CPU时间占墙上时间的比例  
            cout<<t.format();     
        //更改输出格式  
            /*string fmt("%ws,%us,%ss=%ts cpu %p%\n"); 
            string fmt1("进程运行时间%ws\n"); 
            cout<<t.format(7,fmt);*/      //小数点后7位  
        }  

        编译的时候：
            g++ timer.cpp -o timer -lboost_timer -lboost_system
    
