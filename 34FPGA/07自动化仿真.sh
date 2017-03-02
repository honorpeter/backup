modelsim do文件的自动仿真:
    
    Tcl语言的语法:
        vlib:创建库 格式vlib library name   默认库的名字为work
        vmap: 映射逻辑库名






建立自动仿真脚本:   run.do
#注释
quit -sim   #退出当前工程
.main   clear   #清楚 命令行缓冲区
vlib    lib         #创建文件夹lib  以后编译的文件都存在这里面
vlib    ./lib/work  #创建库work    相当于一个文件夹 不过包含信息
vmap    work   ./lib/work   # 将逻辑库work 文件夹lib/work










