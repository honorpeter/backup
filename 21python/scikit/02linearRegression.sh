Simple linear regression:
        >>> from sklearn.linear_model import LinearRegression
        >>> # Training data
        >>> X = [[6], [8], [10], [14],[18]]
        >>> y = [[7], [9], [13], [17.5], [18]]
        >>> # Create and fit the model
        >>> model = LinearRegression()
        >>> model.fit(X, y)
        >>> print 'A 12" pizza should cost: $%.2f' % model.predict([12])[0]
            A 12 pizza should cost: $13.68
        The sklearn.linear_model.LinearRegression class is an estimator
        All estimators implement the fit() and predict() methods.

    test:      使用score进行 平方和测试 r-squared value 越接近1效果越好
                R平方 = 1 - SS(res)/SS(tot)
                SS(res) = 预测值 - 原来值  的平方和
                SS(tot) =  测试集方差
        >>> from sklearn.linear_model import LinearRegression
        >>> X = [[6], [8], [10], [14], [18]]
        >>> y = [[7], [9], [13], [17.5], [18]]
        >>> X_test = [[8], [9],
        [11], [16], [12]]
        >>> y_test = [[11], [8.5], [15], [18], [11]]
        >>> model = LinearRegression()
        >>> model.fit(X, y)
        >>> print 'R-squared: %.4f' % model.score(X_test, y_test)

Multiple linear regression:
            Y = XB
            B = (X.T*X)**-1*X.TY    -1次方
            use numpy:
            >>> from numpy.linalg import inv
            >>> from numpy import dot, transpose
            X = [[1, 6, 2], [1, 8, 1], [1, 10, 0], [1, 14, 2], [1, 18, 0]]
            >>> y = [[7], [9], [13], [17.5], [18]]
            >>> print dot(inv(dot(transpose(X), X)), dot(transpose(X), y))
            or  provides a least squares function
            >>> from numpy.linalg import lstsq
            X = [[1, 6, 2], [1, 8, 1], [1, 10, 0], [1, 14, 2], [1, 18, 0]]
            >>> y = [[7], [9], [13], [17.5], [18]]
            >>> print lstsq(X, y)[0]

    sklearn:
            >>> from sklearn.linear_model import LinearRegression
            >>> X = [[6, 2], [8, 1], [10, 0], [14, 2], [18, 0]]
            >>> y = [[7], [9], [13], [17.5], [18]]
            >>> model = LinearRegression()
            >>> model.fit(X, y)
            >>> X_test = [[8, 2], [9, 0], [11, 2], [16, 2], [12, 0]]
            >>> y_test = [[11], [8.5], [15], [18], [11]]
            >>> predictions = model.predict(X_test)
            >>> for i, prediction in enumerate(predictions):
            >>> print 'Predicted: %s, Target: %s' % (prediction, y_test[i])
            >>> print 'R-squared: %.2f' % model.score(X_test, y_test)
            Predicted: [ 10.0625], Target: [11]
            Predicted: [ 10.28125], Target: [8.5]
            Predicted: [ 13.09375], Target: [15]
            Predicted: [ 18.14583333], Target: [18]
            Predicted: [ 13.3125], Target: [11]
            R-squared: 0.77


Polynomial regression:
    Quadratic regression:
        先将数据变为二次的数据 然后在进行线性回归 运算
            >>> import numpy as np
            >>> import matplotlib.pyplot as plt
            >>> from sklearn.linear_model import LinearRegression
            >>> from sklearn.preprocessing import PolynomialFeatures
            >>> X_train = [[6], [8], [10], [14], [18]]
            y_train = [[7], [9], [13], [17.5], [18]]
            X_test = [[6], [8], [11], [16]]
            y_test = [[8], [12], [15], [18]]
            >>> regressor = LinearRegression()
            regressor.fit(X_train, y_train)
            xx = np.linspace(0, 26, 100)
            yy = regressor.predict(xx.reshape(xx.shape[0], 1))
            plt.plot(xx, yy)
            >>> quadratic_featurizer = PolynomialFeatures(degree=2)
            #将数据变为 二次的 然后在进行线性回归
            X_train_quadratic = quadratic_featurizer.fit_transform(X_train)
            >>> X_test_quadratic = quadratic_featurizer.transform(X_test)
            >>> regressor_quadratic = LinearRegression()
            >>> regressor_quadratic.fit(X_train_quadratic, y_train)
            >>> xx_quadratic = quadratic_featurizer.transform(xx.reshape(xx.
            shape[0], 1))
            plt.plot(xx, regressor_quadratic.predict(xx_quadratic), c='r',
            linestyle='--')
            >>> plt.title('Pizza price regressed on diameter')
            >>> plt.xlabel('Diameter in inches')
            >>> plt.ylabel('Price in dollars')
            >>> plt.axis([0, 25, 0, 25])
            >>> plt.grid(True)
            >>> plt.scatter(X_train, y_train)
            >>> plt.show()
            >>> print X_train
            >>> print X_train_quadratic
            >>> print X_test
            >>> print X_test_quadratic
            > print 'Simple linear regression r-squared', regressor.score(X_
            test, y_test)
            >>> print 'Quadratic regression r-squared', regressor_quadratic.
            score(X_test_quadratic, y_test)

Regularization:          overfiting
            Regularization adds information to a problem, often in the form
                 of a penalty against complexity, to a problem
            Ridge regression or Tikhonov regularization

Applying linear regression
        Load data:
            >>> import pandas as pd
            >>> df = pd.read_csv('winequality-red.csv', sep=';')
            >>> df.describe()
            Dataframe.describe() method calculates summary statistics for
                     each column of the dataframe
        Fitting and evaluating the model:
            split the data into training and testing sets
            >>> from sklearn.linear_model import LinearRegression
            import pandas as pd
            import matplotlib.pylab as plt
            from sklearn.cross_validation import train_test_split
            >>> df = pd.read_csv('wine/winequality-red.csv', sep=';')
            X = df[list(df.columns)[:-1]]
            y = df['quality']
            X_train, X_test, y_train, y_test = train_test_split(X, y)
            >>> regressor = LinearRegression()
            >>> regressor.fit(X_train, y_train)
            >>> y_predictions = regressor.predict(X_test)
            >>> print 'R-squared:', regressor.score(X_test, y_test)
            0.345622479617
                r-squared score of 0.35 indicates that 35 percent of the 
                    variance in the test set is explained by the model

        We can use cross-validation to produce a better estimate of 
                    the estimator's performance  '
            >>> import pandas as pd
            >>> from sklearn.cross_validation import cross_val_score
            >>> from sklearn.linear_model import LinearRegression
            >>> df = pd.read_csv('data/winequality-red.csv', sep=';')
            >>> X = df[list(df.columns)[:-1]]
            >>> y = df['quality']
            >>> regressor = LinearRegression()
            >>> scores = cross_val_score(regressor, X, y, cv=5)
            >>> print scores.mean(), scores
            0.290041628842 [ 0.13200871 0.31858135 0.34955348 0.369145
            0.2809196 ]
        The cross_val_score helper function allows us to easily perform 
            cross-validation using the provided data and estimator.
            We specified a five-fold cross validation using the cv keyword 
                argument, that is, each instance will be randomly assigned 
                to one of the five partitions. Each partition will be used 
                to train and test the model.  cross_val_score returns the 
                value of the estimator's score method for each round. The 
                r-squared scores range from 0.13 to 0.36! The mean of the 
                scores, 0.29, is a better estimate of the estimator's 
                predictive power than the r-squared score produced from a 
                single train / test split.
Fitting models with gradient descent:
        
            
                
                








