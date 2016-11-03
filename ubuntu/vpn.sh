注册vpn：
        https://www.ivpncup.info/
开启vpn服务器
        service openvpn start




安装最新版 wine


ubuntu 官方自带了 wine ，但是推荐用 winehq 官方提供的最新版本 wine ，新版本解决了很多以前显得麻烦的问题。


PPA地址：https://launchpad.net/~ubuntu-wine/+archive/ppa


sudo add-apt-repository ppa:ubuntu-wine/ppa


然后安装：


sudo apt-get update
sudo apt-get install wine1.7

安装完成之后运行时会提示找不到MFC42.DLL

执行如下命令

winetricks mfc42


使用自由门



