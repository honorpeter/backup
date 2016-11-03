Unlike the ndarray objects, matrix objects can and only will be two 
            dimensional
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
            np.asmatrix(mat)  

                solve(A,Y)  求解线性方程组

            np.dot(a,b)用来计算数组的点积；
            vdot(a,b)专门计算矢量的点积，
                和dot()的区别在于对complex数据类型的处理不一样；
            innner(a,b)用来计算内积；outer(a,b)计算外积
        计算PCA相关的:
                numpy.linalg.eigh(a, UPLO='L')
                        return 求特征值和特征向量  
                        Return the eigenvalues and eigenvectors of
                             a Hermitian or symmetric matrix.












