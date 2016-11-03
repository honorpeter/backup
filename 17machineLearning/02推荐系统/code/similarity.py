#!/usr/bin/python
# coding:  utf-8

import sys
import math

#读取文件 并按照用户进行归约
def readFile(name):
    print  "read file %s" % name
    fp=file(name)
    userIndex = dict()
    i = 0
    while True:
        line = fp.readline()
        if not line: break
        i += 1
        tmp = str(line).split('\t')
        #if 判断是否存在 不存在先定义list 这样让以后添加的都在同一level
        if not userIndex.has_key(tmp[0]):
            userIndex[tmp[0]] = []
        userIndex[tmp[0]].append(tmp[1])
    print "read file have done line number is %d" % i
    fp.close()
    return userIndex

#定义二维字典
def addtwodimdict(thedict, key_a, key_b, val): 
    if key_a in thedict:
        thedict[key_a].update({key_b: val})
    else:
        thedict.update({key_a:{key_b: val}})

#define the similarity function
def similarity(train):
    w = dict()
    for u in train.keys():
        for v in train.keys():
            if u==v:
                continue 
            uset =  set(train[u])
            vset =  set(train[v])
            uvset = uset & vset
            #如果没有交集的话 就是为0
            if not uvset:
                addtwodimdict(w,u,v,0)
            else:
                addtwodimdict(w,u,v,len(uvset))
                #w[u].update({v:len(uvset)})
            w[u][v] /= math.sqrt(len(train[u])*len(train[v])*1.0)
    return w


text = readFile(sys.argv[1])
weight = similarity(text)
print weight










