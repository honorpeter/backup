ssh -l root aliyun
 一会输入密码变可以链接了
ssh -l titanx 192.168.0.125


设置无密码登陆：
    主机A：192.168.1.110
    主机B：192.168.1.111 
    需要配置主机A无密码登录主机A，主机B
    先确保所有主机的防火墙处于关闭状态。
    在主机A上执行如下：
    　1.　$cd ~/.ssh
    　2.　$ssh-keygen -t rsa  --------------------然后一直按回车键，就会按照默认的选项将生成的密钥保存在.ssh/id_rsa文件中。
    　3.　$cp id_rsa.pub authorized_keys 
            这步完成后，正常情况下就可以无密码登录本机了，即ssh localhost，无需输入密码。
    　4.　$scp authorized_keys hadoop@192.168.1.111:/home/hadoop/.ssh   ------把刚刚产生的authorized_keys文件拷一份到主机B上.　　
    　5.　$chmod 600 authorized_keys       
    　　   进入主机B的.ssh目录，改变authorized_keys文件的许可权限。







