过滤数据
    1   验证数据
        数值型数据 如pid 价格
            is_int() 判断
            filter_var() 过滤 整形 范围
            可以使用强制类型转换
            使用正则表达式


    2   存储到数据库里面的数据 name email
            判断是否为空
            格式是否正确
            去掉空格
            网页安全考虑 防止被php执行 和 被浏览器执行 
                去掉php html js标签

            数据库非法字符
                使用mysqli_real_escape_string()处理 
                    将处理过的字符当做需要插入的数据来处理不会当语句执行
                可以使用占位符
                
mysqli函数式操作过程
    链接
            mysqli_connect()
                使用@防止出现没有 这个数据库的信息
                如果出错 die() 
                再调用 mysqli_connect_error()
            可以选择字符集
                mysqli_set_charset($dbc,'utf8')
                mysqli_query($dbc,'SET NAMES utf8');

    插入数据
            $q='insert into xiaolong() value()';
            $r=mysqli_query($dbc,$q);
                加@防止出现 没有这一行的警告
            判断操作是否成功
                可以判断$r 是否为真 只是判断执行是否成功 
                可以mysqli_affect_rows($r)==1  影响行数
                如果为假 调用 mysqli_error($dbc)
            
            关闭链接 mysqli_close($dbc)
    update delete 和insert基本一样
    
    查询读取数据
            $q='select * from xiao';
            @$r=mysqli_query($dbc,$q);
                加@防止出现没有一个结果的警告
            一般使用 mysqli_num_rows($r) 来判断是否查询成功
                失败使用 mysqli_error()
            读取数据
                使用 while($row=mysqli_fetch_array($r,MYSQLI_NUM)){}
                    MYSQLI_ASSOC    MYSQLI_BOTH
                    还可以使用 list   mysqli_fetch_object()
            释放资源 mysqli_free_result($r)
            关闭链接 mysqli_close($dbc)

增加页面：
    只进行 insert操作

查看页面：
    只进行查询操作 
        分页处理
            只需要发送 当前页所在的开始位置
        按照父子关系排序

修改页面
    判断是get方法
        从 查看页面或则搜索页面 发过来的id 
        执行查询操作 显示页面
    还是post方法
        修改后提交的 内容
        执行 update 操作

删除页面
    一种方法 由传过来的id直接删除 在客户端验证
    另一种   显示另一个页面 使用 post方法提交确认
             分post get方法 讨论   

搜索页面
    和查看页面 基本一样
    post 方法接收关键词 还可提交按什么方式排序 搜索查询    显示
        分页处理

