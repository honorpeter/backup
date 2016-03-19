修改类型:
        as.Date
            ufo$Date <- as.Date(ufo$DateOccurred, format="%Y%m%d")
                    format: 需要转化的字符串的时间格式
        时间戳转换:
            head(as.POSIXct(as.numeric(as.character(uData$timestamp)),origin="1970-01-01",tz="GMT"))
            use the strftime function to convert the Date objects 
                    to a string of the “YYYY-MM” format.
                YearMonth<-strftime(ufo.us$DateOccurred, format="%Y-%m")
            
        
向量:       data struct
    y<-c(12,33,12,22)
        c()函数创建向量
        <- 赋值 相当于 =        可以使用assign函数
            assign("x",c(11,22,15))
    c(12,22,12,11)->z  也是赋值语句


对向量操作 一般是对向量的每个元素进行操作
        y1 = c(y,111)       c可以使用向量作为参数
            y1= 12 33,12,22,111
        y/2  就是将y里面的每个元素都除以2
        y+3*y1  就是对应元素想加减

        当元素个数不一致的向量 元素较少的向量将循环扩充和元素个数最多的向量
         一致 最多的向量必须是最小向量的整数陪

        也可以使用 普通的+ - * / ^ 也可以使用log sin tan max mean sum
            这写函数有些是对每个元素分别计算 有些是对所有元素一起计算

复数向量:
        c(2+1i,3-9i,6+1i) -> b
        b+y -> w    复数运算

        简写:
            c(1:(22))  or c(1:22) 可以产生1 -22之间的所有数列
            冒号的优先级最高 所以下面两个是相同的
            c(3*(1:10))     c(3*1:10)

        seq函数 是生成序列的最好工具 有5个参数
            分别为:
                起始值from 终止值to  步长by  长度即元素个数length.out
                seq(1,5,2)   or seq(from=1,to=5,by=2)

                第五个参数是 along.with 参数中序列的长度作为序列的长度
                seq(form=2,by=2,along.with=c(1,2,3)) 
    

逻辑向量:
        逻辑型的值有 TRUE(T)  FALSE(F) NA(无效)
        逻辑操作符: > >= == !=  & | !
            y >= 12 ->x  y向量中每个元素和12比较 大于为true 反之F


字符串向量:
        字符串向量用单引号或双引号包围:
            c("qq","bb") -> z
            可以在字符中使用转义符 \

            paste()函数接收任意参数量的参数 可将他们依次连接到字符串的向量中
                seq指定连接时 相隔的字符
            paste(1:12)    "1" "2" ....."12"
            paste("A", 1:6) A 1     A 2 .....
            paste("A", 1:6,seq =="") A1     A2 .....


索引向量:
        上面所讲大的向量 可以通过 索引来读取 
            索引: x[c(1,2,3,4)] 读取 第1,2,3,4个
                    x[1:3] 第1-3个



对象集属性:
        R是基于类和对象的 每一种类型都是一种类

        classes: 
            character vectors, numeric vectors, data frames, lists,  arrays.
                        factor  Date       function
                

                Lists:
                        u <- list(1)
                        > v <- u
                        > u[[1]] <- "hat"

                        > l <- list(a=1, b=2, c=3, d=4, e=5, f=6, g=7, h=8, i=9, j=10)
                        > l[1:3]
                matrix:
                        m <- matrix(data=c(101:112), nrow=3, ncol=4)
                array:
                        a <- array(data=c(101:124), dim=c(2, 3, 4))
                factor:
                        eye.colors <- factor(c("brown", "blue", "blue", "green", "brown", "brown", "brown"))
                        levels(eye.colors)
                Data Frames:
                    A data frame represents a table of data. Each column 
                        may be a different type, but each row in the data 
                        frame must have the same length
                    data.frame(a=c(1, 2, 3, 4, 5), b=c(1, 2, 3, 4)) error
                Formulas:
                        > sample.formula <- as.formula(y~x1+x2+x3)
                        > class(sample.formula)
                        > typeof(sample.formula)
                    Zero (0):
                        that no intercept term should be included
                        y~u+w+v+0
                    Vertical bar (|)
                        Used to specify conditioning variables
                    Identity function (I()):
                        I(a+b)  先计算a+b
                    other:
                        + - * ^  log(u) sin(x)
                Time:
                    ts(data = NA, start = 1, end = numeric(0), frequency = 1,deltat = 1, ts.eps = getOption("ts.eps"), class = , names = )
                    > ts(1:8, start=c(2008, 2), frequency=4)
                Dates and Times:
                    Date
                        Represents dates but not times.
                    POSIXct
                        Stores dates and times as seconds since January 1,
                             1970, 12:00 A.M.
                    POSIXlt:    2013/01/13 4:02:01

                function:
                        x <- function(i) i^2
            class(teams)    查看类型
            dim()   查看维度
        Special Values:
            NA: NA values are used to represent missing values.
                NA stands for “not available.
            Inf and -Inf:
                If a computation results in a number that is too big, 
                        R will return Inf for a positive number and -Inf 
                        for a negative number
            NaN:
                Sometimes, a computation will produce a result that makes 
                    little sense.
                > Inf - Inf
                [1] NaN
                > 0 / 0
                [1] NaN
            NULL:
                NULL is often used as an argument in functions
                    to mean that no value was assigned to the argument

    Models and Formulas
            
        对象集固有mode和length两种属性

        mode可以理解为对象的类型: 主要有 numericl complex logical character
                                            raw
                可以实现类型转换
                h<- 5:12
                as.character(h) 转化为字符串
        修改类型:
        as.Date
            ufo$Date <- as.Date(ufo$DateOccurred, format="%Y%m%d")
                    format: 需要转化的字符串的时间格式


        设置对象属性:
                attr(object,name)
    Formulas:
            cars.lm <- lm(formula=dist~speed,data=cars)
                data:  is the datasets

Data Structure Operators:
        x[i] 
                Vectors,lists Returns objects from object x , described 
                    by i . i may be an integer vector, character vector (of
                    object names), or logical vector. Does not allow partial
                    matches. When used with lists, returns a list. When used
                    with vectors, returns a vector.
        x[[i]] Vectors, lists Returns a single element of x , matching i . i
                     may be an integer or character vector of length 1. 
                     Allows partial matches (with exact=FALSE option).
        x$n 
            Lists Returns object with name n from object x .
        x@n 
            S4 objects Returns element stored in object x in slot named n .
        x[-i]   
                除了 第二i个 其他的都有





        

        









