1 打开端口
以7777端口为例，命令如下：

$ /sbin/iptables -I INPUT -p tcp --dport 7777 -j ACCEPT
$ /etc/init.d/iptables save      # 保存
$ /etc/init.d/iptables status    # 查看端口状态
或者打开配置文件/etc/sysconfig/iptables，加入如下语句，然后重启防火墙：

-A INPUT -p tcp -m state --state NEW -m tcp --dport 7777 -j ACCEPT
然后重启防火墙：

$ /etc/init.d/iptables restart
修改完成。其中，参数：

–A：参数就看成是添加一条规则
–p：指定协议，我们常用的tcp 协议。当然也有udp，例如53端口的DNS
–dport：就是目标端口，当数据从外部进入服务器为目标端口
–sport：数据从服务器出去，则为数据源端口使用
–j：就是指定是 ACCEPT接收，或者 DROP 拒绝
–s：指定IP
2 关闭端口
关闭端口

$ iptables -A  INPUT -p tcp --dport 7777 -j DROP
$ /etc/init.d/iptables save                         # 保存
关闭IP访问：

$ iptables -A INPUT -p tcp -s 192.168.1.2 -j DROP
或者，打开配置文件/etc/sysconfig/iptables，加入如下语句：

-A INPUT -p tcp -m state --state NEW -m tcp --dport 7777 -j DROP
再重启防火墙。

3 删除规则
查看端口状态，

$ /etc/init.d/iptables status    # 查看端口状态
可以看到端口num编号，然后按编号删除：

iptables -D INPUT 2
