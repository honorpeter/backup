分类统计:
        准备分组数据
            fruit_class <-c("苹果","梨子")
            fruit_prices<-c(3.5,2.5)
        平均价格统计:
            求解平局价格使用 tapply函数 指定mean参数
            tapply(fruit_prices,fruit_class,mean)
        最低价格:
            参数min
            tapply(fruit_prices,fruit_class,min)
        标准差统计:
            参数 st
            tapply(fruit_prices,fruit_class,st)

        标准吴: 描述数据分布的离散程度好衡量均属抽样误差大小的尺度
            参数 stderr
            tapply(fruit_prices,fruit_class,stderr)
数组和矩阵基础:
        1 数组和矩阵的维数 使用dim函数
            dim(my_num) <- c(2,5)
        切片:
            操作多维数据的主要手段 以索引为参数获取数组或矩阵的一部分
            要得到多维数组的一个切片 则以索引为下标进行访问 取得某块数组

            索引主要形式:
                1 a[2,4] 获取第2,第4列的数据
                2 [c(1,2,3)] 取出第1 , 2, 3个数据 可以换行
        3 索引向量:
            
        4 array函数
            根据dim函数生成多维数组 一个参数是 数据 
            c(1:20)->h
            mya<-array(h,dim(4,5))
        5数组转化为向量
            as.vector   函数可以将数组转化为向量
            x<-array(c(1:10),dim(2,5))
            as.vector(x)
        6matix矩阵
            matix可以创建矩阵 参数: data数据 nrow行数 ncol列数 byrow是否按照
                    行顺序分配元素 默认不按
        7 对角矩阵
            diag函数 参数不同 作用不同
            c(1:10) ->a
            diag(a)  变为对角矩阵  对角元素就是 1-10
            如果 a是一个多维的数组 则提取 对角元素 变为一维
数组运算:
        向量连接:
            cbind函数将向量的行转变为列后再连接
            rbind函数将向量的列变为行后在连接
矩阵运算:
        矩阵连接 
            cbind 横向连接
            rbind 列详连接
        矩阵转置
            t函数
            aperm
        矩阵乘积:
            a %*% b 
        内积:
            向量外积:
                a %o% b
            向量内积:
                crossprod(a,b)
            矩阵内积:
                %*% crossprod都可以
            求解线性方程组:
                求解 a %*% x = b
                使用solve(a,b)
            矩阵求逆:
                solve(a)
            矩阵特征值求解:
                eigen(x,symmetric,only.values = FALSE)  
            求解矩阵行列式:
                det(x)
            奇异分解:
                svd(a)

运算:
        ( { Function calls and grouping expressions (respectively)
        [ [[ Indexing
        :: ::: Access variables in a namespace
        $ @ Component / slot extraction
        ^ Exponentiation (right to left)
        - + Unary operators for minus and plus
        : Sequence operator
        %any% Special operators
        * / Multiply, divide
        + - Binary operators for add, subtract
        < > <= >= == != Ordering and comparison
        ! Negation
        & && And
        | || Or
        ~ As in formulas
        -> ->> Rightward assignment
        = Assignment (right to left)
        <- <<- Assignment (right to left)
        ? Help (unary and binary)
        For a current list of built-in operators and t
            









