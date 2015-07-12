登陆页面
    login_function.inc.php
        定义了两个函数
            重定向到首页的函数
            检查登陆信息的函数
    login_page.inc.php
        加载头尾
        登陆表单页
        显示错误消息
    主页面 login.php
        判断提交页面 post
            是
                包含login_function.inc.php 
                验证成功设置Cookie
                或则 session  
                跳转loggedin.php              
            否 .....
            加载 login_page.inc.php
    登陆后的页面 logggedin.php
        判断是否设置Cookie或session
            否 跳转
        是
            显示  访问Cookie

    撤销登陆
        删除Cookie
        删除session     
            session两个都要删除
        

使用Cookie  数据存放在浏览器中  不要存放隐私信息 
    必须前面没有文字发送前发送 
        限制包含总共 4kb的数据 每个浏览器一般限制50个Cookie
    发送Cookie
        setcookie ('user_id', $data['user_id']);
	    setcookie ('first_name', $data['first_name']);

访问Cookie
    $_COOKIE['user_id']
		
设置Cookie参数
    setcokie(name,value,expiration,path,host,secure,httponly)
        name    value
        expiration  到期时间unix时间戳 可以写成 time()*60*3
            如果没写的话 到期为浏览器关闭
        path    host    限定web什么路径可以访问这个Cookie
                            以及里面的子路径
        secure  只能使用https链接发送Cookie
        1   httponly 只能使用https链接 并不是都支持

删除Cookie
    	setcookie ('user_id', '', time()-3600, '/', '', 0, 0);
    	setcookie ('first_name', '', time()-3600, '/', '', 0, 0);


使用会话 session  标示符使用Cookie存放在浏览器 数据存放服务器
                    //也可以将标示符存放在网页内（不支持Cookie）
        每个页面第一次使用 需要
        session_start()  他会试图发送一个Cookie 名称为PHPSESSID
                            所以不能 在他之前发送数据
            可以在php.ini 里面开启  session.auto.start 
            每一网页都自动开启

        设置变量
        $_SESSION['name']='xiaolong';

        访问session
            开启session
            $_SESSION['name']

垃圾收集
        session.gc_maxlifetime      设置生存时间
        session.gc_probability      设置 每次设置 访问session 调用垃圾收集
                                    的概率      1~100
                            如果php没有启动清理进程的 
                            则会删除任何超过1444s未使用的用户
        可以使用 ini_set() 函数设置 这两个值

删除会话变量
        删除某个变量
            unset($_SESSION['name'])
        删除每个会话变量
            $_SESSION=array();
        从服务器上 删除所有的 会话数据  针对某个用户
            session_destroy();

设置session行为 在session_start 之前写
        ini_set(sessin.use_only_cookies',1);
        .....
定制session存储位置     以及垃圾处理方式
        .....

可以保存    
        $_SERVER['HTTP_USER_AGENT']  保存到session里面

