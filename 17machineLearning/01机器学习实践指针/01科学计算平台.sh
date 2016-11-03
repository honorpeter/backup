目前计算机处理较多的数学计算主要分为
    1 数值计算 以数值数组为运算对象 给出数值解 计算过程中可能会产生累计误差
         影响精确性  计算速度快 占用资源少
    
    2 符号计算  以符号对象和符号表达式为计算对象 给出解析解 运算不受误差累计
        计算指令简单 占用资源多 耗时G长

计算软件:
    Matlab
        数值计算 可视化编程......  money
    Octave 
        和Matlab相似    数值求解 线性和非线性问题   free
    Mathematica:
        数学系统  符号演算 数值计算 图形
    Maple
        强有力的符号计算能力 高精度的数字计算 灵活的图形显示和高效的编程
    SPSS
        统计分析 数据和文本挖掘 预测模型 和 决策优化
    R
        R语言用于 统计分析 绘图的语言
        也可以用做矩阵计算
    Numpy Scipy matplotlib 等python科学计算平台
        


    其他软件:
        opencv  图形操作软件 提供各种语言接口
        mylp基于Numpy/Scipy和GSL构建的Python模块 提供了高层函数和类
            允许使用少量代码完成复杂的分类 特征提取 回归 聚类...
        BeautifulSoup   
            python写的 一个HTMl/XMl的解析器 
        Neurolab
            python的神经网络库
        mlpy:
            提供了SVM算法的相关函数
                提供一下核函数
                    线性函数 linear
                    多项式函数 poly
                    径向函数    rbf
                    sigmoid函数 sigmoid
            

python各种库:
        导入库:
                from numpy import *
                or
                import numpy as np
        Numpy库:
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
            特殊数组:
                zeros 全为0 使用zeros函数创建
                ones       1    ones
                        ones((2,3,4),dtype=int16)  (2,3,4)是维度
                empty   近似为0  empty
            序列数组:
                arange函数  与python的range函数很相似
                    参数为 开始值 终止值 步长

                    linspace函数 创建等差序列数组:
                        起始值 终止值 元素数量
            输出数组:
                可以使用print输出numpy的数组对象
            数组索引:
                Numpy 每个元素都可以被访问到 索引从0开始
            数组运算:
                对应位置元素分别计算  
            数组拷贝:
                浅拷贝 
                    拷贝数组引用
                    b = a
                深拷贝 
                    d = a.copy()
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
        numpy.unique
                (ar, return_index=False, return_inverse=False, 
                                                    return_counts=False)
                        Find the unique elements of an array
                    >>> np.unique([1, 1, 2, 2, 3, 3])
                    array([1, 2, 3])
                    >>> a = np.array([[1, 1], [2, 3]])
                    >>> np.unique(a)
                    array([1, 2, 3])
        numpy.linalg.svd(a, full_matrices=1, compute_uv=1)
                        
        矩阵:
            Numpy的矩阵对象和数组对象相似 主要不同在于矩阵的计算
                遵循矩阵数学运算规律

            创建:
                B = matrix([1.2,32,3],[3,2,3])
                type(B)
            矩阵运算:
                常用的 转置 乘法 求逆
                B.T 装置
                B*A 乘法
                B.I 求逆

                solve(A,Y)  求解线性方程组
        内积：np.dot(a,b) 就可以来计算a，b的内积
        functions:
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
                    
    pylab matplotlib绘图
            sin函数 绘制:
                import numpy as np
                import matplotlib.pyplot as plt
                x = np.arange(0,5,0.1)
                y = np.sin(x)
                plt.plot(x,y)
                plt.show()


    cv2 绑定python绑定库 opencv
                
                










