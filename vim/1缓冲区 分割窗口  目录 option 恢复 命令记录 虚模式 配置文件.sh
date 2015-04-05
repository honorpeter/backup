配置文件：
    set nocompatible        关闭Vi兼容
    set autoindent          自动缩进
    if has("vms")
    set nobackup
    else
    set backup
    endif       Vim在覆盖一个文件之前备份该文件。但是对VMS系统除    外
    set ruler      总是在Vim窗口的右下角显示当前光标的行列信息。
    set showcmd   在Vim窗口的右下角显示一个完整的 命 令 已 经 完成部分
    map Q gq        映射
    filetype plugin indent on   
                    自动识别文件类型
                    用文件类型plugin脚本
                    使用缩进定义文件
    autocmd FileType text setlocal textwidth=78
                Vim可以自动断行,触发点是当前行已超过78个字符了
简单的映射:
    :map <F5> i{<Esc>ea}<Esc>       word {word}
    :map \p i(<Esc>ea)<Esc>

添加一个plugin:
    plugin是一个自动执行的脚本：
        全局的：    用于所有文件
        使用一个全局的plugin:
            Unix ~/.vim/plugin/在这个目录里面的就可以用
            创建这个目录：
                mkdir ~/.vim
                mkdir ~/.vim/plugin
                cp /usr/share/vim/vim74/macros/justify.vim ~/.vim/plugin
        使用一个文件类型plugin:
            放在目录 ~/.vim/ftplugin/type_free.vim/目录里面
                type是那种类型  free自由命名可省略 _也不要
            文件类型plugin的文件名一般形式是:
                ftplugin/<filetype>.vim
                ftplugin/<filetype>_<name>.vim
                ftplugin/<filetype>/<name>.vim
                    这里出现的"<name>"可以是任何你喜欢的名字

    选项窗口:
        :options    该命令会打开一个新窗口
                    这些选项根据主题分组。把光标移动到你想了解的主题词
                    上按下回车键就可以跳转到对该主题的详细解释。
                    再按下回车键或CTRL-O就又会回到该选项列表。
            可以修改选项：
                set wrap    nowrap  鼠标放在上面 按回车变可修改    xioa 
                set so=0    以"$"命令将光标置于字符0上。用命令"r5"把它改为5
                            然后按下回车键
            常用选项:
                很多 :help 'wrap' 查看帮助      注意引号
                在该选项的后面放一个&符号使它恢复其默认值
                    :set iskeyword&
                不要折行
                    :set nowrap
                    要查看左右10个字符的上下文 
                        :set sidescroll=10
                跨行移动命令:
                    :set whichwrap=b,s  标位于行首时按退格键会往回移动到上
                        一行的行尾。同时在行尾按空格键也会移动到下一行的行首
                    使h, l命令也能绕到当前行之外,需要:set whichwrap+= l,h
                查看制表符:
                    :set list   显示制表符  set nolist
                        每个制表符都会以^I显示。同时每行行尾会有一个$字符
                    :set listchars=tab:>-,trail:-
                        每个制表符会以">---"显示 1 ,同时行尾空格以"-"显示
                关键字:
                    'iskeyword'选项定义了一个word中可以包含哪些字符:
                信息显示区:
                    :set cmdheight=3
                        控制拿出几行来显示这些信息

使用语法高亮
终端上颜色代码0表暗色,1表示亮色,而2位数字的颜色代码中十位数字4表示背景 色 ,3
表示前景色,个位数字0表示黑色,1为红,2为绿,3黄4蓝5紫6 青,7为白。以;分隔不同的
项,m结束一个定义,如echo -e "\e[1;32mthis is green \e[0;37m"会显示亮绿色。然
后恢复为暗白色
   打开色彩:
        :syntax enable
            vim会自动检测到你的文件类型并为之载入相应的语法高亮。 
            如果你想只在终端支持彩色显示时才启用语法高亮: vimrc
                if &t_Co > 1
                syntax enable
                endif
            如果你想只在GUI版本中使用语法高亮,
                只需把":syntax enable"放入|gvimrc|文件
            :set background=dark    设置背景
            :set background=light
            关闭语法高亮：
                :syntax clear
                :syntax off     要彻底停用语法高亮

编辑多个文件：
    编辑另一个文件：
        :edit foo.txt
            Vim会关闭当前正在编辑的文件打开指定的新文件进行编辑。
                如果当前文件还有未存盘的内容,Vim会显示如下的错误消息同时
                也不会打开另一个文件
                :help E37       查询错误代号
                现在可以：
                    :w 保存
                    :edit ! too.txt  强制编辑
                    :hide edit foo.txt  使它变为一个隐藏的缓冲区:
    文件列表:
        在启动Vim时就指定要编辑多个文件
            vim one.c two.c three.c
                :next       进入下一个编辑
                :wnext      保存 并 进入下一个编辑
        当前在编辑哪个文件?：
            查看整个列表中就有哪些文件：
                :args
            移到另一个文件：
                要回到前一个文件:
                    :previous
                    :wprevious
                    :last
                    :first
                    你也可以在":next"和":previous"命令前面使用一个命令计数。
                        要向前跳过2个文件
            自动存盘:
                告诉Vim每当需要时就自动保存文件,不必过问
                    :set autowrite
                    如果你正在编辑一个不希望它被自动保存的文件:
                        :set noautowrite
        编辑另一个文件列表:
            :args five.c six.c seven.h      指定文件列表
            :args *.txt     
        切换到另一文件：
            要在两个文件间快速切换,使用CTRL-^

        预定义的标记：
            `"
                这个标记会带你到上次你离开该文件时光标所在的位置
            `。
                最后一次对文件做出改动处
        文件标记:
            小写字母 只在这个文件中有用 大写字母标记多个文件中都有用
                50%mF
                    现在你可以用" ́F"命令跳转到文件foo.txt的半中间  
    备份：
        :set backup
            生 成 的 备 份 文 件 名 将 是 原 文 件 名 后 面 附 加 一 个~
        :set backupext=.bak 指定后缀名
       
分隔窗口:
    分隔一个窗口:
        :split
            该命令将屏幕分为上下两个窗口并将光标定位在上面的窗口中
    关闭除当前窗口外的所有其它窗口:
        :only
    为另一个文件分隔出一个窗口
        :split two.c 
    打开一个新窗口并开始编辑一个空的缓冲区
        :new
    窗口大小:
        :
        增加当前窗口高度:
            CTRL-W +
        减小:
            CTRL-W -
        将窗口高度指定为一个固定的高度:
            {height}CTRL-W _
    垂直分隔:
        :vsplit
        或:
        :vsplit two.c
        同样有一个对应的":vnew"命令
    切换窗口
        CTRL-W h 到左边的窗口
        CTRL-W j 到下面的窗口
        CTRL-W k 到上面的窗口
        CTRL-W l 到右边的窗口
        CTRL-W t 到顶部窗口
        CTRL-W b 到底部窗口
    移动窗口:
        CTRL-W K
            大写的字母K。命令的结果是将当前窗口向上提升了一次
        CTRL-W H 向左移动窗口
        CTRL-W J 向下移动窗口
        CTRL-W L 向右移动窗口
    针对所有窗口操作的命令针:
        :qall
        :wall
        :wqall
        :qall!
    为每一个文件打开一个窗口:
        vim -o one.txt two.txt three.txt
            "-O"参数可以使打开的窗口都垂直排列。
        使用vimdiff查看不同:
            在一个shell中键入如下命令(注意不是在Vim中):
                vimdiff main.c~ main.c
            折叠的栏位:
                可以用使用"zo"来展开
                折叠,用"zc"再把它们折起
            运行VIM后比较不同
                :edit main.c
                :vertical diffsplit main.c
            
            同步滚动
                :set noscrollbind
            跳到不同之处:
                ]c
                [c

    页签:
        正在编辑的文件是"thisfile"。下面的命令会打开文件新的页签:
            :tabedit thatfile
        新建一个页签:
            :tab split


使用GUI:
    启动gui
        gvim file.txt
        vim -g file.txt
        菜单栏：
            Toggle ToolbarList      打开/关闭工具栏的显示
            Toggle Bottom Scrollbar 打开/关闭底部滚动条的显示
            Toggle Left Scrollbar 打开/关闭左边滚动条的显示
            Toggle Right Scrollbar 打开/关闭右边滚动条的显示

大刀阔斧:
    命令的记录与回放:
        "."命令可以重复最近一次的编辑动作
        自动命令 回放：
            使 用"qname"命令开始  寄存器名字(name)必需是a到z之间的一个字母 
            执行你要执行的操作
            按下q以结束对命令的记录
            可以通过"@name"命令来执行刚刚记录下来的记录
                可以添加计数器
            修改寄存器中的内容：
                "np 将寄存器n的内容置于该行。       n是寄存器的名字
                {edits} 修改错误的部分。这与编辑普通文本无异
                "ny$ 将正确的结果回存到寄存器n中
            向寄存器中追加内容:
                目前为止我们用到的还都是小写字母的寄存器。要向寄存器追加内容
                    而不是覆盖它,使用它的大写形式即可
                    qC/word<Enter>q 以"qC"开始,被记录的命令将被追加到寄存器c

                    这种方式对命令记录和一般的yank,删除操作都有效
                        "aY
                        "AY  追加
        替换：
            :[range]substitute/from/to/[flags]
            :%substitute/Professor/Teacher  命令之前的"%"指定该命令将作用于
                    所有行上。不指定一个范围的话,":s"将只作用于当前行
            flags ：
                g 替换所有的
                c 标志告诉":substitute"命令要在执行每个替换前请求用户确认
                    y 好吧,替换吧
                    n 不,这个先留着
                    a 别问了,全部换掉吧(这群教授都不够格?? :-) )
                    q 退出,剩下的也不要管了
                    l 把现在这个改完就退出吧
                    CTRL-E 向上滚屏一行
                    CTRL-Y 向下滚屏一行
            命令作用范围
                    :1,5s/this/that/g
                    :54s/President/Fool/
                使用一个搜索模式来指定作用范围:
                    ......zhengze..
                Visual模式与范围:
                    如果你在Visual模式下选定了文本后按下了":"
                    接键入命令
            全局命令:
                :[range]global/{pattern}/{command}
                    这 里 执 行 的 是由{command}指定的命令 
        Visual block 模式:
            CTRL-V可以进入一种特殊的选择模式        开启windows兼容方式后
                        ctrl-Q
                在此模式下你可以选择一个矩形的文本块。
                "$"命令会让每一行的被选择区域扩展到该行的末尾,不管这些行的长
                    短是否参差不齐。这种选择状态持续到你发出下一个改变水平选
                    择域的命令。所以使用命令"j"会保持这种状态,而"h"命令则会 
                    停止它。
            插入文本:
                Imain.<Esc>
                A ...ff
            改变文本:
                c LONG <Esc>"   会删除被选择的文本块,然后你会身处Insert模式
                "C"命令会删除文本块最左边至每一行末尾的所有内容
                ~ 交换大小写 
                (a -> A, A -> a)
                U 将小写变大写 (a -> A, A -> A)
                u 将大写变小写 (a -> a, A -> a)
            以一个字符填充:
                "r"将使整个文本块的内容全部以一个字符来填充
            左右移动:
                ">"命令会使你的文本块向右移动一个"shift 单位
            将多行内容粘接起来:
                "J"命令使文本块纵跨的所有文本行被连接为一行
        读写部分文件:
            :read patch 名为"patch"的文件的内容将被插入到这里
            ":$r patch"将会把文件"patch"的内容追加到当前文件的最后
        写入指定范围行:
            :.,$write tempo

    格式化文本:
            :set textwidth=72
        gqap
            该命令以"gq"开始,这是Vim中的一个操作符。接下来是"ap",它代
            表"a paragraph"这样一个文本对象,文本段与文本段之间的分隔标志是
            一个空行。
        gggqG
            "gg"会首先定位到第一行,然后"gq"告诉Vim要格式文本了,"G"移动
            操作符跳转到最后一行
    使用外部程序:
        命令"!{motion}{program}"以一块文本为对象将它们通过管道送至一个外部程

    读取命令的输出:
        :read !ls   读取当前目录下的内容
    将文本写入一个命令:
       :write !wc 

灾难恢复:
        Vim会在你连续4秒不键入内时跟磁盘同步一次,或者是连续键入了200个 字 符
            之后。这可以通过'updatetime'和'updatecount'两个 选 项来控制。所
            以如果系统有所改动但Vim还没有同步时发生了宕机,那这一部分内容就无
            法恢复了
        基本方法
            vim -r help.txt
            先存成另一个文件:
                :write help.txt.recovered
        如果你在编辑一个没有指定文件名的缓冲区时死机了,可以通过一个
            空字符串作为要恢复的"文件名"
                vim -r ""
        交换文件在哪?:
                通常它跟原文件同一个目录    先切换到某个目录
                vim -r
            指定交换文件:
                vim -r .help.txt.swo


奇技淫巧:
    替换一个word:
        :%s/\<four\>/4/g        \<  开始    \>结束
        
    使用匹配的内容
        :%s/\([^,]*\), \(.*\)/\2 \1/        \1  \2 指代括号比配的内容
    统计字数:
        g CTRL-G
        统计部分：
            Visual模式,选择要统计的部分。然后用"g CTRL-G"
    消除多余空格:
        :%s/\s\+$//     尾部 替换 正则表达式

加速冒号命令:
        撤消
            ctrl-c
        删除
            退格键<BS>可以删除光标之前的一个字符。要删除光
            标之前的整个单词,命令是CTRL-W    
        命令行缩写:
            substitute"命令可以缩写为":s".
            ":set" 对应的缩写是":se"
        命令行补齐:
            :edit b<Tab>
        列出所有匹配
            用CTRL-D

进退之间:
        挂起与恢复
            CTRL-Z      or      :suspend
            {执行任何shell命令}
            fg 
        执行shell命令:
            :!{program} 
            执行 {program}
            :r !{program} 执行 {program}并读取它的输出
            :w !{program} 执行 {program}并把当前缓冲区的内容作为它的输入
            :[range]!{program} 以{program}过滤指定的行
        记住编辑信息:viminfo:
            用来存储这些信息:
                命令行历史记录和搜索命令历史记录
                寄存器中的内容
                文件中的标记
                缓冲区列表
                全局变量
            'viminfo'选项的默认设置可以存储有限的几类信息。你可能想让它
                保存更多的东西
                :set viminfo=string         string指代你要保存的东西
                :set viminfo='1000,f1,<500  为了避免你的viminfo有成千行的内                     容可以指定一个行数如500:
                    选项字符f控制是否保存全局的标记(A-Z和0-9)。如果以0为参数
                    则不会存储这些全局标记。如果参数是1或没有指定f选项,则会 
                    保存。需要的话你可以这样定制
                其它几个可用的选项字符:
                    : 要保存的冒号命令历史记录数
                    @ 要保存的输入历史记录数
                    / 要保存的搜索命令历史记录数
                    r 可移动介质,对此不会保存其标记信息(可以多次使用)
                    ! 以大写字母开始并且不含有任何小写字母的全局变量
                    h 开始时禁用'hlsearch'选项
                    % 缓冲区列表(只有没指定文件参数启动Vim时才会恢复这些信息
                    c 使用'encoding'选项中的方法进行字符编码转换
                    n viminfo文件的名字(必需是最后一个选项)
        让VIM共享viminfo:
            在第一个Vim 保存:
                :wviminfo! ~/tmp/viminfo
            在另一个中读取:
                :rviminfo! ~/tmp/viminfo
    会话:
            创建一个会话文件:
                :mksession vimbook.vim
            恢复到此前的会话状态
                :source vimbook.vim
            启动Vim时恢复某个会话
                vim -S vimbook.vim
               具体会恢复哪些东西要看'sessionoptions'选项的设置。默认值是
                "blank,buffers,curdir,folds,help,options,winsize"。 
                blank 空窗口
                buffers 所有的缓冲区,而不仅是当前窗口中的
                curdir 当前目录
                folds folds,包括手工创建的
                help 帮助窗口
                options 所以的选项和键映射
                winsize 窗口大小
        此会话,彼会话:
            .....  改乱了 可以使用恢复
        UNIX和MS-WINDOWS：
            兼容于两类系统的形式保存
                :set sessionoptions+=unix,slash
    会话能保存很多信息,但是不包括标记,寄存器和命令历史记录。要
        用这些东西你还是得靠viminfo.

查找文件:
    文件浏览器:
        编辑目录的插件：
            :edit .
            <F1>  帮助
       当前目录 :
           :cd VeryLongFileName
            :edit file1.txt  
           :pwd 
       查找一个文件 :
            #include "inits.h" 
                假设你想知道头文件"inits.h"中的内容。只需将光标置于该文件上
                然后键入:
                gf

                如果这个文件并不在工作目录下呢?此时Vim会使用在'path'选项中
                定义的目录去查找它。该选项的内容是一个以逗号分隔的目录名列表
                :set path+=c:/prog/include
                :set path+=./proto      相对路径

        你可以这样查找它:
            :find inits.h
        方便地编辑一个位于'path'中的文件:
            shell command
            vim "+find stdio.h"

    缓冲区列表:
        Vim编辑器使用缓冲区这个词来描述被编辑的文件
        隐藏缓冲区:
            :hide edit two.txt
        非活动缓冲区:
                Active List
                出现在窗口中,内容被载入
                Hidden 不显示在窗口中,但内容被载入
                Inactive 不出现在窗口中,内容也未被载入
        显示缓冲区列表:
            :buffers        or      :ls
                u   未被列出的缓冲区|unlisted-buffer| a
                % 当前缓冲区
                # 上一次的活动缓冲区
                l 被载入并显示在某窗口中的缓冲区
                h 被载入但隐藏的缓冲区。
                = 只读的缓冲区
                - 不可编辑的缓冲区,其中'modifiable'选项被关闭
                +有改动的缓冲区
        编辑一个缓冲区:
            :buffer 2       编号
        一个新窗口中打开一个缓冲区使用命令:
            :sbuffer 3
        使用缓冲区列表:
            :bnext List
            跳转到下一个缓冲区
            :bprevious 跳转到前一个缓冲区
            :bfirst 跳转到第一个缓冲区
            :blast 跳转到最后一个缓冲区
        要把一个缓冲区从列表中去除,可以用命令:
            :bdelete 3

