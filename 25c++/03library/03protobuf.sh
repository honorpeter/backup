Google Protocol Buffer:
    Protocol Buffers 是一种轻便高效的结构化数据存储格式，可以用于结构化
        数据串行化，很适合做数据存储或 RPC 数据交换格式。它可用于通讯
        协议、数据存储等领域的语言无关、平台无关、可扩展的序列化结构数
        据格式。目前提供了 C++、Java、Python 三种语言的 API。 

一个简单的例子:
        该程序由两部分组成。第一部分被称为 Writer，第二部分叫做 Reader。
        准备用于演示的结构化数据是 HelloWorld，它包含两个基本数据：
            ID，为一个整数类型的数据
            Str，这是一个字符串
        书写 .proto 文件:
            需要编写一个 proto 文件，定义我们程序中需要处理的结构化数据
            package lm; 
            message helloworld 
            { 
                required int32     id = 1;  // ID 
                required string    str = 2;  // str 
                optional int32     opt = 3;  //optional field 
            }
            较好的习惯是认真对待 proto 文件的文件名。比如将命名规则定于如下:
                packageName.MessageName.proto
            在上例中，package 名字叫做 lm，定义了一个消息 helloworld，该消
                息有三个成员，类型为 int32 的 id，另一个为类型为 string 
                的成员 str。opt 是一个可选的成员，即消息中可以不包含该成员。
        编译 .proto 文件:
            假设您的 proto 文件存放在 $SRC_DIR 下面，您也想把生成的文件
                放在同一个目录下
                protoc -I=$SRC_DIR --cpp_out=$DST_DIR $SRC_DIR/addressbook.proto
                protoc -I=./ --cpp_out=./ caffe.proto
                
            命令将生成两个文件
                lm.helloworld.pb.h ， 定义了 C++ 类的头文件
                lm.helloworld.pb.cc ， C++ 类的实现文件
                定义了一个 C++ 类 helloworld，后面的 Writer 和 Reader 
                    将使用这个类来对消息进行操作。
        编写 writer 和 Reader:
            Writer 的主要代码:
                #include "lm.helloworld.pb.h"

                int main(void) 
                { 
                
                    lm::helloworld msg1; 
                    msg1.set_id(101); 
                    msg1.set_str(“hello”); 
    
                    // Write the new address book back to disk. 
                    fstream output("./log", ios::out | ios::trunc | ios::binary); 
        
                    if (!msg1.SerializeToOstream(&output)) { 
                        cerr << "Failed to write msg." << endl; 
                        return -1; 
                    }         
                    return 0; 
                }
                Msg1 是一个 helloworld 类的对象，set_id() 用来设置 id 的值。
                    SerializeToOstream 将对象序列化后写入一个 fstream 流。
            编译：
                g++ write.cpp lm.helloworld.pb.cc -o hh -lprotobuf
                
         reader 的主要代码:
                #include "lm.helloworld.pb.h" 
                void ListMsg(const lm::helloworld & msg) { 
                    cout << msg.id() << endl; 
                    cout << msg.str() << endl; 
                } 
 
                int main(int argc, char* argv[]) { 

                    lm::helloworld msg1; 
 
                    { 
                        fstream input("./log", ios::in | ios::binary); 
                        if (!msg1.ParseFromIstream(&input)) { 
                        cerr << "Failed to parse address book." << endl; 
                        return -1; 
                        } 
                    } 
 
                    ListMsg(msg1); 
                }

                Reader 声明类 helloworld 的对象 msg1，然后利用 
                    ParseFromIstream 从一个 fstream 流中读取信息并反序列化。
                    ListMsg 中采用 get 方法读取消息的内部信息，并进行打印
                    输出操作
                编译：
                    g++ read.cpp lm.helloworld.pb.cc -lprotobuf
                    

高级应用话题:
    更复杂的 Message:
        嵌套 Message:
             message Person { 
                required string name = 1; 
                required int32 id = 2;        
                        // Unique ID number for this person. 
                optional string email = 3; 

                enum PhoneType { 
                    MOBILE = 0; 
                    HOME = 1; 
                    WORK = 2; 
                } 

                message PhoneNumber { 
                    required string number = 1; 
                    optional PhoneType type = 2 [default = HOME]; 
                } 
                repeated PhoneNumber phone = 4; 
            }
            在 Message Person 中，定义了嵌套消息 PhoneNumber，并用来定义 
                Person 消息中的 phone 域
        Import Message:
            在一个 .proto 文件中，还可以用 Import 关键字引入在其他 
                .proto 文件中定义的消息
            import common.header; 

                message youMsg{ 
                required common.info_header header = 1; 
                required string youPrivateData = 2; 
            }
动态编译:
        在某且情况下，人们无法预先知道 .proto 文件，他们需要动态处理一些未
        知的 .proto 文件。比如一个通用的消息转发中间件，它不可能预知需要处
        理怎样的消息。这需要动态编译 .proto 文件，并使用其中的 Message。
    Protobuf 提供了 google::protobuf::compiler 包来完成动态编译的功能。
            主要的类叫做 importer，定义在 importer.h 中
            Import 类对象中包含三个主要的对象，分别为处理错误的 
            MultiFileErrorCollector 类，定义.proto 文件源目录的SourceTree 类
        对于给定的 proto 文件，比如 lm.helloworld.proto，在程序中动态编译它
        google::protobuf::compiler::MultiFileErrorCollector errorCollector；
        google::protobuf::compiler::DiskSourceTree sourceTree; 
        google::protobuf::compiler::Importer importer(&sourceTree, &errorCollector); 
        sourceTree.MapPath("", protosrc); 
        importer.import(“lm.helloworld.proto”);
            参数一个是 source Tree 对象，该对象指定了存放 .proto 文件的
                源目录。第二个参数是一个 error collector 对象，该对象有
                一个 AddError 方法，用来处理解析 .proto 文件时遇到的语法错误
    如何使用动态编译后的 Message :
            得到 lm.helloworld.id 的定义的代码
             const protobuf::Descriptor *desc = 
                importer_.pool()->FindMessageTypeByName(“lm.helloworld”); 
            const protobuf::FieldDescriptor* field = 
                desc->pool()->FindFileByName (“id”);
            通过 Descriptor，FieldDescriptor 的各种方法和属性，应用程序
            可以获得各种关于 Message 定义的信息。比如通过 field->name() 
            得到 field 的名字

        

            

text_format.h
        #include <google/protobuf/text_format.h>
        namespace google::protobuf
            Utilities for printing and parsing protocol messages in a 
                    human-readable, text-based format.

        classes:
            TextFormat
                This class implements protocol buffer text format.
                This class is really a namespace that contains only 
                        static methods.

                Members:
                    static bool	Print(const Message & message, 
                                    io::ZeroCopyOutputStream * output)
                        Outputs a textual representation of the given 
                            message to the given output stream.
                    static bool	PrintUnknownFields(const UnknownFieldSet & 
                        unknown_fields, io::ZeroCopyOutputStream * output)
                        Print the fields in an UnknownFieldSet. more...
                    static bool	PrintToString(const Message & message, 
                                string * output)
                        Like Print(), but outputs directly to a string.
                    static bool	PrintUnknownFieldsToString(const 
                        UnknownFieldSet & unknown_fields, string * output)
                        Like PrintUnknownFields(), but outputs directly 
                            to a string.
                    static void	PrintFieldValueToString(const Message & 
                        message, const FieldDescriptor * field, int index, 
                        string * output)
                        Outputs a textual representation of the value of 
                        the field supplied on the message supplied. more...
                    static bool	Parse(io::ZeroCopyInputStream * input, 
                        Message * output)
                        Parses a text-format protocol message from the 
                            given input stream to the given message object
                    static bool	ParseFromString(const string & input, 
                        Message * output)
                        Like Parse(), but reads directly from a string.
                    static bool	Merge(io::ZeroCopyInputStream * input, 
                        Message * output)
                        Like Parse(), but the data is merged into the 
                            given message, as if using Message::MergeFrom().
                    static bool	MergeFromString(const string & input, 
                        Message * output)
                        Like Merge(), but reads directly from a string.
                    static bool	ParseFieldValueFromString(const string & 
                    input, const FieldDescriptor * field, Message * message)
                        Parse the given text as a single field value and 
                        store it into the given field of the given message. 
                    static bool TextFormat::PrintUnknownFields( const 
                        UnknownFieldSet & unknown_fields, io::ZeroCopyOutput
                        Stream * output)

                        Print the fields in an UnknownFieldSet.

                    static void TextFormat::PrintFieldValueToString( const 
                        Message & message, const FieldDescriptor * field, 
                        int index, string * output)

                        Outputs a textual representation of the value of 
                            the field supplied on the message supplied.

                    static bool TextFormat::Parse( io::ZeroCopyInputStream *
                         input, Message * output)
                        Parses a text-format protocol message from the 
                            given input stream to the given message object.
                        This function parses the format written by Print().

                    static bool TextFormat::ParseFieldValueFromString(
                            const string & input,
                            const FieldDescriptor * field,
                            Message * message)

                        Parse the given text as a single field value and 
                        store it into the given field of the given message.


                    

            TextFormat::FieldValuePrinter
                The default printer that converts scalar values from 
                            fields into their string representation.
            TextFormat::Finder
                Interface that TextFormat::Parser can use to find extensions
            TextFormat::ParseInfoTree
                Data structure which is populated with the locations of 
                            each field value parsed from the text.
            TextFormat::ParseLocation
                A location in the parsed text.
            TextFormat::Parser
                For more control over parsing, use this class.
            TextFormat::Printer
                Class for those users which require more fine-grained 
                    control over how a protobuffer message is printed out.

    调试：
            std::cout << param.DebugString();    打印param里面的字段
        



      // name   string
      inline bool has_name() const; 
      inline void clear_name(); 
      inline const ::std::string& name() const; 
      inline void set_name(const ::std::string& value); 
      inline void set_name(const char* value); 
      inline ::std::string* mutable_name();  
        // id    int
      inline bool has_id() const; 
      inline void clear_id(); 
      inline int32_t id() const; 
      inline void set_id(int32_t value);  
        // email  
      inline bool has_email() const; 
      inline void clear_email(); 
      inline const ::std::string& email() const; 
      inline void set_email(const ::std::string& value); 
      inline void set_email(const char* value); 
      inline ::std::string* mutable_email();  
        // phone  repeated
      inline int phone_size() const; 
      inline void clear_phone(); 
      inline const ::google::protobuf::RepeatedPtrField< ::tutorial::Person_PhoneNumber >& phone() const; 
    inline ::google::protobuf::RepeatedPtrField< ::tutorial::Person_PhoneNumber >* mutable_phone(); 
      inline const ::tutorial::Person_PhoneNumber& phone(int index) const; 
      inline ::tutorial::Person_PhoneNumber* mutable_phone(int index); 
      inline ::tutorial::Person_PhoneNumber* add_phone();

        前缀为mutable_的函数返回string的直接指针即char*指针
        重复的字段有一些特殊的函数——就像重复字段phone一样, 有这样一些函数:
        1. 得到重复字段的_size(换句话说，这个Person关联了多少个电话号码). 
        2. 通过索引(index)来获取一个指定的电话号码. 
        3. 通过指定的索引(index)来更新一个已经存在的电话号码. 
        4. 向消息(message)中添加另一个电话号码, 然后你可以编辑它
            (重复的标量类型有一个add_前缀的函数, 允许你传新值进去). 

    









