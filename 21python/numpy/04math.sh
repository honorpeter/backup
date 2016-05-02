Math:
        Python comes with its own math module that works on Python 
                native objects.if you try to use math.cos on a NumPy array,
                it will not work, as the math functions are meant to 
                operate on elements
        numpy has a set of maths tools  work on list or array

    Linear Algebra:
        NumPy arrays do not behave like matrices in linear algebra 
                by default

            solving a system of equations
                    3x + 6y − 5z = 12
                    x − 3y + 2z = −2
                    5x − y + 4z = 10
                use matrix:
                    import numpy as np
                    # Defining the matrices
                    A = np.matrix([[3, 6, -5],
                    [1, -3, 2],
                    [5, -1, 4]])
                    B = np.matrix([[12],
                    [-2],
                    [10]])
                    # Solving for the variables, where we invert A
                    X = A ** (-1) * B
                    print(X)
                    # matrix([[ 1.75],
                    # [ 1.75],
                    # [ 0.75]])
                Not all matrices are invertible:using numpy.linalg.svd which
                usually works well inverting poorly conditioned matrices.

                use array:
                    import numpy as np
                    a = np.array([[3, 6, -5],
                    [1, -3, 2],
                    [5, -1, 4]])
                    # Defining the array
                    b = np.array([12, -2, 10])
                    # Solving for the variables, where we invert A
                    x = np.linalg.inv(a).dot(b)
                    print(x)
                    # array([ 1.75, 1.75, 0.75])
            Which one is best:
                    matrix is simplest, array is the most practical
                    array less bugs and faster

    math函数:
        exp(z)  如果z为vector时 自动计算每个element的exp









