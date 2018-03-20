配置文件设置：
.tmux.conf配置文件
    配置Esc取代 ctrl+b
    set-option -g prefix Escape
    unbind-key C-b
    bind-key Escape send-prefix

    # remap prefix to Control + a
    set -g prefix C-a
    # bind 'C-a C-a' to type 'C-a'
    bind C-a send-prefix
    unbind C-b


    配置滚屏：
    set -g mode-mouse on
    set -g mouse-resize-pane on
    set -g mouse-select-pane on
    set -g mouse-select-window on
    set-window-option -g mode-mouse on


在 Tmux 中，按下 Tmux 前缀 ctrl+b，然后：
    会话 :
        :new<回车>  启动新会话
        s           列出所有会话
        $           重命名当前会话
窗口 (标签页):
    c  创建新窗口
    w  列出所有窗口
    n  后一个窗口
    p  前一个窗口
    f  查找窗口
    ,  重命名当前窗口
    &  关闭当前窗口

调整窗口排序:
    swap-window -s 3 -t 1  交换 3 号和 1 号窗口
    swap-window -t 1       交换当前和 1 号窗口
    move-window -t 1       移动当前窗口到 1 号


    
    
        
