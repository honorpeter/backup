#!/usr/bin/env python
#-*- coding: utf-8 -*-
#随机生成像素点

import numpy as np
import cv2

if __name__  == '__main__':
    #行数
    sz1 = 200
    #列数
    sz2 = 300

    #创建空白图像，然后将图片排列 
    img = np.zeros((sz1,sz2,3),np.uint8)
    post1 = np.random.randint(200,size=(2000, 1))
    post2 = np.random.randint(300,size=(2000, 1))

    #在随机位置处设置像素点值
    for i in range(2000):
        img[post1[i],post2[i],[0]] = np.random.randint(0,255)
        img[post1[i],post2[i],[1]] = np.random.randint(0,255)
        img[post1[i],post2[i],[2]] = np.random.randint(0,255)

    #显示图像
    cv2.imshow('preview',img)

    cv2.waitKey()

    cv2.destroyAllWindows()

            

