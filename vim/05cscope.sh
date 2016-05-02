cscope使用
    安装 首先安装cscope  ./configure make make install

   1. 建立cscope使用的索引文件
         1. 在你需要浏览源码的根目录下(如你想用cscope看linux源码)
                使用下面命令：
                cscope -Rbkq<回车>
         2. R 表示把所有子目录里的文件也建立索引
         3. b 表示cscope不启动自带的用户界面，而仅仅建立符号数据库
         4. q生成cscope.in.out和cscope.po.out文件，加快cscope的索引速度
         5. k在生成索引文件时，不搜索/usr/include目录
   2. 在源码根目录下打开任意.c文件，使用如下命令：
         1. Ctrl+]将跳到光标所在变量或函数的定义处 Ctrl+T返回
         2. ：cs find s ---- 查找C语言符号，即查找函数名、宏、
                                枚举值等出现的地方
            ：cs find g ---- 查找函数、宏、枚举等定义的位置，
                                类似ctags所提供的功能
            ：cs find d ---- 查找本函数调用的函数
            ：cs find c ---- 查找调用本函数的函数
            ：cs find t: ---- 查找指定的字符串
            ：cs find e ---- 查找egrep模式，相当于egrep功能，
                                但查找速度快多了
            ：cs find f ---- 查找并打开文件，类似vim的find功能
            ：cs find i ---- 查找包含本文件的文
         3. 2的所以命令也可以且按銉来实现：
               1. Ctrl+\\ 再按 s 表示：cs find s命令
               2. 同理实现cs find + g,d,c,t,e,f,i命令
   3. cscope_map.vim说明：
         1. 有英文注释的我就不说明了，我就说一下里边的键map映射
         2. 如： nmap s :cs find s =expand("")
               1. nmap 表示在vim的普通模式下，即相对于：编辑模块和可视模式
                                                    以下是几种模式
                    :map            普通，可视模式及操作符等待模式
                    :vmap           可视模式
                    :omap           操作符等待模式
                    :map!           插入和命令行模式
                    :imap           插入模式
                    :cmap           命令行模式
               2. 表示：Ctrl+\\
               3. s表示输入(即按：s)s
               4. : 表示输入\':\'
               5. “cs find s"表示输入"cs find s"也即是要输入的命令"
               6. =expand("cword")总体是为了得到：光标下的变量或函数。
                        cword 表示：cursor word, 类似的还有：
                        cfile表示光标所在处的文件名吧
               7. ＜CR＞＜CR＞就是回车吧，不太清楚









