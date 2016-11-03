#!/usr/bin/env python
#-*- coding: utf-8 -*-

#算法描述:
        #把图像上的点分为不同的子集 这些子集往往属于隔离的点,连续的曲线或则
        #连续的曲线或则连续读的区域 将这些点按区域组成子集 提取子集的特征
            #后 将每个子集的特征作为图像的一个特征项来进行计算

    #1 样本特征 设图像分为m个区域 每个区域有n个像素 每个像素都在图像矩阵
            #中以红 绿 蓝来表示 且区域特征计算方式为
                #区域特征码= (红色分量均值,绿色分量均值,蓝色均值)
            #那么 样本特征码矩阵为3 m  即3行m列  3行为红绿蓝 
                #每列为各分量的区域特征码

    #2 类别特征码  这里为每个类准备了3个样本(学习的) 类别特征的计算方式为
        #类别特征码 = (3个样本红色分量均值,3ge样本绿色均值,3ge样本蓝色均值)
                    #将RGB 连接为一个向量 就是该类的特征值


        #计算出类别特征后 算法对样本学习完毕 当有未知图像需要分类是 首先
            #计算其图像的样本特征 然后将样本特征和类别特征映射为高位空间的
            #向量,最后计算这两个向量的余弦相似度 选择余弦相似度最大的类别
            #为未知图像对象的类别

#9-7.py
#余弦距离识别图片类型
import numpy as np

import cv2




print u'正在处理中'


w_fg=20
h_fg=15
picflag=3   #每一类中有3个样本
def readpic(fn):
    #返回图片特征码    分区只是简单 分一下   分为几个格子  每个格子就一个区 
    fnimg = cv2.imread(fn)
    img=cv2.resize(fnimg,(800,600))
    w=img.shape[1]  
    h=img.shape[0]  
    w_interval=w/w_fg
    h_interval=h/h_fg 
    alltz=[]
    alltz.append([])
    alltz.append([])
    alltz.append([])
    for now_h in xrange(0,h,h_interval):
        for now_w in xrange(0,w,w_interval):
            b = img[now_h:now_h+h_interval,now_w:now_w+w_interval,0]
            g = img[now_h:now_h+h_interval,now_w:now_w+w_interval,1]
            r = img[now_h:now_h+h_interval,now_w:now_w+w_interval,2]
            btz=np.mean(b)
            gtz=np.mean(g)
            rtz=np.mean(r)
            alltz[0].append(btz)
            alltz[1].append(gtz)
            alltz[2].append(rtz)
    return alltz
        
def get_cossimi(x,y):
    myx=np.array(x)
    myy=np.array(y)
    cos1=np.sum(myx*myy)
    cos21=np.sqrt(sum(myx*myx))
    cos22=np.sqrt(sum(myy*myy))
    return cos1/float(cos21*cos22)
    
#x和d样本初始化
train_x =[] #保存这每类的特征值
d=[]

#读取图片，提取每类图片的特征
for ii in xrange(1,picflag+1):
    smp_x=[]
    b_tz=np.array([0,0,0])
    g_tz=np.array([0,0,0])
    r_tz=np.array([0,0,0])
    mytz=np.zeros((3,w_fg*h_fg))
    for jj in xrange(1,3):
        fn='p'+str(ii)+'-'+str(jj)+'.png'
        tmptz=readpic(fn)
        mytz+=np.array(tmptz)
    mytz/=3
    train_x.append(mytz[0].tolist()+mytz[1].tolist()+mytz[2].tolist())

fn='ptest3.png'
testtz=np.array(readpic(fn))
simtz=testtz[0].tolist()+testtz[1].tolist()+testtz[2].tolist()
maxtz=0
nowi=0
for i in xrange(0,picflag):
    nowsim=get_cossimi(train_x[i],simtz)
    if nowsim>maxtz:
        maxtz=nowsim
        nowi=i        
print u'%s属于第%d类'%(fn,nowi+1)

fn='ptest1.png'
testtz=np.array(readpic(fn))
simtz=testtz[0].tolist()+testtz[1].tolist()+testtz[2].tolist()
maxtz=0
nowi=0
for i in xrange(0,picflag):
    nowsim=get_cossimi(train_x[i],simtz)
    if nowsim>maxtz:
        maxtz=nowsim
        nowi=i        
print u'%s属于第%d类'%(fn,nowi+1)
        
fn='ptest2.png'
testtz=np.array(readpic(fn))
simtz=testtz[0].tolist()+testtz[1].tolist()+testtz[2].tolist()
maxtz=0
nowi=0
for i in xrange(0,picflag):
    nowsim=get_cossimi(train_x[i],simtz)
    if nowsim>maxtz:
        maxtz=nowsim
        nowi=i        
print u'%s属于第%d类'%(fn,nowi+1)












