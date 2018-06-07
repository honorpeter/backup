安装cmake:   
    git clone -b v3.9.1 https://cmake.org/cmake.git cmake
     cd cmake
     ./bootstrap --system-curl --prefix=install
     make  # 如果有编译的话 make clean
     make install
        注意:使用系统的curl 这样可以避免不支持https 等一些其他的协议
        添加 PATH环境目录


