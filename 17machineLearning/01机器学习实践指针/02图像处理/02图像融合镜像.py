#!/usr/bin/env python
# coding: utf-8

#图像融合原理是 让新图像的每个像素成为两个源图像中对象像素平均值之和
#即将原图像乘以50% 相加

import cv2
import numpy as np

fn1="pic1.jpg"
fn2="pic2.jpg"
if __name__ == '__main__':
    
    print 'working',
    myimg1 = cv2.imread(fn2)
    myimg2 = cv2.imread(fn1)    
    w=myimg1.shape[1]
    h=myimg1.shape[0]
    sz1 = w
    sz0 = h
    
    #每个像素为2个像素的平均值
    for y in xrange(0,sz0):
        for x in xrange(0,sz1):
            myimg2[y,x,:]=myimg1[y,x,:]*0.5+myimg2[y,x,:]*0.5

            print ',',
                

    cv2.namedWindow('img2')     
    cv2.imshow('img2', myimg2)    
    cv2.waitKey()
    cv2.destroyAllWindows()
    
    

fn="pic1.jpg"

if __name__ == '__main__':
    print 'http://blog.csdn.net/myhaspl'
    print 'myhaspl@qq.com'
    print
    print 'loading %s ...' % fn
    print '正在处理中',
    img = cv2.imread(fn)
    w=img.shape[1]
    h=img.shape[0]    
    ii=0
    #关于纵向生成镜像
    #
    mirror_w=w/2
    for j in xrange(0,h):
        for i in xrange(0,mirror_w):
            img[j,i,:]=img[j,w-i-1,:]
        print '.',
    cv2.namedWindow('img')     
    cv2.imshow('img', img)    
    cv2.waitKey()
    cv2.destroyAllWindows()



fn="pic1.jpg"

#图像灰度化
#求出每个像素点的R G B三个分量的平均值 然后将这这个平均值付给这三个分量


if __name__ == '__main__':
    print 'http://blog.csdn.net/myhaspl'
    print 'myhaspl@qq.com'
    print
    print 'loading %s ...' % fn
    img = cv2.imread(fn)
    sp=img.shape
    print sp
    #height
    sz1=sp[0]
    #width
    sz2=sp[1]
    print 'width:%d\nheight:%d'%(sz2,sz1)
    #创建一个窗口并显示图像
    cv2.namedWindow('img')     
    cv2.imshow('img', img)
    #复制图像
    myimg2= img.copy();
    cv2.namedWindow('myimg2')     
    cv2.imshow('myimg2', myimg2)    

    #复制并转换为黑白图像
    myimg1=cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)#本函数
    cv2.namedWindow('myimg1')     
    cv2.imshow('myimg1', myimg1) 
    cv2.waitKey()
    cv2.destroyAllWindows()



#图像加噪  随便加点像素值
fn="test1.jpg"

if __name__ == '__main__':
    print 'http://blog.csdn.net/myhaspl'
    print 'myhaspl@qq.com'
    print
    print 'loading %s ...' % fn
    img = cv2.imread(fn)
    coutn=100000
    for k in xrange(0,coutn):
	    xi = int(np.random.uniform(0,img.shape[1]))
	    xj = int(np.random.uniform(0,img.shape[0]))
	    if img.ndim == 2: 
		    img[xj,xi] = 255
	    elif img.ndim == 3: 
		    img[xj,xi,0]= 25
		    img[xj,xi,1]= 20
		    img[xj,xi,2]= 20   
    cv2.namedWindow('img')     
    cv2.imshow('img', img) 
    cv2.waitKey()
    cv2.destroyAllWindows()    
    








