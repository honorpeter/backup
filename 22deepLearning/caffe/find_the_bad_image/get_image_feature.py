#coding: utf-8
#根据label.txt文件 解析每个类别 求出每个图片的feature
#然后求平均，求出距离平均 最远的图片的list
import numpy as np
from tools import get_features
import caffe

label = "label.txt"
sort_label = "sort_label.txt"
deploy = "model/deploy.prototxt"
model = "model/step2_iter_40000.caffemodel"
use_gpu = False

if __name__ == "__main__":

    label_map_index = dict()
    label_images = []
    with open(label) as f:
        i = 0
        for line in f:
            line_split = line.strip().split(" ")
            if(len(line_split) < 2):
                print "broken line "+line
                continue

            if(label_map_index.has_key(line_split[-1])):
                label_images[label_map_index[line_split[-1]] ].append(line_split[0])
            else:
                label_map_index[line_split[-1]] = i
                i = i + 1
                label_images.append([line_split[0]])


    images_feature = get_features(label_images,deploy,model,use_gpu)

    #求出平均
    images_label_ave = []
    for features in images_feature:
        images_label_ave.append(np.mean(np.array(features),0))

    numerator = []
    denominator = []
    reslut = []
    sort_index = []

    for i in xrange(len(images_label_ave)):
        #计算均值 排序处理
        numerator.append(np.dot(images_feature[i],images_label_ave[i][:]))
        denominator.append(np.linalg.norm(images_feature[i],axis=1))
        reslut.append(numerator[i][:] / denominator[i][:])

    sorted_file = open(sort_label,"w")
    #排序选择出 最大的顺序
    for i in xrange(len(reslut)):
        sort_index.append(np.argsort(reslut[i]))
        for j in xrange(len(reslut[i])):
            sorted_file.write(label_images[i][sort_index[i][j]]+"\n")

    sorted_file.close()














