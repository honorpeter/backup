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
                    主分支是 master

            远程仓库可以和本地仓库进行各种操作

            本地分支和远程分支
                    本地和远程都可以创建各种分支
                        默认是在mater分支中进行的
            工作区和暂存区:
                    git add 添加到暂存区
                    
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
            用HEAD表示当前版本
            上一个版本就是HEAD^，上上一个版本就是HEAD^^  ....
            HEAD~100    或则这样写方面
        退回上一个版本：
            git reset --hard HEAD^
        还可以使用 commit id来 退回：
             git reset --hard 3628164  
                    可以只用git log来查找
        如果你退回了以前的版本 那么 git log 变没有了 以前版本修改后的内容
            可以使用 git reflog
                        用来记录你的每一次命令
                        这样你就可以恢复每一次的操作





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

分支管理：
        创建并切换到dev分支
            git checkout -b dev
        相当于：
            git branch dev      创建分支
            git checkout dev    切换分支

        删除分支：
            git branch -d dev

        查看分支：
            git branch


    合并dev和master分支：
            git merge dev
                这种合并是没有冲突的 没有对同一个文件进行修改
                合并指定分支到当前分支 合并完变可以删除了


        合并中的冲突解决：
            git merge dev 
                便会报错  git status 可以查看
            手动修改 有冲突的文件
                git会标出 文件中那个位置有冲突
            

        git log --graph命令可以看到分支合并图


        
        
工作区和暂存区:
        git add 添加到暂存区

    管理修改:
        git diff HEAD -- readme.txt
            查看暂存区和库中的区别
        git checkout -- readme.txt：
            两种含义：
                一种是readme.txt自修改后还没有被放到暂存区
                    销修改就回到和版本库一模一样的状态；

                一种是readme.txt已经添加到暂存区后，又作了修改
                    撤销修改就回到添加到暂存区后的状态。

        git rm
            从版本库中删除该文件，那就用命令git rm删掉，并且git commit
        还原：
             git checkout -- test.txt







