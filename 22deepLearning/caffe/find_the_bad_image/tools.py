#coding: utf-8

import caffe
import numpy as np

def get_feature(img_path,net):
    # 图片预处理设置
    transformer = caffe.io.Transformer({'data': net.blobs['data'].data.shape})  # 设定图片的shape格式(1,3,28,28)
    transformer.set_transpose('data', (2, 0, 1))  # 改变维度的顺序，由原始图片(28,28,3)变为(3,28,28)
    transformer.set_mean('data', np.ones((3,104,104),dtype=np.float)*128)    #减去均值，前面训练模型时没有减均值，这儿就不用
    #transformer.set_mean('data', np.array([128.0]))    #减去均值，前面训练模型时没有减均值，这儿就不用
    #transformer.set_raw_scale('data', 128)  # 缩放到【0，255】之间
    transformer.set_input_scale("data",0.0078125)
    transformer.set_channel_swap('data', (2, 1, 0))  # 交换通道，将图片由RGB变为BGR

    im = caffe.io.load_image(img_path)  # 加载图片
    #im = caffe.io.resize_image(im,(104,104))
    # 执行上面设置的图片预处理操作，并将图片载入到blob中
    net.blobs['data'].data[...] = transformer.preprocess('data', im)
    # 执行测试
    out = net.forward()
    prob = net.blobs['prob'].data[0].flatten() #取出最后一层（Softmax）属于某个类别的概率值，并打印
    return prob

def get_features(label_images,deploy,model,use_gpu):

    if use_gpu:
        caffe.set_mode_gpu()
    else:
        caffe.set_mode_cpu()

    # 定义caffe网络
    net = caffe.Net(deploy, model, caffe.TEST)
    #求出每个图片的特征
    images_feature = []
    for i,images in enumerate(label_images):
        images_feature.append([])
        for image in images:
            images_feature[i].append(get_feature(image,net))

    return images_feature