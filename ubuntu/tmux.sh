.tmux.conf配置文件
配置Esc取代 ctrl+b
set-option -g prefix Escape
unbind-key C-b
bind-key Escape send-prefix



配置滚屏：
set -g mode-mouse on
set -g mouse-resize-pane on
set -g mouse-select-pane on
set -g mouse-select-window on
set-window-option -g mode-mouse on
