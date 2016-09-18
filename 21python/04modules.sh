import:
        import math
                import all the module
        from math import sqrt       
                import just the sqrt function
                can use the function without its module prefix.

        修改加载路径：
            方法一:函数添加
                1 import sys
                2 查看sys.path
                3 添加sys.path.append("c:\\")

            方法二:修改环境变量
                w用户可以修改系统环境变量PYTHONPATH

            方法三:增加.pth文件，推荐！
                在site-packages添加一个路径文件，如mypkpath.pth，必须以
                    .pth为后缀，写上你要加入的模块文件所在的目录名称就是了。
math:
        >>> import math
        >>> math.floor(32.9)    round a given number down
        32.0
        >>> sqrt(9)
        3.0     calculate the square root of a number
cmath and Complex Numbers:
        >>> import cmath
        >>> cmath.sqrt(-1)
        1j
random:   module
    random: 模块:
            random.random()用于生成一个0到1的随机符点数: 0 <= n < 1.0
            random.uniform(a, b)，用于生成一个指定范围内的随机符点数，
                两个参数其中一个是上限，一个是下限。如果a > b，则生成的
                随机数n: a <= n <= b。如果 a <b， 则 b <= n <= a。
            random.randint:
                random.randint(a, b)，用于生成一个指定范围内的整数。
                其中参数a是下限，参数b是上限，生成的随机数n: a <= n <= b
            random.randrange:
                random.randrange([start], stop[, step])，从指定范围内，
                按指定基数递增的集合中 获取一个随机数。如：random.randrange
                (10, 100, 2)，结果相当于从[10, 12, 14, 16, ... 96, 98]
                序列中获取一个随机数。
            random.choice:
                从序列中获取一个随机元素
                random.choice(sequence)。参数sequence表示一个有序类型。
                这里要说明一下：sequence在python不是一种特定的类型，而是泛
                指一系列的类型。list, tuple, 字符串都属于sequence
            random.shuffle:
                random.shuffle(x[, random])，用于将一个列表中的元素打乱。
                p=["Python","is","powerful","simple","andsoon..."]
                random.shuffle(p)
            random.sample:
                random.sample(sequence, k)，从指定序列中随机获取指定长
                度的片断。sample函数不会修改原有序列
            
        









