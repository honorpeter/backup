os:  关于操作系统的模块：
导入：import os


函数：

        os.path.exists(filepath)
        os.mkdir(path)
        os.chdir(path)
        os.fchdir(fd)   fd 文件描述符
        os.getcwd()

    os.path:
        os.path.join(path, *paths)
             os.path.join("c:", "foo") represents a path relative to the 
             current directory on drive C: (c:foo), not c:\foo.
        os.path.abspath(path):
            Return a normalized absolutized version of the pathname path. 
        os.path.basename(path)
        os.path.dirname(path):
            Return the directory name of pathname path
        os.path.exists(path):
            Return True if path refers to an existing path
            Returns False for broken symbolic links.
        os.path.lexists(path)
            Return True if path refers to an existing path. 
            Returns True for broken symbolic links. 
        os.path.getmtime(path):
            Return the time of last modification of path
        os.path.getsize(path):
            Return the size, in bytes, of path
        os.path.isabs(path):
            Return True if path is an absolute pathname.
        os.path.isfile(path):
        os.path.isdir(path)
        os.path.islink(path)
        os.path.ismount(path)
        os.path.normcase(path)
        os.path.split(path)
            Split the pathname path into a pair
        os.path.walk(path, visit, arg)

        











