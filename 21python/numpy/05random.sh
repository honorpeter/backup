随机抽样 (numpy.random):
        rand(d0, d1, ..., dn)
            np.random.rand()        
                    返回一个值
            np.random.rand(3,2) 
                    返回维度为3,2的随机数数组 
        randn(d0, d1, ..., dn):     
                    返回一个样本，具有标准正态分布
                    也可以指定维度
        randint(low[, high, size]):
                    返回随机的整数，位于半开区间 [low, high)

Random sampling (numpy.random):
        
        rand(d0, d1, ..., dn)	
            Random values in a given shape. d0,d1,d2....
            Create an array of the given shape and propagate it with 
                random samples from a uniform distribution over [0, 1).

        randn(d0, d1, ..., dn)	
            Return a sample (or samples) from the 
                “standard normal” distribution.
            Two-by-four array of samples from N(3, 6.25):
                >>> 2.5 * np.random.randn(2, 4) + 3
                可以生成一个 均值为3 方差为6.25的正态分布
        randint(low[, high, size])	
            Return random integers from low (inclusive) to high (exclusive).
            >>> np.random.randint(5, size=(2, 4))
            array([[4, 0, 2, 1],
            [3, 2, 2, 0]])
        random_integers(low[, high, size])	
            Return random integers between low and high, inclusive.
        random_sample([size])	
            Return random floats in the half-open interval [0.0, 1.0).
        random([size])	
            Return random floats in the half-open interval [0.0, 1.0).
        ranf([size])	
            Return random floats in the half-open interval [0.0, 1.0).
        sample([size])	
            Return random floats in the half-open interval [0.0, 1.0).
        choice(a[, size, replace, p])	
            Generates a random sample from a given 1-D array ..
        bytes(length)	Return random bytes.
    
Distributions :各种分布函数 高斯分布 正太分布...

Random generator:
                









