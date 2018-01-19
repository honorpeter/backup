编译选项：
    cmake -LAH | grep INSTALL
    cmake -L

设置默认编译器 gcc  g++
    1.设置环境变量
        export CC=gcc-4.2 CXX=/usr/bin/g++-4.2 
        CC是设置gcc编译器，而CXX是设置g++编译器。这个方法不适用于Xcode
    2 使用 cmake -D
        cmake -D CMAKE_C_COMPILER=gcc -D CMAKE_CXX_COMPILER=g++ /path/to/your/source
        
