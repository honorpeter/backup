#!/usr/bin/env python
#-*- coding: utf-8 -*-
#code:myhaspl@qq.com
#9-12.py
#标准欧氏距离实现的人脸识别

'''
还可以 使用PCA 进行改进 也可以使用SVM来分类一下
'''

import cv2
import numpy as np


print 'loading  ...'
#请在本程序运行前检查opencv的目录是否为下面的OPCV_PATH值
OPCV_PATH=r"/home/xiaolong/Soft/opencv-3.0.0/data/haarcascades/haarcascade_frontalface_default.xml"


def get_EuclideanDistance(x,y):  
    myx=np.array(x)  
    myy=np.array(y)  
    return np.sqrt(np.sum((myx-myy)*(myx-myy)))*np.var(myx-myy)



def get_distance(img,findimg):
    newsize=(img.shape[1],img.shape[0])   
    fimg=cv2.resize(findimg,newsize)
    my_img=cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    my_fimg=cv2.cvtColor(fimg,cv2.COLOR_BGR2GRAY)
    return get_EuclideanDistance(my_img,my_fimg)


def findface(image):
    #人脸识别，获取脸在图片中的坐标
    face_cascade = cv2.CascadeClassifier('/home/xiaolong/Soft/opencv-3.0.0/data/haarcascades/haarcascade_frontalface_default.xml')

    img = cv2.imread(image)
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

    faces = face_cascade.detectMultiScale(gray, 1.3, 5)
    result = []
    for (x,y,w,h) in faces:
        cv2.rectangle(img,(x,y),(x+w,y+h),(255,255,255),10)
        result.append([(x,y), (x+w, y+h)])
    
    return result

    

    
fn='billall1.png'
fnt= 'billtest.png'

#获取脸在图片中的坐标
faceresult=findface(fn)
facet_result=findface(fnt)
    
myimg=cv2.imread(fn)
myimgt=cv2.imread(fnt)

#IT精英比尔盖茨
isface1=get_distance(myimg[faceresult[0][0][0]:faceresult[0][1][0],faceresult[0][0][1]:faceresult[0][1][1],:],myimgt[facet_result[0][0][0]:facet_result[0][1][0],facet_result[0][0][1]:facet_result[0][1][1],:])
isface2=get_distance(myimg[faceresult[1][0][0]:faceresult[1][1][0],faceresult[1][0][1]:faceresult[1][1][1],:],myimgt[facet_result[0][0][0]:facet_result[0][1][0],facet_result[0][0][1]:facet_result[0][1][1],:])
if isface1<isface2:
    cv2.rectangle(myimg, faceresult[0][0], faceresult[0][1],(255,0,255))     
    cv2.rectangle(myimgt, facet_result[0][0], facet_result[0][1],(255,0,255))    
else:  
    cv2.rectangle(myimg, faceresult[1][0], faceresult[1][1],(255,0,255))    
    cv2.rectangle(myimgt, facet_result[0][0], facet_result[0][1],(255,0,255))    

    
    
cv2.namedWindow('img')       
cv2.imshow('img', myimg)  
cv2.namedWindow('imgt')       
cv2.imshow('imgt', myimgt)   
cv2.waitKey()  
cv2.destroyAllWindows() 
    











