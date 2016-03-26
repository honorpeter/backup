安装包:
    先下载包
        如jieba  
        然后 python setup.py install    (setup.py jieba里面自带的)

python有的安装包:
    os:
        This module provides a portable way of using operating system 
            dependent functionality. If you just want to read or write a 
            file see open(), if you want to manipulate paths, see the 
            os.path module, and if you want to read all the lines in all 
            the files on the command line see the fileinput module. For 
            creating temporary files and directories see the tempfile module
            and for high-level file and directory handling see the shutil 
            module.
        Process Parameters:
            os.chdir(path)
            os.fchdir(fd)
            os.getcwd()
            os.getegid()
            geteuid()
            os.getgid()
            os.getgroups()
            os.initgroups(username, gid)¶
            os.getlogin()
            os.getpgid(pid)
            os.getpgrp()
            .....
            os.putenv(varname, value)
            os.getenv(varname[, value])
         File Object Creation:
            os.fdopen(fd[, mode[, bufsize]])
            os.popen(command[, mode[, bufsize]])
                    Open a pipe to or from command.
            os.tmpfile()¶
                    Return a new file object opened in update mode (w+b).
        File Descriptor Operations:
            os.close(fd)
            os.closerange(fd_low, fd_high)
                    Close all file descriptors from fd_low (inclusive) 
                    to fd_high (exclusive), ignoring errors. Equivalent to:
                    for fd in xrange(fd_low, fd_high):
                    try:
                        os.close(fd)
                    except OSError:
                        pass
            os.dup(fd)
                    Return a duplicate of file descriptor fd.
            ..... too much python can do everthing

         Files and Directories:
            os.walk(top, topdown=True, onerror=None, followlinks=False)
                Generate the file names in a directory tree by walking the 
                tree either top-down or bottom-up. For each directory in the
                tree rooted at directory top (including top itself), it 
                yields a 3-tuple (dirpath, dirnames, filenames).
               dirpath is a string, the path to the directory. 
               dirnames is a list of the names of the subdirectories in 
                    dirpath (excluding '.' and '..').
               filenames is a list of the names of the non-directory files 
                    in dirpath
            

                    









