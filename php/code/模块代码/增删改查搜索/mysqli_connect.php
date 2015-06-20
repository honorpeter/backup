<?php # Script 9.2 - mysqli_connect.php

// This file contains the database access information. 
// This file also establishes a connection to MySQL, 
// selects the database, and sets the encoding.

// Set the database access information as constants:
DEFINE ('DB_USER', 'root');
DEFINE ('DB_PASSWORD', 'xiaolong');
DEFINE ('DB_HOST', 'localhost');
DEFINE ('DB_NAME', 'xiaoyan');

// Make the connection:
$dbc = @mysqli_connect (DB_HOST, DB_USER, DB_PASSWORD, DB_NAME) OR die ('Could not connect to MySQL: ' . mysqli_connect_error() );
    //使用@防止 错误显现
    //使用die（） 链接不上就 报告错误mysqli_connect_error()
    //mysqli_error() 报告查询错误

// Set the encoding...
mysqli_set_charset($dbc, 'utf8');
    //设置字符集  
    //如果不支持这个函数 还可以使用 mysqli_query($dbc,'SET NAMES utf8');
    
