#!/usr/bin/env python
#-*- coding: utf-8 -*-
#code:myhaspl@qq.com
'''
任务:
        通过某人的一张照片 在他与别人的合影中找到他

        算法描述:   过程
            读取两张图片 生成图像矩阵
            以两个图像矩阵为基础 调用OpenCV的相关函数完成人脸定位
            读取两张图片的人脸区域 生成人脸图像矩阵 并将人脸矩阵转化为
                灰度图
            比较分析人脸图像矩阵,找到相似的人脸

        2 欧式距离算法
            原理:
                将标准欧氏距离算法作为比较分析人脸图像矩阵方法
                首先,将两个人脸图像调征到指定大小
                接着, 用所包含像素的三元色数值组成特征组 
                然后 将特征组映射到高位空间的某个点
                最后 计算两个人脸图像的特征点映射到高维空间后的距离 以欧式
                    距离最小的为最匹配人脸
            
            '''
#9-11.py
#人脸定位 

import cv2




print 'loading  ...'

#请在本程序运行前检查opencv的目录是否为下面的OPCV_PATH值
#OPCV_PATH=r"D:/opencv/sources"
OPCV_PATH=r"/home/xiaolong/Soft/opencv-3.0.0/data/haarcascades/haarcascade_frontalface_default.xml"
 

'''
def findface(image):
    #人脸识别，获取脸在图片中的坐标
    grayscale = cv2.CreateImage((image.width, image.height), 8, 1)
    cv2.CvtColor(image, grayscale, cv2.CV_BGR2GRAY)
    cascade = cv.Load(OPCV_PATH)
    rect = cv.HaarDetectObjects(grayscale, cascade, cv.CreateMemStorage(), 1.015, 2,cv.CV_HAAR_DO_CANNY_PRUNING, (10,10))

    result = []
    for r in rect:
        result.append([(r[0][0], r[0][1]), (r[0][0]+r[0][2], r[0][1]+r[0][3])])

    return result
    '''
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

    
fn='facesb.png'
#my_img=cv.LoadImage(fn)

#获取脸在图片中的坐标
#faceresult=findface(my_img)
faceresult=findface(fn)

    
myimg=cv2.imread(fn)
for  ii in xrange(0,len(faceresult)):
    cv2.rectangle(myimg, faceresult[ii][0], faceresult[ii][1],(0,0,250))    


cv2.namedWindow('img')       
cv2.imshow('img', myimg)   
cv2.waitKey()  
cv2.destroyAllWindows() 
    

