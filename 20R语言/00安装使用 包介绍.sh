install and update
    install:
            linux:  sudo apt-get install R.x86_64

    Update:
            linxu:  sudo apt-get update  R.x86_64




    Open:
            command: R
            The interface for R:
                command: R -g Tk &   

    The R Console:
            like the ubuntu terminal

    Command-Line Editing:
            edit()  
    Batch Mode:
            R CMD BATCH generate_graphs.R       
                running linux terminal
                generating an output file called generate_graphs that rename
                        R CMD BATCH generate_graphs.R generate_graphs_`date "+%y%m%d"`.log
            RScript generate_graphs.R 
                output to stdin

    Using R Inside Microsoft Excel:
            ....
    Other Ways to Run R:
            As a web application:
                http://biostat.mc.vanderbilt.edu/rapache/
            As a server:
                http://www.rforge.net/Rserve/index.html.
            Inside Emacs:
                http://ess.rproject.org/.
    帮助:
            ?read.delim     Access a function's help file
            ??base::delim    Search for 'delim' in all help files for 
                    functions in 'base'
            help.search("delimited")   Search for 'delimited' in all 
                    help files
            RSiteSearch("parsing text") Search for the term 'parsing text'
                    on the R site
            example(glm)

            library(help="grDevices")
                    get the help file for a package
            vignette("affy")
                    A vignette is a short document that describes how to
                         use the package
            vignette(all=FALSE)
                    view available vignettes for all attached packages
            vignette(all=TRUE)
                    view vignettes for all installed packages


    改变当前目录:
            setwd("~/download")
    加载程序执行:
            source("hh.R")

    
安装包:
        install.packages("tm",dependencies=TRUE)    自动安装
        install.packages(c("tree","maptree"))       install tree and maptree
        install.packages("RCurl_1.5-0.tar.gz",repos=NULL, type="source")
                安装源代码包
    remove packages:
        remove.packages(c("tree", "maptree"),.Library)

        installed.packages Returns a matrix with information about all
                currently installed packages.
        available.packages Returns a matrix of all packages available on 
                the repository.
        old.packages Returns a matrix of all currently installed packages 
                for which newer versions are available.
        new.packages Returns a matrix showing all currently uninstalled 
                packages available from the package repositories.
        download.packages Downloads a set of packages to a local directory.
        install.packages Installs a set of packages from the repository.
        remove.packages Removes a set of installed packages.
        update.packages Updates installed packages to the latest versions.
        setRepositories Sets the current list of package repositories.
Creating a Package Directory:
        look the R in a Nutshell
加载包:
        library(ggplot2)

Listing Packages in Local Libraries:
    list of packages loaded by default
            getOption("defaultPackages")
    To show all packages available
            (.packages(all.available=TRUE))
            or
            library()


常用包:
        reshape 包:
            函数 cast
        plyr:     家族函数
            ddply()
        ggplot2:各种画图的文件包
            geom_histogram()   
            hh <- ggplot(userAction,aes(x=Ds))+geom_histogram()+
                        scale_x_date(major="50 years")
                    ggplot2操作的对象必须是数据框
                    scale_x_date指定间隔跨度 50 years
            print hh        显示图形


              
            



        







