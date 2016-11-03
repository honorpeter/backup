#!/usr/bin/env python
# -*- coding: utf-8 -*-
#code:myhaspl@qq.com
#7-1.py
import numpy as np
b=0
a=0.5   #修正系数
x = np.array([[b,1,1],[b,1,0],[b,0,0],[b,0,1]])
d =np.array([1,1,0,1])
w=np.array([b,0,0])
def sgn(v):
        if v>0:
                return 1
        else:
                return 0
def comy(myw,myx):  #计算感知器的输出 y(n) = sgn(w(n).T * x(n))
        return sgn(np.dot(myw.T,myx))
def neww(oldw,myd,myx,a):       #更新算法  w(n+1)=w(n) + a(d(n) - y(n))x(n)
                                #a为 修正系数   x(n)输入量 w(n)权值向量
        return oldw+a*(myd-comy(oldw,myx))*myx
i=0
for xn in x:
        w=neww(w,d[i],xn,a)
        i+=1

        
for xn in x:
        print "%d or %d => %d "%(xn[1],xn[2],comy(w,xn))
