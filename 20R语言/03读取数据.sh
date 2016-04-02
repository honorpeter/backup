read.delim()
        ufo<-read.delim("/ufo_awesome.tsv", sep="\t", stringsAsFactors=FALSE, header=FALSE, na.strings="")
        the default setting for all read.* functions is to convert strings 
                to factor types.
        the first row is not is column header so header=FALSE
        many empty elements in the data, and we want to set those to the
                special R value NA
read.table()
read.csv()

保存文件:
        write.csv(data,"filename")
        write.table()
访问 列名:
        name(ufo) <- c("people")        赋值
            

Entering Data Within R:
        Entering Data Using R Commands:
            salary <- c(18700000, 14626720, 14137500, 13980000, 12916666)

        Using the Edit GUI:
            edit:
                top.5.salaries <- edit(top.5.salaries)
            fix:
                fix function calls edit on its argument and then assigns 
                    the result to the same symbol in the calling environment
                fix(top.5.salaries)

        Saving and Loading R Objects:
            Saving Objects with save
                save(top.5.salaries,file="~/top.5.salaries.RData")
                load this object back into R:
                    load("~/top.5.salaries.RData")
                If you want to save every object in the workspace:save.image
                        save.image()

                ... A set of symbols that name the objects to be saved. 
                list Alternatively 
    Importing Data from External Files:
        Text Files:
                read.table(file, header, sep = , quote = , dec = , 
                row.names, col.names, as.is = , na.strings , colClasses , 
                nrows =, skip = , check.names = , fill = , strip.white = , 
                blank.lines.skip = , comment.char = , allowEscapes = , 
                flush = , stringsAsFactors = , encoding = )
            reads a text file into R and returns a data.frame object
                file The name of the file to open
                header A logical value indicating whether the first row of 
                        the file contains variable names.
                sep The character (or characters) separating fields.
                quote If character values are enclosed in quotes, 
                        this argument should specify the type of quotes.
                na.strings A character vector specifying values 
                        that should be interpreted as NA.
                    top.5.salaries <- read.table("top.5.salaries.csv",
                                header=TRUE, sep=",", quote="\"")
            functions that call read.table with different default options 
                    for these values 
                    page 148
    Fixed-width files:
            read a fixed-width format text file into a data frame
            read.fwf(file, widths, header = , sep = , skip = , 
                        row.names, col.names, n = ,buffersize = , ...)
                widths: An integer vector or a list of integer vectors
                mort06 <- read.fwf(file="MORT06.DUSMCPUB", widths= 
                    c(19,1,40,2,1,1,2,2,1,4,1,2,2,2,2,1,1,1,16,4,1,1,1,1,
                            34,1,1,4,3,1,3,3,2,283,2,1,1,1,1,33,3,1,1)
    Other functions to parse data:
            readLines(con = stdin(), n = -1L, ok = TRUE, warn = TRUE,
                 encoding = "unknown")
                 con: A character string (specifying a file or URL) or a 
                    connection containing the data to read.
            scan:
                scan(file = "", what = double(0), nmax = -1, n = -1, 
                sep = "", quote = if(identical(sep, "\n")) "" else "'\"", 
                dec = ".", skip = 0, nlines = 0, na.strings = "NA", 
                flush = FALSE, fill = FALSE, strip.white = FALSE, 
                quiet = FALSE, blank.lines.skip = TRUE, multi.line = TRUE, 
                comment.char = "", allowEscapes = FALSE, 
                encoding = "unknown")
                allows you to read data into a specifically defined data 
                        structure using the argument what .
Exporting Data: 
            write.table(x, file = "", append = FALSE, quote = TRUE, 
                sep = " ", eol = "\n", na = "NA", dec = ".", row.names = 
                TRUE, col.names = TRUE, qmethod = c("escape", "double"))
                append A logical value indicating whether to append the 
                        output to the end of an existing file
                eol A character value specifying the value to append on the 
                        end of each line. "\n"
            write.csv(...)
            write.csv2(...)
                
Import data from databases
                    
                










