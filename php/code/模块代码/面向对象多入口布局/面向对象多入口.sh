面向对象多入口
    classes目录
        Page.php
            1 class page  
            2 对象和数据库里面的类型一样 (一般初始化为NULL) 
            3   返回信息不多的信息
        User.php
            1 class user
            2 类型一样初始化为NULL 防止没有
            ３　设置权限
    includes目录
        footer.inc.php
            1 页尾的书写
        header.inc.php
            1 页头的书写
        utilties.inc.php
            1 定义自动加载类
                spl_autoload_register();
                开启session session_start()
            2  try 链接数据库  链接失败 抛出异常 
                包含错误 头 错误 尾 页面 exit

    views目录
        index.html  
            被index.php 文件加载的模板页面
        add_page.html
        login_html
        logout.html
        page.html
        error.html
            发生错误时被加载的页面
多个入口文件
    index.php
        网站首页
            1 require('includes/utilities.inc.php');
            2 include('includes/header.inc.php');
            3 try 
                    这里面写各种 查询
                    if判断有错误 throw new EXception（）
                    加载index.html
              catch 
                加载错误页面 error.html
            4 include('/includes/footer.inc.php')
    page.php
            1  $stmt->setFetchMode(PDO::FETCH_CLASS, 'Page');
    login.php
    logout.php
    add_page.php
        
