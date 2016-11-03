sudo apt-get install wireshark

普通用户可以使用dumpcap的root权限:
        sudo groupadd  wireshark
        sudo chgrp wireshark /usr/bin/dumpcap 
        sudo chmod 4755 /usr/bin/dumpcap 
        sudo gpasswd -a user wireshark 

        创建一个用户组 可以有root权限使用dumpcap 并将用户加入那个组中








