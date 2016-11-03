#!/usr/bin/env python
#-*- coding: utf-8 -*-
#code:myhaspl@qq.com
'''
基本过程:
    首先对样本进行分词 接着将垃圾词剔除 然后根据剔除后的词条把文本中的所有
        样本文本中的所有词映射到n维空间的一个向量上 并计算未知文本特征组成
        的向量与各类别特征组向量之间的夹角的余弦值 最后通过比较余弦值的大小
        判断最近的分类
    中文分词:   将一个汉字序列切分成一个单独的词  中文分词软件主要有:
        SCWS: 基于词频字典的机械中文分词引擎 
        ICTCLAS: 开源项目 C/C++编写 支持主流编程语言
        HTTPCWS:基于HTTP协议的开源中文分词系统 将取代之前的PHPCWS中文
            分词扩展
        庖丁解牛分词: 仅支持java 
        结巴 中文分析   python中文分析组件 支持3中模式 精确模式:试图将句子
            最精确的切开 适合文本分析 
            全模式: 把句子中所有的可以成词的词语都描述出来 速度非常快 但是
                不能解决歧义 
            搜索引擎模式 在精确模式的基础上 对长词再次切分 提高召回率
            jieba
                例子看00文件
    停用词清理: 又称垃圾词清理  比如: 的 呢 啊 什么之类...


    算法实战:
        假设提供一个描述战争的样本数据 现在需要对两个未知的文本进行分析 判断
            哪一个是战争的

        算法过程: 使用余弦相似算法完成上述
            1 读取样本文本
            2 对样本文本进行utf-8编码转化
            3 对文本进行预处理 完成中文分析 形成词库 并除去听用词
            4 读取文本词库 统计每个词条的词频 词频代表了每个词对一段文本的
                重要成都 字词的重要性随着它在文件中出现的次数成正比
            5 将上一步整理形成的每个词的词频组成文本的词条词频特征码
            6 使用前面1-5步的方法分析 待分类文本 生成待分类文本的词条词频
                特征码
            7 将待分类文本的词条词频特征码与样本的词条词频特征码进行比较 
                应用余弦相似算法判断待分类文本与样本的相似度
                最相似的就是
            

            '''

#10-4.py

import numpy as np
import jieba
import copy


ftest1fn='mobile2.txt'
ftest2fn='war1.txt'
sampfn='war2.txt'

def get_cossimi(x,y):
    myx=np.array(x)
    myy=np.array(y)
    cos1=np.sum(myx*myy)
    cos21=np.sqrt(sum(myx*myx))
    cos22=np.sqrt(sum(myy*myy))
    return cos1/float(cos21*cos22)

    
if __name__ == '__main__':

    print
    print 'loading  ...'
    print 'working',
    
    #读取样本文本 完成utf-8转换 然后进行分词
    f1 = open(sampfn)  
    try:  
        f1_text = f1.read( ) 
        f1_text=unicode(f1_text,'utf-8')
    finally:  
        f1.close( ) 
    f1_seg_list = jieba.cut(f1_text)
    #第一个待测试数据

    ftest1 = open(ftest1fn)  
    try:  
        ftest1_text = ftest1.read( ) 
        ftest1_text=unicode(ftest1_text,'utf-8')
    finally:  
        ftest1.close( ) 
    ftest1_seg_list = jieba.cut(ftest1_text)
    #第二个待测试数据    
    ftest2 = open(ftest2fn)  
    try:  
        ftest2_text = ftest2.read( ) 
        ftest2_text=unicode(ftest2_text,'utf-8')
    finally:  
        ftest2.close( ) 
    ftest2_seg_list = jieba.cut(ftest2_text)
    

    #读取样本文本
    #去除停用词，同时构造样本词的字典
    f_stop = open('stopwords.txt')  
    try:  
        f_stop_text = f_stop.read( )
        f_stop_text=unicode(f_stop_text,'utf-8')
    finally:  
        f_stop.close( ) 
    f_stop_seg_list=f_stop_text.split('\n')

    test_words={}
    all_words={}
    for  myword in f1_seg_list:
        print ".",
        if not(myword.strip() in f_stop_seg_list):
            test_words.setdefault(myword,0)
            all_words.setdefault(myword,0)
            all_words[myword]+=1
            
            
    #读取待测试文本
    mytest1_words=copy.deepcopy(test_words)
    for  myword in ftest1_seg_list:
        print ".",
        if not(myword.strip() in f_stop_seg_list):
            if mytest1_words.has_key(myword):
                mytest1_words[myword]+=1
    
    mytest2_words=copy.deepcopy(test_words)
    for  myword in ftest2_seg_list:
        print ".",
        if not(myword.strip() in f_stop_seg_list):
            if mytest2_words.has_key(myword):
                mytest2_words[myword]+=1                
    #计算样本与待测试文本的余弦相似度
    sampdata=[]
    test1data=[]
    test2data=[]
    for key in all_words.keys():
        sampdata.append(all_words[key])
        test1data.append(mytest1_words[key])
        test2data.append(mytest2_words[key])
    test1simi=get_cossimi(sampdata,test1data)
    test2simi=get_cossimi(sampdata,test2data)
    

    print u"%s与样本[%s]的余弦相似度:%f"%(ftest1fn,sampfn,test1simi)
    print u"%s与样本[%s]的余弦相似度:%f"%(ftest2fn,sampfn,test2simi) 
                
    

