if else  语句:
        if (x > 1) "orange" else "apple"
        if (condition) true_expression else false_expression
    If you would like a vector operation, use the ifelse function instead:
        > a <- c("a", "a", "a", "a", "a")
        > b <- c("b", "b", "b", "b", "b")
        > ifelse(c(TRUE, FALSE, TRUE, FALSE, TRUE), a, b)
        [1] "a" "b" "a" "b" "a"

    else if 
        if (x == "a")
            "camel"
        else if (x == "b")
            "bear"
        else if (x == "c")
            "camel"
        else
            "moose"
Loops:
        repeat expression:
            repeat {if (i > 25) break else {print(i); i <- i + 5;}
        while (condition) expression:
            while (i <= 25) {print(i); i <- i + 5}  
                you can use break to stop
        for (var in list) expression:
                for (i in seq(from=5, to=25, by=5)) print(i)

函数:
    定义:
        function(arguments) body
            f <- function(x, y) {x + y} 
            you can use return
    调用:
            f(1,2)

Functions as Arguments:
        The sapply function iterates through each element in a vector,:
            > a <- 1:7
            > sapply(a, sqrt)
        lapply     : return list datatyep
Anonymous Functions:

归约函数: 类似map reduce
        plyr函数家族
        sightings.counts<-ddply(ufo.us,.(USState,YearMonth), nrow)
            use the nrow function to reduce the data by the number of rows 
                    in each group:
    
Properties of Functions:
        see the set of arguments, use the args function
            args(f)
            body(f)
自带函数:
        is(x, "numeric")
        seq(from=5, to=25, by=5)
                [1] 5 10 15 20 25
        length(w) <- 5
        create a sequence of dates using the seq.Date function:
            date.range<-seq.Date(from=as.Date(min(ufo.us$DateOccurred)), 
                        to=as.Date(max(ufo.us$DateOccurred)), by="month")
            date.strings<-strftime(date.range, "%Y-%m")
    order返回 排序后的下标 
        > add <- c(1,32,4,3,23,4,4)
        > order(add)
        [1] 1 4 3 6 7 5 2
        









