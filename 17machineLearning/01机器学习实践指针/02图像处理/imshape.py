#!/usr/bin/env python
# coding: utf-8

import numpy as np
import cv2

fn = "hh.jpg"

if __name__ == '__main__':
    print 'loading %s ..' % fn
    img = cv2.imread(fn)
    #获取图像矩阵大小
    sp = img.shape

    print sp

    # hight 
    sz1 = sp[0]
    # wight
    sz2 = sp[1]
    
    print 'widht: %d \n height:%d' %(sz2,sz1)










