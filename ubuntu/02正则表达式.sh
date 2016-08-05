bash下 使用正则表达式 操作文件：
    rm .*~              删除以.开头～结尾的所有的文件
                        这里的.表示匹配的字符 *表示任意多个字符

    git rm  .*~         可以 但是*~不管用啊


    find your-directory/ -name '.*~' -delete
                    删除该目录下 以及子目录下的匹配到的所有文件

    ls | grep -P "^A.*[0-9]{2}$" | xargs -d"\n" rm
            ls lists all files (one by line since the result is piped).
            grep -P "^A.*[0-9]{2}$" filters the list of files and leaves 
                only those that match the regular expression ^A.*[0-9]{2}$
            .* indicates any number of occurrences of ., where . is a 
                        wildcard matching any character.
            [0-9]{2} indicates exactly two occurrences of [0-9], that is, 
                        any digit.
            xargs -d"\n" rm executes rm line once for every line that is 
                        piped to it.
            
