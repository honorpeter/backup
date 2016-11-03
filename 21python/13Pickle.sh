存储对象 (pickle包，cPickle包): 将内存中的对象保存到文本中
    可以序列化 内建的数据对象 也可以自己定义的数据类型
    pickle包
       (1) 将内存中的对象转换成为文本流
            import pickle

            # define class
            class Bird(object):
                have_feather = True
                way_of_reproduction  = 'egg'

            summer       = Bird()                 # construct an object
            #将对象序列化  使用pickle.dumps()方法可以将对象summer
            #转换成了字符串 picklestring(也就是文本流)。
            picklestring = pickle.dumps(summer)   # serialize object

            
            对象summer存储在文件a.pkl
            import pickle

            # define class
            class Bird(object):
                have_feather = True
                way_of_reproduction  = 'egg'

            summer       = Bird()         # construct an object
            fn           = 'a.pkl'
            with open(fn, 'w') as f:      # open file with write-mode
                picklestring = pickle.dump(summer, f)   
                                        # serialize and save object

        (2) 重建对象:
            首先，我们要从文本中读出文本，存储到字符串 (文本文件的输入输出)
            然后使用pickle.loads(str)的方法，将字符串转换成为对象。要记得
            此时我们的程序中必须已经有了该对象的类定义。
            import pickle

            # define the class before unpickle
            class Bird(object):
                have_feather = True
                way_of_reproduction  = 'egg'

            fn     = 'a.pkl'
            with open(fn, 'r') as f:
                summer = pickle.load(f)   # read file and build object

    cPickle包:
            cPickle包的功能和用法与pickle包几乎完全相同 (其存在差别的地方
            实际上很少用到)，不同在于cPickle是基于c语言编写的，速度是
            pickle包的1000倍。对于上面的例子，如果想使用cPickle包，我们
            都可以将import语句改为:

        import cPickle as pickle

            
                                









