#coding: utf-8
#根据label.txt文件 解析每个类别 求出每个图片的feature
#然后求平均，求出距离平均 最远的图片的list
import numpy as np
from tools import classifer
import caffe

label = "label.txt"
deploy = "model/deploy.prototxt"
model = "model/step2_iter_40000.caffemodel"
#存放原始图片的路径
image_folder = "."
use_gpu = False

if __name__ == "__main__":
    #TODO:写log 记录统计信息 正确多少 错误多少等等 配置文件写完  优化batchsize gpu处理

    classify = classifer(label,deploy,model,image_folder,use_gpu)
    classify.classify()
















