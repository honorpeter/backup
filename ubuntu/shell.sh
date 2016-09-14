tee 重定向输出到多个文件
常见用例：
 
        tee file     //覆盖

        tee -a file    //追加

        tee -        //输出到标准输出两次
        tee - -    //输出到标准输出三次

        tee file1 file2 -    //输出到标准输出两次,并写到那两个文件中

        ls | tee file   

        另：把标准错误也被tee读取
            ls "*" 2>&1 | tee ls.txt 
    

zerotier:
    commond: sudo zerotier-cli join     -h
            新建网络
            添加到本地
            生成ip









