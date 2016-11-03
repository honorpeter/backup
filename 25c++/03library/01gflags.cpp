#include <iostream>

/*
 * gflags是什么：
 * gflags是google的一个开源的处理命令行参数的库，使用c++开发，具备python接口
 *          可以替代getopt。
 * gflags使用起来比getopt方便，但是不支持参数的简写（例如getopt支持--list
 *          缩写成-l，gflags不支持）。
 *  现在的命名空间是 google 以前的是gflags 
 *  不过现在 两个命令空间都可以运行
 *      感觉不管用     
        #ifdef GFLAGS_GFLAGS_H_ 
            namespace gflags = google;
        #endif
 *  
 *      
 *
 */

//添加头文件
#include <gflags/gflags.h>
using namespace std;

/*
 * 将需要的命令行参数使用gflags的宏：DEFINE_xxxxx(变量名，默认值，
 *      help-string) 定义在文件当中，注意全局域哦。gflags支持以下类型：
 *      DEFINE_bool: boolean
        DEFINE_int32: 32-bit integer
        DEFINE_int64: 64-bit integer
        DEFINE_uint64: unsigned 64-bit integer
        DEFINE_double: double
        DEFINE_string: C++ string
 */


/*
 * 可以在任何源文件中定义flag，但是每个只能定义一次。如果需要在多处使用，
 * 那么在一个文件中 DEFINE ，在其他文件中 DECLARE 。
 *          DECLARE_bool(big_menu);
 *   这和 extern FLAGS_big_menu 是等效的
 */
//DEFINE 宏有三个参数：flag名、默认值、描述使用方法的帮助。
//帮助会在执行 --help flag时显示。
//big_menu不会记录在 argc中 他们的存在不影响argc的值
DEFINE_bool(big_menu, true, "Include 'advanced' options in the menu listing");
DEFINE_string(languages, "english,french,german",
              "comma-separated list of languages to offer in the 'lang' menu");

int main(int argc, char **argv){    //这里不能写 const char **argv 下面true
                                    //要修改 
    //放到 ParseCommandLineFlags前面 输出提示信息
    gflags::SetUsageMessage("Convert a set of images to the leveldb/lmdb\n"
        "format used as input for Caffe.\n"
        "Usage:\n"
        "    http://www.image-net.org/download-images\n");
    
    //在main函数中加入：（一般是放在main函数的头几行）
    //如果设为true，则该函数处理完成后，还可以访问 
    //      agrc 是参数个数
    //      argv[1] 可以直接访问第二字符串
    //如果为false，则argv和argc会被保留，但是注意函数会调整argv中的顺序
    google::ParseCommandLineFlags(&argc, &argv, true);

    if (argc < 4) {
        //显示 usage
        gflags::ShowUsageWithFlagsRestrict(argv[0], 
                    "tools");
    

    //使用gflags
    //定义的flag可以像正常的变量一样使用，只需在前面加上 FLAGS_ 前缀
    cout << FLAGS_languages << endl;

    return 0;
}


//编译： g++ gflags.cpp -o gflags -lgflags


/*

    RegisterFlagValidator: 验证flag值:
        你可能想给定义的flag注册一个验证函数。这样当flag从命令行解析，
        或者值被修改（通过调用 SetCommandLineOption() ），验证函数都会被调用
        验证函数应该在flag值有效时返回true，否则返回false。如果对新设置的值
        返回false，flag保持当前值；如果对默认值返回false， 
        ParseCommandLineFlags 会失败
                  
        举例：
static bool ValidatePort(const char* flagname, int32 value) {
   if (value > 0 && value < 32768)   // value is ok
     return true;
   printf("Invalid value for --%s: %d\n", flagname, (int)value);
   return false;
}
DEFINE_int32(port, 0, "What port to listen on");
static const bool port_dummy = RegisterFlagValidator(&FLAGS_port, &ValidatePort);
        
        在全局初始化时注册（ DEFINE 之后），这样就在解析命令行之前执行。

        注册成功 RegisterFlagValidator() 返回true。否则返回false：a)
            第一个参数不是命令行flag，b) 已经注册了另一个验证器。


设置命令行flag:
        一般使用flag的原因是为了能在命令行指定一个非默认值
        app_containing_foo --nobig_menu -languages="chinese,japanese,korean"

        执行 ParseCommandLineFlags 会设置 FLAGS_big_menu = false ， 
            FLAGS_languages = "chinese,japanese,korean" 。
        注意这种在名字前面加“no”的设置布尔flag为false的语法。

        设置“languages”flag的方法有：

            app_containing_foo --languages="chinese,japanese,korean"
            app_containing_foo -languages="chinese,japanese,korean"
            app_containing_foo --languages "chinese,japanese,korean"
            app_containing_foo -languages "chinese,japanese,korean"
        布尔flag稍有不同：
            app_containing_foo --big_menu
            app_containing_foo --nobig_menu
            app_containing_foo --big_menu=true
            app_containing_foo --big_menu=false

更改默认的flag值:
        DECLARE_bool(lib_verbose);   
                // mylib has a lib_verbose flag, default is false
        int main(int argc, char** argv) {
        FLAGS_lib_verbose = true;  
                // in my app, I want a verbose lib by default
        ParseCommandLineFlags(...);
}
        

特殊flag
        GFlags中默认定义了一些flag。有三类，第一类是“报告”flag
                ，用于打印一些信息然后退出。

--help	显示所有文件的所有flag，按文件、名称排序，显示flag名、默认值和帮助
--helpfull	和 --help 相同，显示全部flag
--helpshort	只显示执行文件中包含的flag，通常是 main() 所在文件
--helpxml	类似 --help，但输出为xml
--helpon=FILE	只显示定义在 FILE.* 中得flag
--helpmatch=S	只显示定义在 *S*.* 中的flag
--helppackage	显示和 main() 在相同目录的文件中的flag
--version	打印执行文件的版本信息

    第二类是可以影响其他flag的
        --undefok=flagname,flagname,...  --undefok 后面列出的flag名，
                可以在无定义的情况下忽略而不报错
    第三类是“递归”flag，可以用来设置其他flag： --fromenv, --tryfromenv
         --flagfile 。
*/
    
        







