import scipy.io as sio  

        matfn = '/home/weiliu/workspace/python/matlab/mat4py.mat'  
        #加载数据
        data = sio.loadmat(matfn)  
        print('Information for mat4py.mat ')  
        print(data)  
        print('\nThe vaulue of mat4py:')  
        print(data['mat4py'])  
        mat4py_load = data['mat4py']  
        x = [1, 2, 3]  
        y = [4, 5, 6]  
        z = [7, 8, 9]  
        #保存数据
        sio.savemat('saveddata.mat', {'x': x,'y': y,'z': z}) 

matlab中的date num类型 转换为python的时间类型：
        from datetime import datetime,timedelta
        python_datetime = datetime.fromordinal(int(matlab_datenum)) + timedelta(days=matlab_datenum%1) - timedelta(days = 366)
        


