read.delim()
        ufo<-read.delim("/ufo_awesome.tsv", sep="\t", stringsAsFactors=FALSE, header=FALSE, na.strings="")
        the default setting for all read.* functions is to convert strings 
                to factor types.
        the first row is not is column header so header=FALSE
        many empty elements in the data, and we want to set those to the
                special R value NA

访问 列名:
        name(ufo) <- c("people")        赋值
            
