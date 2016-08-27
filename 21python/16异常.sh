raise语句:
    raise Exception('hyperdrive overload')      引发带提示信息的异常
    raise Exception                             不带提示信息


内建异常类:
    Exception The base class for all exceptions
    AttributeError       Raised when attribute reference or assignment fails
    IOError             Raised when trying to open a nonexistent file 
                                    (among other things)
    IndexError          Raised when using a nonexistent index on a sequence
    KeyError            Raised when using a nonexistent key on a mapping
    NameError           Raised when a name (variable) is not found
    SyntaxError         Raised when the code is ill-formed
    TypeError           Raised when a built-in operation or function is 
                            applied to an object of the wrong type
    ValueError          Raised when a built-in operation or function is 
                            applied to an object with the correct type, 
                            but with an inappropriate value
    ZeroDivisionError   Raised when the second argument of a division or 
                            modulo operation is zero

自定义异常:
        lass SomeCustomException(Exception): pass   继承异常类便可

Catching Exception:
        try:
            x = input('Enter the first number: ')
            y = input('Enter the second number: ')
            print x/y
        except ZeroDivisionError:
            print "The second number can't be zero!"
        except TypeError:
            print "That wasn't a number, was it?"

Catching Two Exceptions with One Block:
        try:
            x = input('Enter the first number: ')
            y = input('Enter the second number: ')
            print x/y
        except (ZeroDivisionError, TypeError, NameError):
            print 'Your numbers were bogus...'

Catching the Object:
        try:
            x = input('Enter the first number: ')
            y = input('Enter the second number: ')
            print x/y
        except (ZeroDivisionError, TypeError), e:
            print e
        except:     Catch any Exception
            print 'Something wrong happened...'


        In Python 3.0, the except clause will be written except
                                (ZeroDivisionError, TypeError) as e .

Finally:
        x = None
        try:
            x = 1/0
        finally:
            print 'Cleaning up...'
            del x









