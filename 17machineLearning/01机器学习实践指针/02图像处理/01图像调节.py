#!/usr/bi/env python
# coding: utf-8

import cv2
import numpy as np

fn="hh.jpg"

if __name__ == '__main__':
    print 'loading %s....' % fn
    print u'正在处理',
    img = cv2.imread(fn)
    w = img.shape[1]
    h = img.shape[0]
    ii = 0

    #将全部彩色变暗  像素值降为原来的 20%
    #for xi in xrange(0,w):
        #for xj in xrange (0,h):
            #img[xj,xi,0] = int(img[xj,xi,0]*0.2)
            #img[xj,xi,1] = int(img[xj,xi,1]*0.2)
            #img[xj,xi,2] = int(img[xj,xi,2]*0.2)
        #if xi%10 == 0 : print '.',

    #将全部色彩变亮
    #for xi in xrange(0,w):
        #for xj in xrange (0,h):
            #img[xj,xi,0]= int(img[xj,xi,0]*1.1)
            #img[xj,xi,1]= int(img[xj,xi,1]*1.1)
            #img[xj,xi,2]= int(img[xj,xi,2]*1.1)
        #if  xi%10==0 :print '.',  

    #生成日落效果 将蓝色值和绿色值设为原来的70% 红色不变o
    #for xi in xrange(0,w):
        #for xj in xrange (0,h):
            #img[xj,xi,0]= int(img[xj,xi,0]*0.7)
            #img[xj,xi,1]= int(img[xj,xi,1]*0.7)
        #if  xi%10==0 :print '.',          

    
    #生成负片原理是: 将像素的三色值设置为 255-原值
    #生成底片
    #b, g, r = cv2.split(img)
    #b=255-b
    #g=255-g
    #r=255-r
    #直接通过索引改变色彩分量 
    #img[:,:,0]=b
    #img[:,:,1]=g
    #img[:,:,2]=r
    #加上水印  原理:调用putText函数 图像矩阵为第一个参数 输出内容为
        #第二个参数
    #cv2.putText(img,"machine learning", (20,20),cv2.FONT_HERSHEY_PLAIN, 2.0, (0, 0, 0), thickness = 2)
    #cv2.putText(img,"Support Vector Machines(SVMs)is an algorithm of machine learning.", (20,100),cv2.FONT_HERSHEY_PLAIN, 1.0, (0, 0, 0), thickness = 2)    
    
    sz1=w*5
    sz0=h*2
    #创建空白图像，然后将图片排列 
    myimg1=np.zeros((sz0,sz1,3), np.uint8)      
    #
    #逐个像素复制
    img_x=0
    img_y=0
    for now_y in xrange(0,sz0):
        for now_x in xrange(0,sz1):
            myimg1[now_y,now_x,0]=img[img_y,img_x,0]
            myimg1[now_y,now_x,1]=img[img_y,img_x,1]
            myimg1[now_y,now_x,2]=img[img_y,img_x,2]              
            img_x+=1
            if img_x>=w:
                img_x=0
        img_y+=1        
        if img_y>=h:
            img_y=0            
        print '.',
    cv2.namedWindow('img1')     
    cv2.imshow('img1', myimg1)    
    
    
    

    #cv2.namedWindow('img')
    #cv2.imshow('img', img)
    cv2.waitKey()
    cv2.destroyAllWindows()
    print ''
    print u'正在处理中',









