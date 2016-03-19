访问 列名:
        name(ufo) <- c("people")        赋值
            可以修改列名
查看数据是否合适:
        head(user[which(user$zipCode == NA),5])
        head(user[which(nchar(user$zipCode) != 4),5])  查看一下数据是否合适
        也可以使用 summary decribe and str...查看

如果不合适处理数据:
        删除:  影响不大的情况下
            good.rows<-ifelse(nchar(ufo$DateOccurred)>!=8 | nchar(ufo$DateReported)!=8,FALSE, TRUE)
            length(which(!good.rows))
            [1] 371
            ufo<-ufo[good.rows,]        # 删除其他的
            
        use the subset function to create a new data frame
            ufo.us<-subset(ufo.us, DateOccurred>=as.Date("1990-01-01"))
            nrow(ufo.us)
                
 
