# coding: utf-8

#__author__ = 'bing'
import os
import random
import time
import re
#path1 = 'E:/table/tt/'
#

def writetxt(path):
    cls = 0     #class标签 分类标签

    dir_name = os.path.dirname(path)
    txt_val = open(dir_name + 'val.txt','w')
    txt_train = open(dir_name + 'train.txt','w')

    for file in os.listdir(path):

        path_t = path +'/' + file+'/'
        files = os.listdir(path_t)

        if len(files) == 1:
            filename = file + '/' + files[0]
            txt_val.write(filename +" " + str(cls) +'\n')
            txt_train.write(filename  +" " + str(cls) +'\n')
        elif len(files) == 2:
            filename = file + '/' + files[0]
            txt_val.write(filename +" " + str(cls) +'\n')
            filename = file + '/' + files[1]
            txt_train.write(filename +" " + str(cls) +'\n')
        elif len(files) == 3:
            filename = file + '/' + files[0]
            txt_val.write(filename +" " + str(cls) +'\n')
            filename = file + '/' + files[1]
            txt_train.write(filename +" " + str(cls) +'\n')
            filename = file + '/' + files[2]
            txt_train.write(filename +" " + str(cls) +'\n')
        elif len(files) == 4:
            filename = file + '/' + files[0]
            txt_val.write(filename +" " + str(cls) +'\n')
            filename = file + '/' + files[1]
            txt_train.write(filename +" " + str(cls) +'\n')
            filename = file + '/' + files[2]
            txt_train.write(filename +" " + str(cls) +'\n')
            filename = file + '/' + files[3]
            txt_train.write(filename +" " + str(cls) +'\n')
        elif len(files) >= 5:

            for filename_line in files:
                if random.randint(1,10) == 1:
                    filename =  file + '/' + filename_line
                    txt_val.write(filename +" " + str(cls) +'\n')
                else:
                    filename =  file + '/' + filename_line
                    txt_train.write(filename +" " + str(cls) +'\n')
        cls = cls + 1

    txt_train.close()
    txt_val.close()



if __name__ == '__main__':
    path = 'lfw'
    print os.path.split(path),len(os.listdir(path))
    start_time = time.time()
    writetxt(path)
    end_time = time.time()
    print end_time-start_time


# #end = time.clock()

#
# #print end-start




