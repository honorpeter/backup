#!/usr/bin/env python
#-*- coding: utf-8 -*-
'''
停用词清理: 又称垃圾词清理  比如: 的 呢 啊 什么之类...
    这些词不具备表示文本特征的能力 其存在会影响其他词对文本特征的表征能力

    清理的方式是建立停用词表 扫描分词结果,从中剔除听用词表中的词


'''
#code:myhaspl@qq.com
#10-3.py

import jieba
seg_list = jieba.cut("春秋时期有一个农夫，他总是嫌田里的庄稼长得太慢，今天去瞧瞧，明天去看看，觉得禾苗好像总没有长高。他心想：有什么办法能使它们长得高些快些呢？ ", cut_all=False)
liststr="/ ".join(seg_list)
print u"------清理前的词条---------"
print "Default Mode:", liststr # 默认模式
print u"------清理后的词条---------"
#停用词清理                                           
f_stop = open('stopwords.txt')  
try:  
    f_stop_text = f_stop.read( )
    f_stop_text=unicode(f_stop_text,'utf-8')
finally:  
    f_stop.close( ) 
f_stop_seg_list=f_stop_text.split('\n')
for myword in liststr.split('/'):
    if not(myword.strip() in f_stop_seg_list) and len(myword.strip())>1:
        print myword,',',










