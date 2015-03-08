编辑非文本文件:
  unix windows mac
    :set fileformats=unix,dos       指定你希望Vim能自动识别的格式
        UNIX一族决定只用进纸一个字符<Line Feed>来表示行尾 。 来 自 苹 果 阵 
        营的人则把回车<CR>作为换行的标准MS-DOS(和微软的Windows)仍然决定沿用
        古老的回车换行<CR><LF>传统。
        windows:    "/tmp/test" [dos] 3L, 71C
        mac         [mac]
        :set fileformats+=mac
    强制指定文件格式:
        :edit ++ff=unix file.txt
            "++"字符串告诉Vim后面紧接着的是一个选项名,对该选项的设置
            将覆盖它的默认值。"++ff"代表的选项是'fileformat'.
            你也可以指定为"++ff=mac"或"++ff=dos"
            "++fileformat"和"++encoding"
    格式转换:
        :set fileformat=unix
        :write
            该文件将以Unix格式保存。
  来自因特网的文件:
        You can find the information here:
        ftp://ftp.vim.org/pub/vim/README
        将光标置于该URL上,使用这个命令:
            gf
            要在一个新窗口中打开该文件的话可以用CTRL-W f.
            在Vim中直接访问来自因特网的文件靠的是netrw这个插件。目前为止
            可以处理下面几种类型的URL:
            ftp:// uses ftp
            rcp:// uses rcp
            scp:// uses scp
            http:// uses wget (reading only)
  加密文件:
        要为新编辑的文件加密,可以在启动Vim时使用"-x"参数,如:
            vim -x exam.txt
                下次直接打来 输入密码
        打开或关闭文件加密：
            要停止对一个文件加密,可以把'key'选项设置为一个空字串:
            :set key=
            下次你存盘该文件时就不会进行加密了
            为避免这个问题我们创造了":X"命令。它会象"-x"一样问你要一个密码
        加密的限制:
            Vim中所用的加密算法还不够强大 交换文件并没有被加密
            vim -x -n file.txt      禁用交换文件
                    :setlocal noswapfile  
        二进制文件:
            vim -b datafile
            二进制文件中很多字符都是不可打印字符。设置下面的选项可以以十
                六进制格式显示这些字符:
                :set display=uhex
            另外,"ga"命令可以来查明当前光标下字符的本来面目
            字节位置:
               g CTRL-G 获知光标所在字符是整个文件中第几个字节 
            使用xxd程序:
                vim -b datafile
                :%!xxd  用xxd程序把文件进行十六进制格式的转储
                编辑
                :%!xxd -r   编辑完成后再做一次逆向转换
        压缩文件:
            目前支持的压缩方法有:
                .Z compress
                .gz gzip
                .bz2 bzip2

快速键入:
    显示匹配字符:
        :set showmatch
    自动补全:
        CTRL-P
        CTRL-N
            选项:
            查找时会隐含地使用'ignorecase'选项。设置了该选项时,会在搜索
                匹配的word时忽略大小写的不同
            'infercase'。它使搜索匹配的word时忽略剩余部分的大小写
        补全特殊的文档元素:
            CTRL-X CTRL-F 文件名
            CTRL-X CTRL-L 整行内容
            CTRL-X CTRL-D 宏定义(也包括那些在include文件里定义的宏)
            CTRL-X CTRL-I 当前文件和被当前文件include的文件
            CTRL-X CTRL-K 来自一个字典文件的word
            CTRL-X CTRL-T 来自一个thesaurus的word
            CTRL-X CTRL-] tags
            CTRL-X CTRL-V Vim的命令行
          键入这些特殊命令后再使用CTRL-N可以往下查找符合的匹配,CTRL-P则往下             查找 
    程序源码中的自动补全:
            <CTRL-X> <CTRL-O>
             利用 程序语言的语法 进行分析
    重复录入：
        如果按下了CTRL-A,编辑器会插入你上一次在insert模式下录入的内容。 
        CTRL-@命令基本与CTRL-A一样,不同是它在插入之 后 会 退出Insert模式
    插入一个寄存器的内:
        命令CTRL-R {register}可以在当前位置插入指定寄存器的内容
    缩写:
        ab
        :unabbreviate"
   
编辑格式化的文本:
    断行:
        :set textwidth=30
    重新格式化:
        gq      选中区域 先 在格式化
    对齐文本:
        要让一个范围的行居中
            :{range}center [width]
            :1,5center 40
        右对齐:
            :1,5right 37
        左对齐
            :2,5left
    缩进和制表符:
        :set autoindent
        增加缩进:
            使用">"操作符命令。通常情况下人们喜欢使用">>"命令
                :set shiftwidth=4
        调整制表符:
            :set tabstop=3
        处理长的文本行:
            如果你把'wrap'选项关闭,那不管长行短长就都只会占据屏幕上的一
                个行。超出屏幕显示的部分就看不见了
            :set guioptions+=b      水平条
        移动可视屏幕行：
            要精确地每次只移动一个屏幕显示行,使用"gj"和"gk"命令。对于根
            本无需折叠显示的行,这两个命令与"j"和"k"命令的效果一样,如果一个
            长行需要折叠显示,这两个命令就会只移动一个屏幕显示行
        编辑表格:
            set virtualedit=all     可以移动到空白位置
        虚替换模式:
            使用'virtualedit'选项的缺点是让人感觉怪怪的。把光标移到行尾
            后面的时候你也不知道那里有什么,空格还是制表符?另外还有一种替代
            它的办法:虚替换模式
            rx  替换字表符
            grx 替换后 用空格填充
重复重复,再重复:
        对多个文件做同样的改动:
            :argdo %s/\<x_cnt\>/x_counter/ge | update
            ":argdo"命令以另一个命令为参数。该命令将对所有待编辑的文件都
                执行一次。
        在一个shell脚本中使用Vim:
            for file in *.txt; do
            vim -e -s $file < change.vim
            lpr -r tempfile
            done
                第二行的命令以Ex模 式(-e参 数)运 行Vim来 编 辑 文 件$file,
                从"change.vim"中读取要执行的命令-s参数告诉Vim安静地运行。也
                就是说,不要再不断给出:号以及其它不必要的提示了
                change.vim  写的是vim脚本命令
        从标准输入读取:
            ls | vim -
                从那读取的都是命令 要告诉Vim现在从标准输入读取的是编辑内容。
                这需要以"-"参数来代替文件名 
            如果你已经以标准输入来读取编辑内容,还可以用"-S"参数来读取脚本:
                producer | vim -S change.vim -

搜索命令和模式语言 :
        忽略大小写:
            :set ignorecase
                :set noignorecase
        不循环搜索:
            :set nowrapscan
        偏移:
            /default/2
            这个命令会搜索模式"default",找到后将光标停留在目标行向下的第2行
        微调查找到结果时的光标位置:
            /const/e
                会在找到"const"后把光标置于"t"上  可以-+n
        可以使用正则表达式


折行:
        zfap
            zf|是一个操作符命令,|ap|是一个文本对象。你可以用|zf|来搭配
            任何的位移命令创建折行。|zf| 也可以在Visual模式使用 1
        看折叠起来的文本,可以使用命令:
            zo      zr打开多层
        还可以用下面的命令重新折起
            zc
        如果你嵌套了多层的折行,也可以用这个命令一次打开所有折行:
            zR
    保存和恢复折:
            保存：
                :mkview
            显示：
                :loadview
                你最多可以为一个文件保存10个视图。比如把当前的设置存为第3个
                视图,然后载入第2个视图:
                :mkview 3
                :loadview 2
        根据缩进的折行:
            :set foldmethod=indent
        根据标记的折行:
            :set foldmethod=marker
        根据语法的折行:

之于程序:
        使用tags:
            tag是什么?一个位置。记录了关于一个标识符在哪里被定义的信
            息。比如C或C++程序中的一个函数定义。这种tag聚集在一起被放入一
            个tags文件。这个文件可以让Vim能够从任何位置起跳达到tag所指示的位
            置--标识符被定义的位置。
        为当前目录下的所有C程序文件生成对应的tags文件:
            ctags *.c
            
            :tag startlist
            这个命令会带你到函数"startlist"的定义处,哪怕它是在另一个文件中。
            CTRL-]命令会取当前光标下的word作为tag的名字并直接跳转
            CTRL-T命令会跳到你前一次的tag处
            用":tags"看你当前的跳转历史记录
        分隔窗口:
            你可以在":tag"后使用一个分隔窗口命令":split".Vim还有一个一举两得
            的命令:
                :stag tagname
        多个tags文件:
            如果你的源文件位于多个目录下,你可以为每个目录都建一个tags文
            件。Vim会在使用某个目录下的tags文件进行跳转时只在那个目录下跳转 
            要使用更多tags文件:
            :set tags=./tags,./../tags,./*/tags
        单个tags文件:
            它有一个参数可以搜索整个目录树
                cd ~/proj
                ctags -R .
                现在你只要告诉Vim你那一个tags文件在哪就行了:
                :set tags=~/proj/tags
        同名tag:
                先跳到最近的地方
                :tnext
                    重复使用这个命令可以发现其余的同名tag
                在多个匹配的tag之间移：
                    :tfirst 
                    go to first match
                    :[count]tprevious go to [count] previous match
                    :[count]tnext go to [count] next match
                    :tlast go to last match
        预览窗口:
            要打开一个预览窗口显示函数"write char"的定义使用命令
                :ptag write_char
            要关闭该预览窗口,使用命令:
                :pclose
            要在预览窗口中编辑一个文件:
                :pedit defs.h
    在程序中移动:
            #ifdef USE_POPEN
            fd = popen("ls", "r")
            #else
            fd = fopen("tmp", "w")
            #endif
            把光标置于"#ifdef"上按下%.
            Vim就会跳转到"#else".再次按%又会跳转
            到"#endif"。再一次按下%又会回到"#ifdef"上
            "[#"命 令 会 移 动 到 第 一 行
        在代码块中移动:
            在C代码中代码块以{}括起来。代码块可长可短。要移动到一个代
            码块的开头,使用"[["命令。"]["可以到它的末尾,这两个命令都假
            设"{"和"}"字符位于第一列。
            "[{"命令跳转到当前代码块的开头,它会跳过与它平级的代码块。相
            应地"]}"会跳转到当前代码块的末尾。
            
            写C++或Java的源代码时 1 ,外层的{}用于类的定义。下一级的{}才是
            函数定义。光标在类中时使用"[m"可以找到前一个函数的开始。"]m"到下
            一个函数的开始 2 。
            另外,"[]"是查找上一个函数的结尾,"]]"则查找下一个函数的开
            始,函数的结尾以第一行出现"}"为标志。
        括号内的移动:
            "[("和"])"命令类似于"[和"]"",只不过它工作于()的内部而不是{}。
        注释内的移动
            向后移动到注释的开头用使用"[/"。向前移动到其末尾用"]/"。这只
            对/* - */形式的注释有效。
        查找全局标识符:
            你在写C程序时可能经常会想知道一个变量是被声明为"int"还
            是"unsigned"。解决这个问题的快速办法是使用"[I"命令
        定位include文件:
            Vim会在由选项'path'指定的路径里查找include文件。如果漏掉了某
            个路径,可能就找不到一些include文件了。下面的命令可以用于检查路
            径是否正确:
                :checkpath 
            添加目录：
            :set path+=/usr/*/include
            :set path+=/usr/local/X11
        跳转到匹配的目标:
            [<Tab>
            也可以用"[ CTRL-I", CTRL-I等同于<Tab>。
        查找定义的标识符:
            "[I"命令查找任何的标识符。要只查找以"#define"定义的宏使用:
            [D
                [d 只列出第一个匹配
                ]D 只列出当前光标之后的匹配
                ]d 只列出当前光标之后的第一个匹配。
        查找局部标识符:
            gD
            要进一步限制查找的范围,让它只在当前函数里查找,使用命令:
                gd

程序的编辑:
        编译:
            下面的命令运行程序"make"(如果你要跟什么参数的话,直接放在后
            面就行了)并捕捉它可能的错误:
                :make {arguments}
                如果有错误产生,Vim会自动将光标定位于第一个错误的事发地点。
                :cnext
                    下一个错误的事发地点
            屏幕上可用的空间紧张时,Vim会缩减必需显示的错误信息。要查看
                完整的错误信息描述,使用下面的命令:
                :cc
            要回到前一个错误去,使用命令:
                :cprevious
                :cfirst 到第一个错误处
                :clast 到最后一个错误处
                :cc 3 到第3个错误处
    使用其它的编译器:
            'makeprg'选项定义了":make"命令被执行时要实际调用的外部程序通常情
            况是"make"程序,不过VisualC++的用户就需要把它定义为"nmake":
                :set makeprg=nmake
                    还可以跟上命令的参数
                :set makeprg=nmake -f project.mak
                个选项 2 中还可以引用一些Vim的关键字。字符%代表当前的文件名
                    :set makeprg=make %
        上一个错误列表:
                回到前一个错误列表:
                    :colder
                    :cnewer         查看下一

        使用不同的编译器:
                告诉Vim你所用的编译器产生的错
            误信息的格式是什么样子。这可以通过对'errorformat'选项的设置来完
            成。该选项的语法略有些复杂不过也正因为如此它才可以应用于几乎是任
            何的编译器。你可以在|errorformat|处发现对该选项的解释。
            :compiler msvc  切换到使用Microsoft Visual C++的编译器
                请查看|write-compile-plugin|
        C程序的缩进:
            对C程序或者是C 风格的程序比如Java或C++来说,打开'cindent'选项即可
            或许你会想重新对这些代码的缩进进行整理。使用"="操作符命令
                ==  重新为当前行进行适当的缩进
            当前的代码块重新设定缩进:
                =a{
            全文本：
                gg=G
        对注释的格式化：
            gq]/    "gq"是格式化命令的操作符。"]/"是移动到注释结尾的移动命令

探索GUI:
        GVIM的初始化文件
            gvim启动时,它会读取gvimrc这个初始化文件。类似于启动Vim时的vimrc.

树状撤消:
        为每个修改编号:
            one
              |
            change 1
               |
            one too
            /       \
        change 2 change 3
            |       |
        one two    me too
        在不同撤消分支间移动:
            :undo 2
                回到"one two"的状态
            命令|g-|会带你dao过去
            |g+|是往前遍历
        时间之旅:
            :undolist
                解当前撤消树上就有了哪些分支
            :earlier 10s
                下面的命令回到10秒前的状态:
            :earlier 10h

定义新命令:
            键映射:
                :map <F2> ....
            键映射和模式:
                ":map"命令定义了在Normal模式下对键序的重新映射
                :imap"可以定义Insert模式下的键序映射
                    :imap <F2> <CR>Date: <Esc>:read !date<CR>kJ
            各工作模式下对应的映射命令的列表:
                :map Normal, Visual and Operator-pending
                :vmap Visual
                :nmap Normal
                :omap Operator-pending
                :map! Insert and Command-line
                :imap Insert
                :cmap Command-line
                Operator-pending 模式指这样一种情况:你已经键入了一个作为命
               令的操作符,比如"d"或者"y",接下来Vim希望继续键入一个移动命令或
            是一个文本对象。就是这种Vim希望继续接收命令而你又尚未键入的悬而
            未决的状态,Vim术语里叫Operator-pending 模式。比如对于命令"dw",
            其中的"w"就是你在Operator-pending模式下键入的
        列出映射:
            :map
        要避免这种映射的内容又被映射的情况:
            :noremap Normal, Visual and Operator-pending
            :vnoremap Visual
            :nnoremap Normal
            :onoremap Operator-pending
            :noremap! Insert and Command-line
            :inoremap Insert
            :cnoremap Command-line
        删除一个映射:
            :unmap Normal, Visual and Operator-pending
            :vunmap Visual
            :nunmap Normal
            :ounmap Operator-pending
            :unmap! Insert and Command-line
            :iunmap Insert
            :cunmap Command-line
        特殊字符:
            ":map"命令后面可以跟其它的命令。|字符是命令之间的分隔符。同
            时这也暗示在一个映射的内容中不能出现|字符。真要包括|字符的话,
            用<Bar>来代替它。如:
            :map <F8> :write <Bar> !checkin %<CR>

            要在映射中使用空格的话,用<Space>来代替它
        自定义冒号命令:
            要定义这样的命令,使用":command"命令 2 ,如下例:
                :command DeleteFirst 1delete
        参数的个数:
            :command -nargs=0 DeleteFirst 1delete
                -nargs=0 没有参数
                -nargs=1 1个参数
                -nargs=* 任意个数的参数
                -nargs=? 0个或1个参数
                -nargs=+ 1个或多个参数
            行号范围:
                一些命令以一个指定的范围使用它的参数。要在Vim中定义这样的冒
                号命令,需要在定义时使用-range选项
                -range List 允许使用行号范围,默认是当前行
                -range=% 允许使用行号范围,默认是所有行
                -range={count} 允许使用行号范围,
                行号范围中的最后一行作为最后生效的单个数字,
                默认值是{count}
        重定义和删除命令
            要重新定义一个命令只需要在command后面加一个!
            要删除一个自定义冒号命令使用":delcommand"。
        自动命令:
            一个自动命令是在某个事件发生时会自动执行的命令
                希望每次保存文件时都会自动更新位于文件尾的时间戳。首先
                你可以定义下面这样的一个函数
                :function DateInsert()
                : $delete
                : read !date
                :endfunction
            如果希望在每次写文件时这个函数都会被调用:
                :autocmd FileWritePre * call DateInsert()
                    "FileWritePre"就是触发该命令自动被执行的事件:就在写入文
                    件文件之前。"*"是一个模式字串,用来匹配文件名,此例中要匹
                    配的是所有文件。
                :autocmd命令的一般形式如下:
                 :autocmd [group] {events} {file_pattern} [nested] {command}
                 其中的[group]名字是可选的。它只是为了方便调用和管理这些命
                    令{events}参数是可以触发该命令的事件列表(每个事件以逗号
                    分隔).{file pattern}是一个通常带有通配符的文件名。象"*.t
                    xt" 使得被定义的自动命令对所有以".txt"的文件名生效。[nes
                    ted]这个可选的标志允许对自动命令的递归触发
            事件:
                BufReadPost它在每次Vim将要编辑一个文件时被触发
                如果Vim能正常检测到文件的类型的话,它会设置'filetype'选项。
                这又会触发FileType 事件
                    :autocmd Filetype text source ~/.vim/abbrevs.vim
            文件名模式:
                正则表达式
        删除自动命令：
            :autocmd! FileWritePre *
        列出已定义的自动命令：
            :autocmd
        命令组:
            欲删除所有属"cporgrams"组的自动命令
                :autocmd! cprograms
        嵌套自动命令:
            :autocmd FileChangedShell * nested edit
        忽略一个事件:
            :set eventignore=WinEnter,WinLeave



