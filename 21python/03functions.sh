Define function:
        def test():
            print 'This is printed'
            return
            print 'This is not

        x = test()

    The Magic of Parameters
        some can not change some can change outside value

    访问全局变量:   
        如果想在函数中使用全局变量，则需要使用global进行声明
自带的函数:
        pow(2,3)
        abs(-10)
        rand(1.0/2.0):
            round rounds floating-point numbers to the nearest integer:
        range:
                range([start,] stop[, step])
                根据start与stop指定的范围以及step设定的步长，生成一个序列。
        xrange:
                xrange 用法与 range 完全相同，所不同的是生成的不是一个
                list对象，而是一个生成器    range 调用就在内存中生成好了
                xrange使用算法代替空间
                

    chang type:
        >>> int(math.floor(32.9))   change to the integer

    
        map(func, seq [, seq, ...]) Applies the function to all the 
                elements in the sequences
                >>> map(str, range(10)) # Equivalent to [str(i) for i 
                        in range(10)]
                ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
        filter(func, seq) Returns a list of those elements for which the 
                function is true
                >>> def func(x):
                ...
                return x.isalnum()
                ...
                >>> seq = ["foo", "x41", "?!", "***"]
                >>> filter(func, seq)
                ['foo', 'x41']
        reduce(func, seq [, initial]) Equivalent to func(func(func(seq[0], 
                seq[1]), seq[2]), ...)
                >>> numbers = [72, 101, 108, 108, 111, 44, 32, 119, 111, 114, 108, 100, 33]
                >>> reduce(lambda x, y: x+y, numbers)
                1161
        sum(seq)    Returns the sum of all the elements of seq
        apply(func[, args[, kwargs]]) Calls the function, optionally 
                supplying argument



    排序:
        sorted():
            sorted() 函数，它将返回一个经过排序的新列表 不改变原来的
            >>> sorted([5, 2, 3, 1, 4])
            [1, 2, 3, 4, 5]
            key 参数，该参数接受一个函数作为它的值，
                    可以通过那个函数定义排序应该遵循的规则
                >>> sorted("This is a test string from Andrew".split(), key=str.lower)
                ['a', 'Andrew', 'from', 'is', 'string', 'test', 'This']
        zip()
            zip([seql, ...])接受一系列可迭代对象作为参数，将对象中对应的
                元素打包成一个个tuple（元组），然后返回由这些tuples组成的
                list（列表）。
                1 >>> name=('jack','beginman','sony','pcky')
                2 >>> age=(2001,2003,2005,2000)
                3 >>> for a,n in zip(name,age):
                4     print a,n
                5 
                6 输出：
                7 jack 2001
                8 beginman 2003
                9 sony 2005
                10 pcky 2000

                 1 >>> z1=[1,2,3]
                2 >>> z2=[4,5,6]
                3 >>> result=zip(z1,z2)
                4 >>> result
                5 [(1, 4), (2, 5), (3, 6)


数学函数:






