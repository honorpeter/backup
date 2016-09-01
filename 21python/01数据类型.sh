注释使用#

python基本数据类型:
        expression:
            ** is the power operator
                2 ** 3 = 8  
        数值型
            integer:        
                    // is integer division  in python3
                        in python2.7  must from __future__ import division
                    / is float division 
                    ex: 1//2 = 0    1/2 = 0.5  1.0 // 2.0 = 0
            long integer:
                        10000L
            double \ float
                可以使用 + - * / % .....
            如果计算中用到的浮点型  整型会自动转换

            复数运算:
                real + imagj
                2+9j
        字符串:
                使用双引号或则单引号扩起来
                "Hello, " + name + "!"      
                        + connect the strings
                String Representations, str and repr:
                    >>> print repr("Hello, world!")
                    'Hello, world!'
                    >>> print repr(10000L)
                    10000L
                    >>> print str("Hello, world!")
                    Hello, world!
                    >>> print str(10000L)
                    10000
                    A synonym for repr(x) is `x`:            
                        >>> print "The temperature is " + `temp`
                        The temperature is 42
                Long Strings, Raw Strings, and Unicode:
                        '''  comment '''
                Raw Strings:
                        don’t treat the backslash as a special character
                          at all. Every character you put into a raw string 
                          stays the way you wrote it
                        >>> print r'C:\nowhere'     \n doesn't wrok
                        C:\nowhere
                Unicode Strings:
                        >>> u'Hello, world!'
                        u'Hello, world!'
        Lists and Tuples:
                list 类型相乘  按倍数增加 元素个数
                    a = [12,3]
                    a *2 = [12,3,12,3]
                Sequence:
                    Indexing:
                        >>> greeting = 'Hello'
                        >>> greeting[0]
                        'H'             The last element is at position –1
                    Slicing:
                        greeting[1:4]
                    Longer Steps:
                        >>> numbers[0:10:2]
                        [1, 3, 5, 7, 9]
                        numbers[3:6:3]
                        [4]     the third is the step size
                        step size can be negative, which means extracting 
                            the elements from right to left: 
                    Adding Sequences:
                        [1, 2, 3] + [4, 5, 6]
                    Multiplication:
                        >>> 'python' * 5
                        'pythonpythonpythonpythonpython'
                        >>> [42] * 10
                        [42, 42, 42, 42, 42, 42, 42, 42, 42, 42]
                    Membership:
                        To check whether a value can be found in a sequence 
                            you use the in operator
                            >>> permissions = 'rw'
                            >>> 'w' in permissions
                            True
                    Length, Minimum, and Maximum:
                            len(a)
                            max(a)
                            min(a)
                Lists: Python’s Workhorse:
                    The list Function
                        >>> list('Hello')
                        ['H', 'e', 'l', 'l', 'o']
                        Note that list works with all kinds of sequences, 
                            not just strings.
                    Basic List Operations:
                        can perform all the standard sequence operations on 
                            lists, such as indexing, slicing, concatenating
                            and multiplying. But the interesting thing about
                            lists is that they can be modified.
                        Changing Lists: Item Assignments
                            x[1] = 2
                        Deleting Elements
                            del names[2]
                        Assigning to Slices:
                            name[2:] = list('ar')
                    List Methods:
                        append:
                            lst.append(4)
                        count:
                            The count method counts the occurrences of an 
                                element in a list:
                           ['to', 'be', 'or', 'not', 'to', 'be'].count('to')
                            2
                        extend:
                            append several values at once  it modified a
                            a = [1, 2, 3]
                            b = [4, 5, 6]
                            a.extend(b)
                        index:
                            searching lists to find the index of the first 
                                occurrence of a value:
                            >>> knights = ['We', 'are', 'the', 'knights', 'who', 'say', 'ni']
                            >>> knights.index('who')
                            4
                            如果没有找到 发生一个异常
                        insert:
                            numbers = [1, 2, 3, 5, 6, 7]
                            numbers.insert(3, 'four')
                        pop:
                            x = [1, 2, 3]
                            x.pop(0)
                            1   by default, the last one 
                        remove:
                            x.remove('be')
                            used to remove the first occurrence of a value
                        reverse:
                        sort:
                            >>> x = [4, 6, 2, 1, 7, 9]
                            >>> y = x.sort() # Don't do this!
                            >>> print y
                            None
                            sort modifies x but returns nothing
                            x = [4, 6, 2, 1, 7, 9]
                            y = x[:]
                        Advanced Sorting:
                            two other optional arguments: key and reverse
                            numbers.sort(cmp)  
                                                
                            x.sort(reverse=True) sorted in reverse
                遍历列表： 使用enumerate()函数
                        用于遍历序列中的元素以及它们的下标
                        寻找bar在list中的index
                        for i, j in enumerate(['foo', 'bar', 'baz']):
                            if j == 'bar':
                                print i
                        可以简写为：
                        [i for i, j in enumerate(['foo', 'bar', 'baz']) 
                                        if j == 'foo']
                        

                二维列表:
                        声明方式:
                            myList = [[0] * 3] * 4
                            [[]]是一个含有一个空列表元素的列表,所以[[]]*3
                                表示3个指向这个空列表元素的引用,修改任何
                        正确:
                             lists = [[] for i in range(3)] 
                             or
                             myList = [([0] * 3) for i in range(4)]

                            
                Tuples: Immutable Sequences:
                        Tuples are sequences, just like lists. 
                        The only difference is that tuples can’t be changed
                        >>> (1, 2, 3)
                        (1, 2, 3)
                    The tuple Function:
                        tuple([1, 2, 3])
                        (1, 2, 3)
                    Basic Tuple Operations:
                Stirngs format
                        format = "Hello, %s. %s enough for ya?"
                        >>> values = ('world', 'Hot')
                        >>> print format % values
                        Hello, world. Hot enough for ya?

                        c Single character (accepts an integer or a single 
                            character string)
                        r String (converts any Python object using repr)
                        s String (converts any Python object using str)
                        x X g f F G e E d i o u
                    Width and Precision:
                        >>> '%10f' % pi
                        ' 3.141593'
                        %10.2f' % pi
                        # Field width 10, precision 2
                        3.14'
                    Signs, Alignment, and Zero-Padding:
                        '%010.2f' % pi
                        '0000003.14'

                        A minus sign (-) left-aligns the value:
                        >>> '%-10.2f' % pi
                        '3.14
                Strings method:
                        find:
                            It returns the leftmost index where the
                                substring is found. If it is not found, –1 
                                is returned:
                        join:
                            >>> dirs = '', 'usr', 'bin', 'env'
                            >>> '/'.join(dirs)
                            '/usr/bin/env'
                        lower:
                            returns a lowercase version of the string:
                        replace:
                            >>> 'This is a test'.replace('is', 'eez')
                            'Theez eez a test'
                        split:
                            the inverse of join
                            >>> '1+2+3+4+5'.split('+')
                            ['1', '2', '3', '4', '5']
                        strip:
                            returns a string where whitespace on the left 
                                and right removed

        Dictionaries: When Indices Won’t Do
                Creating and Using Dictionaries
                    phonebook = {'Alice': '2341', 'Beth': '9102'}
                        Dictionaries consist of pairs (called items) of 
                            keys and their corresponding values
                            in this example names are the keys phone is v

                    the dic function
                        >>> items = [('name', 'Gumby'), ('age', 42)]
                        >>> d = dict(items)
                        >>> d
                        {'age': 42, 'name': 'Gumby'}
                Basic Dictionary Operations:
                    len(d) returns the number of items (key-value pairs) 
                    del d[k] deletes the item with key k.
                    k in d checks whether there is an item in d that has the
                        key k.
                    d[k] returns the value associated with the key k
                Dictionary Methods:
                    clear:
                        removes all items from the dictionary
                    copy:
                        a shallow copy, since the values themselves are 
                            the same, not copies
                    to make a deep copy:
                        from copy import deepcopy
                        dc = deepcopy(d)
                    fromkeys:
                        creates a new dictionary with the given keys, each 
                            with a default corresponding value of None
                    get:
                        is like []
                    has_key:
                        >>> d.has_key('name')
                        False
                    items and iteritems:
                        returns all the items of the dictionary as a list of
                        items in which each item is of the form (key, value)

                        The iteritems method works in much the same way, but
                            returns an iterator instead of a list:
                    keys and iterkeys:
                         like items and iteritems
                    pop:
                        >>> d = {'x': 1, 'y': 2}
                        >>> d.pop('x')
                        1
                    popitem:
                        which pops off the last element of a list
                        don't have no order
                    setdefault:
                        setdefault sets the value corresponding to the
                            given key if it is not already in the dictionary

                    对字典进行排序:
                        降序: 升序 去掉False
                        sorted(d.items(), lambda x, y: cmp(x[0], y[0]),\
                            reverse=True)
                        不改变d的值 重新生成一个值 list
                       重点是cmp x[这里面可以写0 1 2 代表按照排序的是第几个]
                            
                        
                    update:
                        The update method updates one dictionary with the 
                            items of another:
                        >>> d = {
                        'title': 'Python Web Site',
                        'url': 'http://www.python.org',
                        'changed': 'Mar 14 22:09:15 MET 2008'
                        }
                        >>> x = {'title': 'Python Language Website'}
                        >>> d.update(x)
                      可以使用下面的函数实现二维字典:
                        def addtwodimdict(thedict, key_a, key_b, val): 
                            if key_a in thedict:
                                thedict[key_a].update({key_b: val})
                            else:
                                thedict.update({key_a:{key_b: val}})
                    values and itervalues:
                        returns a list of the values in the dictionary (and
                        itervalues returns an iterator of the values). 
                        Unlike keys, the list returned by values may 
                        contain duplicates
                        
            集合 set
                使用方括号定义set集合 集合的特点是无重复元素 集合中的元素
                无先后顺序,也不能用索引进行管理
                    a = [1,23]
                    b = set(a)
                    b.add(32)
                    23 in b    判断是否有23
                    运算: & | 交 并 - ^ 差 对称差
                        
                
                        



repeated x times:
        特殊变量:
            "_" 表示刚计算的结果
            各种转义字符
    Hexadecimals and Octals and demical
            >>> 0xAF
            175
            and octal numbers like this:
            >>> 010
            8


