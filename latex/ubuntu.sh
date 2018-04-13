支持中文：
    下载宋体：
        谷歌搜索下载 SimSun
        点击打开 点击右上角install 安装即可


    使用ctexart：
        \documentclass{ctexart}
 
        \setCJKmainfont{SimSun}
        \setCJKsansfont{SimSun}
        \setCJKmonofont{SimSun}
 
        \begin{document}
        
        \tableofcontents
 
        \begin{abstract}
        这是在文件的开头的介绍文字.本文的主要话题的简短说明.
        \end{abstract}
 
        \section{ 前言 }
        在该第一部分中的一些额外的元素可以被添加。巴贝尔包将采取的翻译服务.
 
        \section{关于数学部分}
        在本节中的一些数学会使用数学模型含中文字符显示。
 
        \end{document}
        
    修改配置文件：
        /usr/share/texlive/texmf-dist/tex/latex/ctex/fontset/ctex-xecjk-winfonts.def
        ctex-xecjk-winfonts.def
