git仓库：
        很几个概念：
            本地目录
                    在这个目录里面 可以建立本地仓库   应该可以建立多个  
                    可以将目录里面的 文件添加到本地仓库里面进行管理
            本地仓库
                    可以建立多个    仓库默认master
                    每一个本地仓库都会有一个      .git目录文件  
                                                    用于控制 文件的修改记录
            远程仓库
                    可以建立多个仓库    每个库里面都有 .git目录
                    主仓库是 master

            远程仓库可以和本地仓库进行各种操作
                    
创建版本库:
    初始化：
        进入想要创建的目录：
            git init
                这样便多了一个.git的目录

把文件添加到版本库:
        git add readme.txt              这样可以连续添加多个文件
                                        然后使用 commmt便可以一起
                                        提交到库中
        git commit -m "wrote a readme file"
                                    -m后面输入的是本次提交的说明
                                    从历史记录里方便地找到改动记录

时光机穿梭:
        添加到 文件之后 就可以操作 这些文件了
        git status命令可以让我们时刻掌握仓库当前的状态
    
        git diff顾名思义就是查看difference

        修改之后 然后还要提交：
            git add readme.txt
            git commit -m "add distributed"

    版本回退：
        git log         告诉我们历史记录
                        提交的历史
                        --pretty=oneline 可以简化信息




远程仓库：
        添加远程仓库：
            git remote add origin git@github.com:michaelliao/learngit.git
        本地库的所有内容推送到远程库上：
            git push -u origin master
                               第一次推送master分支时        加上了-u参数
                                把本地的master分支和远程的master分支关联起来
                                ，在以后的推送或者拉取时就可以简化命令。
                    以后就可以使用这个简化命令
                        git push origin master
                                把本地master分支的最新修改推送至GitHub

        从远程库克隆:
            git clone git@github.com:michaelliao/gitskills.git








