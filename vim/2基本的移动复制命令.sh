    滑动查看：
        向上滑动：
            一直按着 j
            ctrl+u
        向下互动
            k
            ctrl+d
    窗口查看：
        zt  把当前行 置top
        zz  把当前行 置中
        zb  把当前行 置bottom
        
    简单搜索：
        高亮显示搜索 结果
            :set hlsearch
            :set nohlsearch 关闭
            :set incsearch       输入一个字母 便开始搜索了
        /jjj
        ?hhhh   向上搜索    :set ignorecase  忽略大小写
        *          将光标放在一个 单词上 按下 *  便是搜索这个单词 #方向不同
                这个 只搜索这个单词 不能搜索包含在内的单词 
                g* 变可以实现
        /\<the\>    搜索 the这个单词
        正则
    使用标记：
        ctrl+o  跳转到早写位置
        ctrl+i  
        ``      两点之间跳转
        " 上次编辑该文件时光标最后停留的位置
        [ 最后一次修改的起始位置
        ] 最后一次修改的结束位置
        具名标记：
            `a      跳转a处
            ma      把当前位置设置为 标记 a
           :marks  参看标记命令
 移动命令
    移动命令    以上下左右为中心  其他只是在这四个方向
        上的发展        以直接到达为先  
        移动的特殊情况： 各种括号 %
        向右移动：
            以f为主 nf
            w   2w  e 2e
            l  nl
            特殊情况中断处理  最后一个字符$
        向左移动：
            以F为主     nF
            ge
            h
            特殊情况中断处理  开头 0  第一个字符 ^
        向上移动
            行号 G  gg
            nj
            特殊情况中断处理   G 尾部   gg开头  H M L
        向下移动
            行号 G gg
            nk
            特殊情况中断处理   G 尾部   gg开头  H M L
    文本对象：
        aw  一个单词
        is  Inner Sentence      as 包括空白
        文本对象加操作  d c y
    复制命令：
        y 加位移命令
            yfa fFa     fnw fne
            f$  f0  f^
            其他yy
        
    删除命令：
        d 加位移命令    
            dfa  dFa   dnw     dne    
            d$=D  d0  d^
            其他 dd 
        x   nx
        J 删除本行的换行符
    删除之后进入插入模式：
        c 加位移命令
            cfa cFa cnw cne cn  c1=s
            c$ c0 c^
            其他 cc 一行   = S
    替换单个字符：r
        nr 将n字符换为同一个字符
        R 一直替换 按下ESC结束
    重复上一个命令：
        .
    visual模式：
        v  加 位移命令 or 对象命令 选中
        加 d    c  y   操作
    粘贴：
        np
        nP

    不知
        i a I A o  O

    帮助：
        :help x       help加某个命令

    寻找配置文件：
        :scriptname
        :edit ~/.vimrc 
                
            
    每一个移动的命令都可以加上 数据
    
    h
    j 
    k 
    l



    w e  b ge  一个单词为移动的距离
    
    0 移动到行前
    ^   第一个字符处
    $   最后一个字符处  可以加一个计数器 2$下一行末
    
    fx  在当前行中 找到下一个 x
    3fx 第三个          Fx 方向相反
    tx  找到x 停到前一个字符上


    一括号为移动 %  什么括号都可以



    23G 直到 23行
    G
    gg 行首

    H  home
    M  middle
    L   last


    zt  把当前行 置top
    zb  把当前行 置bottom

    dw 删除一个单词
    d$  到行尾
    c 和d 一样只是变为插入
    
    D 删除到行尾
    C 修改到行尾
    s 修改一个字符
    S 修改一行


    
