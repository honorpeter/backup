单入口
includes 目录
    config.inc.php
        1 定义网站的错误处理方式 调试和服务的方式不同
            set_error_handler() 
                error_log() 发送给管理员
                debug_print_backtrace() 打印显示的消息和回朔消息
        2 定义跟路径 (两种不同的路径)
                www.
                /path/to
    
    header.php  .html 各种嵌入只要写上<?php ?>包含之后解析
        1 $title 导航栏    logout login

    footer.htmlls
        1  编写页尾的所有信息

modules目录  网页中间中间部分
    about.inc.php
        1  重定向 查看网页的访问
            BASE_URL    header()    exit
        2   写网页的内容
    main.inc.php
        1  重定向 查看网页的访问
            BASE_URL    header()    exit
        2   写网页的内容

        ......等 可以写同个模块

index.php 入口文件 单入口
        1  require('./includes/config.inc.php');
        2   switch(){}  检查文件是否存在
        3   包含 header.html 中间模块 footer.html


