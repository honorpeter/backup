#!/usr/bin/env python
#-*- coding: utf-8 -*-

#上一个程序的 容错 能力不行 当图片的质量不好的时候 就不行了
# 加大阀值 10-200   可以提高一下容错能力

# 欧式距离匹配: 强噪声图像匹配
#   在目标图像中加入500000不同颜色的噪声点
    #算法核心:   设图像矩阵有n个元素 用n个元素值(x1,x2..xn) 组成该图像的
                #特征组 特征组形成了n维空间 特征组中的特征码构成每一维的数值
                #在n维空间下 两个矩阵各形成了一个点 然后计算这两个点之间的
                #距离 距离最小值 为最匹配的图像

#大量噪声定位图片

import cv2
import numpy as np

print 'http://blog.csdn.net/myhaspl'  
print 'myhaspl@qq.com'  
print  
print 'loading  ...'

def get_EuclideanDistance(x,y):  
    myx=np.array(x)  
    myy=np.array(y)  
    return np.sqrt(np.sum((myx-myy)*(myx-myy)))  
    
def findpic(img,findimg,h,fh,w,fw):
    minds=1e8
    mincb_h=0
    mincb_w=0
    for now_h in xrange(0,h-fh):
        for now_w in xrange(0,w-fw):
            my_img=img[now_h:now_h+fh,now_w:now_w+fw,:]#注意这里 不同 
            my_findimg=findimg  
            dis=get_EuclideanDistance(my_img,my_findimg)
            if dis<minds:   
                mincb_h=now_h
                mincb_w=now_w                
                minds=dis
        print ".",   
    findpt=mincb_w,mincb_h
    cv2.rectangle(img, findpt, (findpt[0]+fw,findpt[1]+fh),(0,0,255))    
    return img
 

def showpiclocation(img,findimg):
    #定位图片
    w=img.shape[1]  
    h=img.shape[0]  
    fw=findimg.shape[1]
    fh=findimg.shape[0]
    return findpic(img,findimg,h,fh,w,fw)

def addnoise(img):  #添加噪声
    coutn=500000
    for k in xrange(0,coutn):  
        xi = int(np.random.uniform(0,img.shape[1]))  
        xj = int(np.random.uniform(0,img.shape[0]))  
        img[xj,xi,0]= 255 *np.random.rand() 
        img[xj,xi,1]= 255 *np.random.rand()   
        img[xj,xi,2]= 255 *np.random.rand()  

fn='pictest.png'
fn1='pictestt1.png'
fn2='pictestt2.png'
myimg=cv2.imread(fn)
myimg1=cv2.imread(fn1)
myimg2=cv2.imread(fn2)
addnoise(myimg)
myimg=showpiclocation(myimg,myimg1)
myimg=showpiclocation(myimg,myimg2)
cv2.namedWindow('img')       
cv2.imshow('img', myimg)   
cv2.waitKey()  
cv2.destroyAllWindows() 
    


