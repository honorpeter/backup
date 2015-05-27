修改dns服务器IP
    修改 /etc/resolvconf/resolv.conf.d/head  
        
        nameserver ......
        nameserver 202.196.64.1
        
    and run  sudo resolvconf -u
    将原有的注释掉
    
        
