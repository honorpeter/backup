python自带的random随机模块：
    import random
        random.random()用于生成一个0到1的随机符点数: 0 <= n < 1.0

    random.uniform
        random.uniform的函数原型为：random.uniform(a, b)，用于生成一个指定
            范围内的随机符点数，两个参数其中一个是上限，一个是下限。如果
            a > b，则生成的随机数n: b <= n <= a。如果 a <b， 则 
            a <= n <= b。

    random.randint()的函数原型为：random.randint(a, b)，用于生成一个指定
        范围内的整数。其中参数a是下限，参数b是上限，生成的随机数n: 
        a <= n <= b
    random.randrange: ，从指定范围内，按指定基数递增的集合中 获取一个随机数

    random.choice:
        random.choice从序列中获取一个随机元素。其函数原型为：random.choice(sequence)。参数sequence表示一个有序类型

    random.shuffle:
            random.shuffle(x[, random])，用于将一个列表中的元素打乱。
    random.sample
        random.sample的函数原型为：random.sample(sequence, k)，从指定序列
        中随机获取指定长度的片断。sample函数不会修改原有序列
