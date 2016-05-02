arp -a
        有Ip地址和mac地址

nmap -sP xxx.xxx.xxx.xxx/24    可以定义扫描范围和ping扫描差不多
222.22.72.210

nmblookup -A 222.22.72.210


扫描开放端口:
        nmap -p 0-6000 IP
        nmap -sT -PN -sV -p  可以打印的信息更加详细
        nmap -sV -Pn -A -O -n -p 80,135,139,445,53 202.196.64.6
        


由域名得到Ip地址:   也可以得到DNS服务器地址
        nmap www.zzu.edu.cn 202.196.64.206
        or nslookup
            www.zzu.edu.cn

        set type=any

host zzu.edu.cn

查询经过的路由器
        traceroute www.baidu.com


nmap 
    nmap -sP -PT 80 192.168.1.0/24
        -PT选项指定端口进行TCP ping扫描

nmap -sS ip         TCP SYN端口 扫描

确定操作系统:
        nmap -O IP

连接ftp:
        ftp 10.102.255.6 
        user: anonymous





