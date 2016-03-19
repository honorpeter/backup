#!/usr/bin/env python
#-*- coding: utf-8 -*-
#算法描述   图像匹配: 在一个大的图像中 切下来一个小的图片 进行匹配位置
#    算法是基于像素的比较和计算来实现的方法 
#   差分矩阵求和: 差分矩阵= 图像A的矩阵数据-图像B的矩阵数据
#   算法过程:
#       首先计算两个图像的矩阵数据差异分析 分析图像的相似性 
        #然后 设置一个阀值进行比较 如果差分矩阵的所有元素之和在阀值之内 则
            #表示这两张图像是相似的 且描述了同一物体 另外:它要求两个图像的
            #大小相同 大小处理对于计算机来说方便

#code:myhaspl@qq.com
#9-1.py
#简单定位图片   为差分矩阵的和 小于1 便是

import cv2
import numpy as np

 
print 'loading  ...'

def showpiclocation(img,findimg):
    #定位图片
    w=img.shape[1]  
    h=img.shape[0]  
    fw=findimg.shape[1]
    fh=findimg.shape[0]
    findpt=None
    for now_h in xrange(0,h-fh):
        for now_w in xrange(0,w-fw):
            comp_tz=img[now_h:now_h+fh,now_w:now_w+fw,:]-findimg       
            if np.sum(comp_tz)<1:              
                findpt=now_w,now_h
        print ".",
    if  findpt!=None:
        cv2.rectangle(img, findpt, (findpt[0]+fw,findpt[1]+fh),(0,0,255))
    return img



fn='pictest.png'
fn1='pictestt1.png'
fn2='pictestt2.png'
myimg=cv2.imread(fn)
myimg1=cv2.imread(fn1)
myimg2=cv2.imread(fn2)

myimg=showpiclocation(myimg,myimg1)
myimg=showpiclocation(myimg,myimg2)
cv2.namedWindow('img')       
cv2.imshow('img', myimg)   
cv2.waitKey()  
cv2.destroyAllWindows() 
    


