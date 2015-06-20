使用输出缓冲
    默认情况下 php 打印的任何数据都会 立刻发送 浏览器上
    但使用 输出缓冲 可以控制 它的行为
    可以在php配置文件中设置 缓存最大字节    默认

    开启缓存    
                ob_start()
                开启之后  类似echo  print的函数 发送的数据
                    都会存在 临时缓冲区内 不会发送浏览器
                    但 header cookie 则不会缓存 直接发送 给浏览器

                ob_get_contents()返回当前缓冲区内容

                ob_flush() 将数据发送到浏览器后 
                    不会关闭缓冲区 
                调用  ob_end_flush()
                    会把积累的缓存发送到 浏览器上 
                    并 关闭缓冲区
                调用  ob_end_clean() 删除缓存区内容 
                    但 不会关闭缓冲区 
            如果脚本结束时 没有关闭缓冲区 将自动关闭





开始
    1 header.html    include/header.html
        ob_start()  开启缓存    每个页面都加载这个页面 就可以防止 
                                header cookie前打印文字

        开启 sessio
        下面写 导航栏  有的东西 

    2 footer.html include/footer.html
        尾部有的东西    看一下是否 管理员  如果是 则添加一些其他的链接
        调用    ob_end_flush()  和 header.html 里面的ob_start()一起
                    防止 其他 数据发送在 header cookie 之前
    
    3 配置文件 config.inc.php  include/config.inc.php
        定义路径 。。。。。错误处理方式  时区
        自定义 错误处理方式
            set_error_handler('my_error_handler')
                    如果是 调试 
                            debug_print_backtrace() 追终错误
                    如果 在运行 mail
            发送错误时  显示更加友好的页面
            加上 使用 trigger_error()  更加有用

    4 数据库链接 mysqli_connect.php
        链接 数据库
        错误使用  trigger_error() 会触发 错误
    5 index.php 首页
        包含文件  显示信息
    6 register.php
        验证  过滤  插入数据库
        包含 基本文件  还有数据库文件
    7 激活 active.php
        
    8 登陆 撤销
        login.php 
        logout.php
    9 修改密码
        change_password.php





错误处理方式
    1 使用 set_error_handler() 
            定义自己的 显示方式   当发生错误时
            便会调用这个函数 单独显示一页
            其他地方发生 错误时  调用trigger_error('错误消息')
                便会触发一个错误 
    2  使用 exit('xiaoxi')
        直接 退出  但前面发的内容也会 出现  
        不能单独成页显示
    3  使用 异常处理 发送异常时
        加载一个 error页面 或 直接定制显示方式
         
         

                        









权限管理    
        人员分为  管理员 level 1  普通 level 2
            显示的时候  尾部  如果是 管理员 则显示其他的链接

        
数据库 设计

CREATE DATABASE ch18;

USE ch18;

CREATE TABLE users (
user_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
first_name VARCHAR(20) NOT NULL,
last_name VARCHAR(40) NOT NULL,
email VARCHAR(80) NOT NULL,
pass CHAR(40) NOT NULL,
user_level TINYINT(1) UNSIGNED NOT NULL DEFAULT 0,
active CHAR(32),
registration_date DATETIME NOT NULL,
PRIMARY KEY (user_id),
UNIQUE KEY (email),
INDEX login (email, pass)
);


