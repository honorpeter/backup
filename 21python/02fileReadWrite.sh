Getting Input from the User:
        >>> x = input("x: ")
        x: 34
        >>> y = input("y: ")
        y: 42
        >>> print x * y
        1428
input vs. raw_input:
        raw_input, which treats all input as raw data and puts 
                it into a string:
        input, which treats as it is

Opening Files:
        file(name[, mode[, buffering]]) Opens a file and returns a file
                         object.
        open(name[, mode[, buffering]]) Alias for file;
                use open rather than file when opening a file.
        open(name[, mode[, buffering]])
            File Modes:
                'r' Read mode
                'w' Write mode
                'a' Append mode
                'b' Binary mode (added to other mode)
                '+' Read/write mode (added to other mode)

            Buffering:
                if it is 1 (or True), I/O is buffered in the memory
        The Basic File Methods:
                f = open('somefile.txt', 'w')
                f.write('Hello, ')  write in the end
                f.write('World!')
                f.close()

                >>> f = open('somefile.txt', 'r')
                >>> f.read(4)
                'Hell'
                >>> f.read()
                'o, World!'
            sys.stdin:
                # somescript.py
                import sys
                text = sys.stdin.read()
                words = text.split()
                wordcount = len(words)
                print 'Wordcount:', wordcount
            seek:
                >>> f = open(r'c:\text\somefile.txt', 'w')
                >>> f.write('01234567890123456789')
                >>> f.seek(5)
                >>> f.write('Hello, World!')
                >>> f.close()
                >>> f = open(r'c:\text\somefile.txt')
                >>> f.read()
                '01234Hello, World!89'
            Reading and Writing Lines:
                f.readline()
                >>> f = open(r'c:\text\somefile.txt')
                >>> for i in range(3):
                print str(i) + ': ' + f.readline(),
                0: Welcome to this file
                1: There is nothing here except
                2: This stupid haiku
                >>> f.close()
        Iterating over File Contents:
            Doing It Byte by Byte:
                f = open(filename)
                char = f.read(1)
                while char:
                process(char)
                char = f.read(1)
                f.close()
            One Line at a Time:
                f = open(filename)
                while True:
                line = f.readline()
                if not line: break
                process(line)
                f.close()
            Reading Everything:
                f = open(filename)
                for char in f.read():
                process(char)
                f.close()

                f = open(filename)
                for line in f.readlines():
                process(line)
                f.close()








