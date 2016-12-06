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

exec、eval详解:
        python 动态执行字符串代码片段（也可以是文件）
        exec_stmt ::=  "exec" or_expr ["in" expression ["," expression]]
        exec:
            的第一个表达式可以是：
                代码字符串
                文件对象
                代码对象
                tuple
        如果忽略后面的可选表达式,exec后面代码将在当前域执行
                >>> a=2
                >>> exec "a=1"
                >>> a
                1
        如果在表达式之后使用in选项指定一个dic，它将作为global和
                    local变量作用域
                >>> a=10
                >>> b=20
                >>> g={'a':6,'b':8}
                >>> exec "global a;print a,b" in g
                6 8
        如果in后详指定两个表达式，它们将分别用作global和local变量作用域

                >>> a=10
                >>> b=20
                >>> c=20
                >>> g={'a':6,'b':8}
                >>> l={'b':9,'c':10}
                >>> exec "global a;print a,b,c" in g,l
                6 9 10
        如果第一个表达式是tuple
            exec(expr, globals) #它等效与  exec expr in globals
            exec(expr, globals, locals) #它等效与  exec expr in globals,locals
    eval:
            eval通常用来执行一个字符串表达式，并返回表达式的值。
            eval(expression[, globals[, locals]])

            有三个参数，表达式字符串，globals变量作用域，locals变量作用域。
                        其中第二个和第三个参数是可选的。
            如果忽略后面两个参数，则eval在当前作用域执行。

                >>> a=1
                >>> eval("a+1")
                2
                >>>
            如果指定globals参数

                >>> a=1
                >>> g={'a':10}
                >>> eval("a+1",g)
                11
            如果指定locals参数

                >>> a=10
                >>> b=20
                >>> c=20
                >>> g={'a':6,'b':8}
                >>> l={'b':9,'c':10}
                >>> eval("a+b+c",g,l)
                25
            如果要严格限制eval执行，可以设置globals为__builtins__,这样 这个表达式只可以访问__builtin__ module

enumerate:函数：
        enumerate(sequence, start=0)
            returns a tuple containing a count (from start which defaults 
                to 0) and the values obtained from iterating over sequence
            >>> seasons = ['Spring', 'Summer', 'Fall', 'Winter']
            >>> list(enumerate(seasons))
            [(0, 'Spring'), (1, 'Summer'), (2, 'Fall'), (3, 'Winter')]
            >>> list(enumerate(seasons, start=1))
            [(1, 'Spring'), (2, 'Summer'), (3, 'Fall'), (4, 'Winter')]


yield:作用
        yield 的作用就是把一个函数变成一个 generator，带有 yield 的函数
            不再是一个普通函数，Python 解释器会将其视为一个 generator，
            调用 fab(5) 不会执行 fab 函数，而是返回一个 iterable 对象！在 
            for 循环执行时，每次循环都会执行 fab 函数内部的代码，执行到 
            yield b 时，fab 函数就返回一个迭代值，下次迭代时，代码从 
            yield b 的下一条语句继续执行，而函数的本地变量看起来和上次中
            断执行前是完全一样的，于是函数继续执行，直到再次遇到 yield。
         def fab(max): 
            n, a, b = 0, 0, 1 
            while n < max: 
                yield b 
                a, b = b, a + b 
                n = n + 1 

         def fab(max): 
            n, a, b = 0, 0, 1 
            while n < max: 
                 print b 
                a, b = b, a + b 
                n = n + 1 





