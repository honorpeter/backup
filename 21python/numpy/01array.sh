mylp基于Numpy/Scipy和GSL构建的Python模块 提供了高层函数和类
    允许使用少量代码完成复杂的分类 特征提取 回归 聚类...
Neurolab
    python的神经网络库
mlpy:
    提供了SVM算法的相关函数
        提供一下核函数
            线性函数 linear
            多项式函数 poly
            径向函数    rbf
            sigmoid函数 sigmoid
            
Numpy库:    数组
            提供了ndarray数组对象 可以进行方面的计算和读取
                比python提供的数组array模块要强大

            创建数组
                可以使用array函数 参数为python的序列对象
                a = np.array([[1,23,4,],[3,4,3.]])
            ndarray拥有的属性:
                ndarray.ndim    数组行数
                ndarray.shape   维数
                ndarray.size     总数
                ndarray.dtype    元素类型
                ndarray.itemsize  每个元素占有的字节
                ndarray.data       数组元素的缓冲区

                X.flags    #数组的存储情况信息
            Converting ndarray to list
                larr = arr.tolist()

            特殊数组:
                zeros 全为0 使用zeros函数创建
                ones       1    ones
                        ones((2,3,4),dtype=int16)  (2,3,4)是维度
                empty   近似为0  empty
            序列数组:
                arange函数  与python的range函数很相似
                    参数为 开始值 终止值 步长 类型有dtype决定
                    range()函数python built-in function 返回integer

                    linspace函数 创建等差序列数组:
                        起始值 终止值 元素数量
            输出数组:
                可以使用print输出numpy的数组对象
            数组索引:
                Numpy 每个元素都可以被访问到 索引从0开始
            数组运算:
                对应位置元素分别计算  
                a - 1       数组a中的原始分别减去1
                a *2        数组a中的元素分别乘以2
                a **2       数组a中的元素分别 2次方
                2 ** a      数组a中的元素分别 2的几次方
            生成序列:
                    
                    c2=np.linspace(1,4,10)  
                    起点，终点，区间内点数。起点终点均包括在内
            数组拷贝:
                浅拷贝 
                    拷贝数组引用
                    b = a
                深拷贝 
                    d = a.copy()
        functions:
                finfo('float')
                        返回 float的最大值 最小值
                flatten():
                    >>> a = np.array([[1,2], [3,4]])
                    >>> a.flatten()
                    array([1, 2, 3, 4])
                vstack: join the np.array to one
                    Stack arrays in sequence vertically (row wise).
                    >>> a = np.array([1, 2, 3])
                    >>> b = np.array([2, 3, 4])
                    >>> np.vstack((a,b))
                    array([[1, 2, 3],
                        [2, 3, 4]])
                hstack:
                    Stack arrays in sequence horizontally (column wise).
                    >>> a = np.array((1,2,3))
                    >>> b = np.array((2,3,4))
                    >>> np.hstack((a,b))
                    array([1, 2, 3, 2, 3, 4])
                dstack:
                    Stack arrays in sequence depth wise (along third axis).
                    >>> a = np.array((1,2,3))
                    >>> b = np.array((2,3,4))
                    >>> np.dstack((a,b))
                    array([[[1, 2],
                            [2, 3],
                            [3, 4]]])
                    
                numpy.argsort(a, axis=-1, kind='quicksort', order=None)
                    Returns the indices that would sort an array.
                    a[index_array] yields a sorted a.
                    
                    >>> x = np.array([3, 1, 2])
                    >>> np.argsort(x)
                    array([1, 2, 0])
            asarray: (a, dtype=None, order=None)
                Convert the input to an array.

                Convert a list into an array:
                    >>> a = [1, 2]
                    >>> np.asarray(a)
                    array([1, 2])
                Existing arrays are not copied:
                If dtype is set,array is copied only if dtype does not match
            numpy.reshape(a, newshape, order='C')
                newshape : int or tuple of ints 
                The new shape should be compatible with the original shape. 
                 If an integer, then the result will be a 1-D array of that 
                    length.
                    -1 meaning all
            append:
                ...

            mean:
                mean(a, axis=None, dtype=None, out=None, keepdims=False)
                    axis : None or int or tuple of ints, optional
                        If this is a tuple of ints, a mean is performed over
                        multiple axes, instead of a single axis or all the 
                        axes as before. 
                    >>> a = np.array([[1, 2], [3, 4]])
                    >>> np.mean(a)
                    2.5
                    >>> np.mean(a, axis=0)
                    array([ 2.,  3.])
                    >>> np.mean(a, axis=1)
                    array([ 1.5,  3.5])
                    axis = 0 :column
                    axis = 1 : row
            求和，平均值，方差：比较简单，分别是np.sum(), np.mean(), 
                        max()   min()都可以这样用
                        np.var(), np.std()(这个是标准差)
        numpy.unique
                (ar, return_index=False, return_inverse=False, 
                                                    return_counts=False)
                        Find the unique elements of an array
                    >>> np.unique([1, 1, 2, 2, 3, 3])
                    array([1, 2, 3])
                    >>> a = np.array([[1, 1], [2, 3]])
                    >>> np.unique(a)
                    array([1, 2, 3])
        linalg:
                numpy.linalg.svd(a, full_matrices=1, compute_uv=1)
                numpy.linalg.norm(x, ord=None, axis=None, keepdims=False):
                        范数的计算工具:
                        np.linalg.norm(a,ord=None)  
                            #计算向量a的范数
                            
                    ord	norm for matrices	norm for vectors
                    None	Frobenius norm	2-norm
                    ‘fro’	Frobenius norm	–
                    ‘nuc’	nuclear norm	–
                    inf	max(sum(abs(x), axis=1))	max(abs(x))
                    -inf	min(sum(abs(x), axis=1))	min(abs(x))
                    0	–	sum(x != 0)
                    1	max(sum(abs(x), axis=0))	as below
                    -1	min(sum(abs(x), axis=0))	as below
                    2	2-norm (largest sing. value)	as below
                    -2	smallest singular value	as below
                    other	–	sum(abs(x)**ord)**(1./ord)
                numpy.linalg.eigh(a, UPLO='L')
                        return 求特征值和特征向量  
                        Return the eigenvalues and eigenvectors of
                             a Hermitian or symmetric matrix.
                np.linalg.cond(a,p=None)  
                    #矩阵a的条件数
                np.linalg.inv(a)  
                    #矩阵a的逆矩阵
                d1=np.linalg.companion(a)  
                        伴随矩阵
                e1=np.random.rand(3,2)  
                        #产生一个3行2列的随机数组

        exp()函数: 
                expm()使Pade近似算法、expm2()使用特征值分析算法、expm3()
                    使用泰勒级数算法。在numpy中，也有一个计算矩阵的函数：
                    funm(A,func)
                











