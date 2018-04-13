TeX Live is a TeX distribution to get up and running with the TeX document production system. To install it, once you're in the terminal, enter the following command:

    sudo apt-get install texlive-full



INSTALL TEXMAKER
    Now you need a text editor. I recommend using a specific editor for LaTeX. There are many text editors for LaTeX on the Internet as Kile, TeXworks, JLatexEditor, Gedit LaTeX Plugin, etc. My favorite text editor for Latex is Texmaker. Texmaker is a cross-platform open source LaTeX editor. To install it, go to the Ubuntu or Debian terminal and enter the following command:

    sudo apt-get install texmaker
    

使用：
    xelatex test.tex
        生成pdf文件  以及其他中间文件
    pdflatex test.tex


    最佳使用命令：
        xelatex test.tex;latexmk -c test.tex
        xelatex $1;latexmk -c $1

查看pdf：
    evince
        

支持中文：
    查看系统安装的中文：
        fc-list :lang=zh
