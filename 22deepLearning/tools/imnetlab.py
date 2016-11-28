#__author__ = 'bing'
import os
import random
import time
import re
#path1 = 'E:/table/tt/'
#

def writetxt(path):
    cls = 0
    #test_val.append(0)
    txt_val = open(path[:-5] + 'ful_val.txt','w')
    txt_train = open(path[:-5] + 'ful_train.txt','w')
    for file in os.listdir(path):
        path_t = path + file+'/'
        n = 1
        if cls%100==0:
            print cls
        if 300 < len(os.listdir(path_t)):
            for filename in os.listdir(path_t):
                if  n % 50 ==0:
                    txt_val.write(filename +' '+ str(cls)+'\n')
                else:txt_train.write(filename +' '+  str(cls)+'\n')
                n = n + 1
            cls = cls + 1
        elif 25 < len(os.listdir(path_t)):
            for filename in os.listdir(path_t):
                if n % 5 ==0:
                    txt_val.write(filename +' '+ str(cls)+ '\n')
                else:txt_train.write(filename +' '+  str(cls)+'\n')
                n = n + 1
            cls = cls + 1
    txt_train.close()
    txt_val.close()



if __name__ == '__main__':
    path = 'H:/imagenet/full/'
    print os.path.split(path),len(os.listdir(path))
    start_time = time.time()
    writetxt(path)
    end_time = time.time()
    print end_time-start_time


# #end = time.clock()

#
# #print end-start




