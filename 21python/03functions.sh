Define function:
        def test():
            print 'This is printed'
            return
            print 'This is not

        x = test()

    The Magic of Parameters
        some can not change some can change outside value
自带的函数:
        pow(2,3)
        abs(-10)
        rand(1.0/2.0):
            round rounds floating-point numbers to the nearest integer:

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










