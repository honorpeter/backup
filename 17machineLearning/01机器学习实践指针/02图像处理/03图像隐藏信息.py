#!/usr/bin/env python
#-*- coding: utf-8 -*-
#code:myhaspl@qq.com

#图像隐藏 原理: 首先从源图像中提取文字图像信息 并记录这个文字图像信息像素
#在图像矩阵中的位置 然后 对载体文件进行预处理 将蓝色像素值全部设为偶数
#最后 将记录的文字信息像素点在载体文件对象位置的蓝色像素值设置为奇数
# 解密信息为你过程: 提取载体文件中蓝色像素值为奇数的像素点 将空白图像中这些
# 像素点对象的位置富裕同一的着色
import cv2
import numpy as np


#含有文字的图像 
fn1="pic1.jpg"
#载体文件
fn2="pic2.jpg"
#含有隐藏信息的载体文件
fn3="secret.png"
#添加的文字都为红色
redcolor=(0, 0, 255)    
if __name__ == '__main__':
    print u'正在处理中',
    img1 = cv2.imread(fn1)
    img2 = cv2.imread(fn2)

    w=img1.shape[1]
    h=img1.shape[0]  
   

    #加上需要隐藏的消息 红色
    cv2.putText(img1,"hello,world!", (20,300),cv2.FONT_HERSHEY_PLAIN, 3.0, redcolor, thickness = 2)
    cv2.putText(img1,"xiaolong ", (20,60),cv2.FONT_HERSHEY_PLAIN, 2.0, redcolor, thickness = 2) 
    cv2.putText(img1,"xiaoyan ", (1,90),cv2.FONT_HERSHEY_PLAIN, 2, redcolor, thickness = 1)     
    
    cv2.namedWindow('img1')     
    cv2.imshow('img1', img1)   
    cv2.namedWindow('img2-1')     
    cv2.imshow('img2-1', img2)    
    #处理隐藏目标图
    #将所有蓝色值变成奇数
    for j in xrange(0,h):
        for i in xrange(0,w):
            if (img2[j,i,0]%2)==1:
                img2[j,i,0]=img2[j,i,0]-1
        print '.',
        mirror_w=w/2
    #读取源图，并将信息写入目标图 判断是否为文字 看时候是红色
    for j in xrange(0,h):
        for i in xrange(0,w):
            if (img1[j,i,0],img1[j,i,1],img1[j,i,2])==redcolor:
                img2[j,i,0]=img2[j,i,0]+1
        print '.',
    #保存修改后的目标图，并显示
    cv2.namedWindow('img2-2')     
    cv2.imshow('img2-2', img2)         
    #保存到磁盘上
    cv2.imwrite(fn3, img2)      
    cv2.waitKey()
    cv2.destroyAllWindows()    
    
    
