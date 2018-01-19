echo $PKG_CONFIG_PATH

pkg-config:
    .pc 文件的搜索路径是通过环境变量 PKG_CONFIG_PATH 来设置的，pkg-config 将按照设置路径的先后顺序进行搜索，直到找到指定的 .pc 文件为止。
    gcc -c `pkg-config --cflags glib-2.0` sample.c  显示 文件目录
    gcc sample.o -o sample `pkg-config --libs glib-2.0` 显示库文件 名字


1、环境变量 LD_LIBRARY_PATH 中指明库的搜索路径。
2、 /etc/ld.so.conf 文件中添加库的搜索路径。         
