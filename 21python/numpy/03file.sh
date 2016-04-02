载入txt文件:
        traindata = loadtxt("data",delimiter = ',',usecols = (0,1,2,3),dtype = float)  

            import numpy as np
            arr = np.loadtxt('somefile.txt')
            np.savetxt('somenewfile.txt')

        # example.txt file looks like the following
            #
            # XR21 32.789 1
            # XR22 33.091 2
            table = np.loadtxt('example.txt',
            dtype='names': ('ID', 'Result', 'Type'),
            'formats': ('S4', 'f4', 'i2'))
            # array([('XR21', 32.78900146484375, 1),
            #
            ('XR22', 33.090999603271484, 2)],
            # dtype=[('ID', '|S4'), ('Result', '<f4'), ('Type', '<i2')])


    binary files:
                import numpy as np
                # Creating a large array
                data = np.empty((1000, 1000))
                # Saving the array with numpy.save
                np.save('test.npy', data)
                # If space is an issue for large files, then
                # use numpy.savez instead. It is slower than
                # numpy.save because it compresses the binary
                # file.
                np.savez('test.npz', data)
                # Loading the data array
                newdata = np.load('test.npy')









