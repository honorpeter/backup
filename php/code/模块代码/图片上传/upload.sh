文件上传处理
    配置php.ini

        file_uploads = On           开启文件上传功能
        upload_tmp_dir = /tmp       文件上传之后先存储在这个临时文件夹之中 
        upload_max_filesize = 50M   上传的文件总共不能超过这个值 
        max_file_uploads = 20       一次最多上传的文件个数
        post_max_size = 50M         post数据 不能超过的值
                上传的文件也是使用post的方法上传的 故是其一部分
        max_input_time              一次请求链接的最大时间


    html部分
        使用form表单加上
            enctype="multipart/form-data"
            <input type="file" name="pic" />
            可以上传多个  通过name识别
    文件上传上服务器上使用
        $_FILES 这个超全局数组来接收
        $_FILES['pic']  接收
                        name    文件原始名称
                        type    文件的MIME类型 由浏览器提供
                        size    大小    字节
                        tmp_name    临时名称
                        error   错误


查看图片
    1 使用img 地址直接链接到图片的地址      
        服务器上图片目录可以直接访问
    2 服务器上的图片目录不可以直接访问的情况
        使用 header函数
        header 函数     前面不要发送任何html js 。。。echo 等数据 
            使用\n结束每个header函数调用
            header('Location:http://www.baidu.com')
            header("Content-Type:application/pdf\n");
                            使用的是MIME类型    
                            text/html
                            text/plain  普通文本
                            text/xml
                            application/json

            header("Content-Disposition:attachment; filename=\"somefile.pdf\"\n")
                                        inline
                            告诉浏览器如何处理数据
            header("Content-Length:4098\n")
            header('Content-Type:text/html; charset=UTF-8')
                            可以告诉浏览器编码

