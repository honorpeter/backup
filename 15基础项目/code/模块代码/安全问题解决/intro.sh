安全方法
阻止垃圾邮件
    一  查看邮件内容里面是否存在    
        某些关键字      cc to 。。。。。这些是命令行选项
    二  去掉换行符


验证数据类型
    类型验证函数
        is_array()
        is_int()
        is_bool()
        is_float()
        is_null()
        is_numeric()        数值 甚至是 字符串 例如（ '20' )
        is_resource()
        is_scalar()         标量（单值） 变量
        is_string()

    强制类型转换
        (int)
        (float)
        ......

按类型验证文件
        $_FILES['upload']['type'] 
            这个类型不安全  不能从本质上 判断文件类型 
            所以使用 Fileinfo扩展来验证文件  从编码上判断文件类型
        
        使用Fileinfo扩展验证
            $fileinof= finfo_open(FILEINFO_MIME_TYPE);
                FILEINOF_MIME_TYPE 告诉函数 使用的那种类型
            finfo_file($fileinfo, $_FILES['upload']['tmp_name'])=="text/rpf";
                返回 文件类型

            finfo_close($fileinfo);


阻止XSS攻击
        含义： 用户输入的文本中 如果包含 html js php 代码
            则可能 扰乱 页面布局   窃取cookie 页面跳转到其他网站
            。。。等等这些称为XSS攻击

        阻止：
            php函数
            htmlspecialchars()     它把 & ‘"   <  > 
                                    转化为 html实体格式
            htmlentities()          它所有适用的 字符转变为 
                                    他们的html实体格式
            strip_tags()            它删除所有的html php js 。。标签
                                    (注意是标签 )            
                                    可以指定一个参数 不删除这个 标签
                        strip_tags($var,'<p><br />')
                        注意： 它会移除它认为是 标签的所有内容
                        如： <b I forget to cole the tag
            nl2br()     和安全无关 它会把 文本内容里面的 回车符转化为 <br />


使用过滤器扩展
        filter_val()
        filter_var($val,FILTER_VALIDATE_INT,array('min_range'=>1,'max_range'=>123))
        第二个选项可以是
            FILTER_SANITIZE_EMAIL
            FILTER_SANITIZE_ENCODED
            FILTER_SANITIZE_MAGIC_QUOTES
            FILTER_SANITIZE_NUMBER_FLOAT
            FILTER_SANITIZE_NUMBER_INT
            FILTER_SANITIZE_SPECIAL_CHARS       相当于 htmlspecialchars函数
            FILTER_SANITIZE_STRING          可以替代 strip_tags
            FILTER_SANITIZE_STRIPPED
            FILTER_SANITIZE_URL
            FILTER_UNSARE_RAW


            


            


防止SQL语句注入
        mysql函数
            使用mysqli_real_escape_string()
        对象
            使用占位符
                        
