客户/服务器结构 简称为C/S结构:
        web
对等结构:
        客户之间可以直接进行通信实现信息资源共享
        现在大量新的Internet应用是采用P2P结构


域名结构与资源记录:
        分布式域名服务器结构
                        根
        顶级域名：  国家域名    商业域名
        二级域名:   ....
        三级域名:   ....

    资源记录:
            名字 类别 类型 值

            名字用于要解析的域名
            值是解析的结果
            类别是给出定义类型的实体目前只有一种类型 IN 表示Internet
            类型用于说明名字和值之间的关系
                第一种表示地址 用A表示 前面的名字是一个完全合格的域名
                第二种类型是NS  NS表示的域名服务器
                        值表示负责该域的域名服务器 的完全合格的域名
                        然后还有使用一行 写该域名的IP地址
                第三类是CNAME 别名
                还有一类是NX 邮件
    域名解析过程:
            终端配置:
                访问的第一个域名服务器
            解释过程:
                递归解析:
                    让每个服务器 去完成解析
                迭代解析:
                    只让第一个去完成解析

    动态主机配置协议: DHCP
            能够给主机自动配置网络信息的协议
            需要在网络中设置DHCP服务器 终端自动分配IP地址等网络信息

        过程:   
            DHCP要封装成UDP报文 源端口号是68 目的端口号是67
            把这个UDP报文封装成IP分组   终端没有IP地址  设置成全0 
                                    目的IP地址 全1 因为是未知的
            把这个IP分组再封装成一个MAC帧   不知道DHCP的目的MAC地址
                                            是全1 是广播
            DHCP服务器:
                IP地址范围
                子网掩码 默认网关 本地域名服务器等这样一些信息

                发送提供报文: 包括配置所需的所有信息
            中断接收报文:
                可能接收到多个DHCP服务器给它的提供报文 选择一个 发送请求报文
                    请求报文 也是广播 和 告诉其他DHCP服务器 我不适用你们的
                然后 DHCP服务器 发出确认    分配IP只用时间
        
万维网:
        资源定位器URL
        超文本传输协议HTTP
                基于一种请求和响应型协议
                    GET URL 用于请求读取由URL标识的信息
                    是PUT URL   在URL标明的位置下存储一个文档
                    DELETE URL  删除URL中标识的资源
        超文本标记语言HTML

文件传输协议:
        ftp


        









