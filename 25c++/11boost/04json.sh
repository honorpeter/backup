解析json：使用boost ptree：
头文件：
    #include <boost/property_tree/ptree.hpp>
    #include <boost/property_tree/json_parser.hpp>

    主要有两个变量：
        ptree:
            他们之间的关系：
            ptree：typedef basic_ptree<std::string, std::string> ptree;
                    主要用于 root 
            ptree param_root;
	        property_tree::json_parser::read_json("conf.json",param_root);

            具有的属性：
                // Read values
                int height = root.get<int>("height", 0);
                // You can also go through nested nodes
                std::string msg = root.get<std::string>("some.complex.path");
        value_type:
            typedef std::pair<const Key, self_type>      value_type;
            typedef basic_ptree<Key, Data, KeyCompare> self_type;
            这里的key：就是 : 前面的部分 first可以引用
            
            value_type:在某种程度上是包含，ptree的 ptree都是string 类型
                是固定的 所以用在root

                value_type.second 和ptree的基本相同的 具有属性可以用

            如果是： ["jj","ll"]
                这种类型的 first为空就OK了

sample:
    [
    {
        "rtsp_addr":"http://192.168.1.1",
        "http_addr":"http://www.baidu.com"
    },
    {
        "rtsp_addr":"http://192.168.1.2",
        "http_addr":"http://www.baidu.1om"
    }
    ]


    ptree param_tree,pt_tmp;
	property_tree::json_parser::read_json("conf.json",param_tree);

	cout << "hello ";


	for (boost::property_tree::ptree::value_type &v : param_tree){
		for(boost::property_tree::ptree::value_type &val : v.second){
			cout << val.second.data();
		}
	}

    http://192.168.1.1http://www.baidu.comhttp://192.168.1.2http://www.baidu.1om

    // Read values
    int height = root.get<int>("height", 0);
    // You can also go through nested nodes
    std::string msg = root.get<std::string>("some.complex.path");


     "matrix" : [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

     int matrix[3][3];
    int x = 0;
    for (pt::ptree::value_type &row : root.get_child("matrix"))
    {
        int y = 0;
        for (pt::ptree::value_type &cell : row.second)
        {
            matrix[x][y] = cell.second.get_value<int>();
            y++;
        }
        x++;
    }
