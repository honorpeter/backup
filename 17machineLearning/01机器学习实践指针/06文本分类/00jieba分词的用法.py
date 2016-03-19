#!/usr/bin/env python
#-*- coding: utf-8 -*-
#code:myhaspl@qq.com
#10-1.py
'''
        结巴 中文分析   python中文分析组件 支持3中模式 精确模式:试图将句子
            最精确的切开 适合文本分析 
            全模式: 把句子中所有的可以成词的词语都描述出来 速度非常快 但是
                不能解决歧义 
            搜索引擎模式 在精确模式的基础上 对长词再次切分 提高召回率
            jieba
'''
import sys
sys.path.append("../")
import jieba

seg_list = jieba.cut("我来到北京清华大学", cut_all=True)
print "Full Mode:", "/ ".join(seg_list) # 全模式

seg_list = jieba.cut("我来到北京清华大学", cut_all=False)
print "Default Mode:", "/ ".join(seg_list) # 默认模式

seg_list = jieba.cut("他来到了网易杭研大厦")
print ", ".join(seg_list)

seg_list = jieba.cut_for_search("小明硕士毕业于中国科学院计算所，后在日本京都大学深造") # 搜索引擎模式
print ", ".join(seg_list)

