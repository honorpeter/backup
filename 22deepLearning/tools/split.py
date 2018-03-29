#!/usr/bin/python 
# coding: utf-8
'''
 参数： 
    1 文件名  很多类的还有对应的类别 以行为单位 放在一起
    参数不惯用 2 N     默认为10
    3 K     默认为为1   十份中的第一份  
    # data is dataset, N是总分数 k是测试集占总分数的 第几分

'''
import sys
import random



# data is dataset, N是总分数 k是测试集占总分数的 第几分
def splitData(data,N = 10,k = 1):
    test = []
    train = []
    for line in data:
        if random.randint(0,N) <= k:
            test.append(line)
        else:
            train.append(line)
    print "差分完数据集训练集 测试集的长度为 %d %d" % (len(train),len(test))
    return train,test
# 读取文件 
def readFile(name):
    fp = file(name,"r")
    text = []
    i = 0
    while True:
        line = fp.readline()
        if not line: break
        text.append(line)
        i = i+1
    fp.close()
    
    print "读完文件一共读了几行 %d" % i
    print "text长度 %d" % len(text)
    return text

def writeFile(train,test):
    fTrain = file("train.txt","aw")
    fTest = file("test.txt","aw")
    i = 0
    g = 0
    for line in train:
        i = i+1
        fTrain.write(line)

    for lineTest in test:
        #k=''.join([str(j) for j in line])

        g = g+1
        fTest.write(lineTest)
    
    print "写入文件完成 训练集 测试集写入行数为 %d %d" % (i,g)
    fTrain.close()
    fTest.close()

print "读取文件 %s" % sys.argv[1]
text = readFile(sys.argv[1])
random.shuffle(text)

train,test = splitData(text, 10 , 3)
writeFile(train,test)













