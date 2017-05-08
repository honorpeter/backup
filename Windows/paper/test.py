# coding: utf-8


#设置Python环境
import numpy as np
import matplotlib.pyplot as plt
# 在notebook上 显示图片
get_ipython().magic(u'matplotlib inline')
import matplotlib.patches as patches

# set display defaults
plt.rcParams['figure.figsize'] = (10, 10)        # large images
plt.rcParams['image.interpolation'] = 'nearest'  # don't interpolate: show square pixels
plt.rcParams['image.cmap'] = 'gray'  # 使用灰度图



# 添加caffe Python接口路径
import sys
caffe_root = '../../'  
sys.path.insert(0, caffe_root + 'python')
#导入caffe模块
import caffe
import math



#定义sigmoid函数
def sigmoid(p):
    return 1.0 / (1 + math.exp(-p * 1.0))
#定义 overlap 函数
def overlap(x1, w1, x2, w2): #x1 ,x2 are two box center x
    left = max(x1 - w1 / 2.0, x2 - w2 / 2.0)
    right = min(x1 + w1 / 2.0, x2 + w2 / 2.0)
    return right - left
#定义 iou 函数
def cal_iou(box, truth):
    w = overlap(box[0], box[2], truth[0], truth[2])
    h = overlap(box[1], box[3], truth[1], truth[3])
    if w < 0 or h < 0:
        return 0
    inter_area = w * h
    union_area = box[2] * box[3] + truth[2] * truth[3] - inter_area
    return inter_area * 1.0 / union_area
#定义 nms函数 去重复
def apply_nms(boxes, thres):
    sorted_boxes = sorted(boxes,key=lambda d: d[7])[::-1]
    p = dict()
    for i in range(len(sorted_boxes)):
        if i in p:
            continue
        
        truth =  sorted_boxes[i]
        for j in range(i+1, len(sorted_boxes)):
            if j in p:
                continue
            box = sorted_boxes[j]
            iou = cal_iou(box, truth)
            if iou >= thres:
                p[j] = 1
    
    res = list()
    for i in range(len(sorted_boxes)):
        if i not in p:
            res.append(sorted_boxes[i])
    return res
#定义 显示函数
def show_boxes(boxes):
    label_name = {0: "bg", 1: "aeroplane", 2: "bicycle", 3: "bird", 4: "boat", 5: "bottle", 6: "bus", 7: "car", 
              8: "cat", 9: "chair", 10: "cow", 11: "diningtable", 12: "dog", 13: "horse", 14: "motorbike", 
              15: "person", 16: "pottedplant", 17: "sheep", 18: "sofa", 19: "train", 20: "tvmonitor"}
    w = image.shape[1]
    h = image.shape[0]

    plt.imshow(image)
    currentAxis = plt.gca()
    colors = plt.cm.hsv(np.linspace(0, 1, 21)).tolist()
    
    for box in boxes:
        
        x_min = int(round((box[0]-box[2]/2.0) * w))
        x_max = int(round((box[0]+box[2]/2.0) * w))
        y_min = int(round((box[1]-box[3]/2.0) * h))
        y_max = int(round((box[1]+box[3]/2.0) * h))
        
        if x_min < 0:
            x_min = 0
        if x_max > w:
            x_max = w
        if y_min < 0:
            y_min = 0
        if y_max > h:
            y_max = h
        
        
        display_txt = '{:0.2f}, {}'.format(box[7], label_name[box[4]])
        coords = (x_min, y_min), x_max-x_min+1, y_max-y_min+1
        color = colors[box[4]]
        currentAxis.add_patch(plt.Rectangle(*coords, fill=False, edgecolor=color, linewidth=2))
        currentAxis.text(x_min, y_min, display_txt, bbox={'facecolor':color, 'alpha':0.5})
    plt.show()



#设置caffe为cpu模式
caffe.set_mode_cpu()
#定义模型文件和权重文件
model_def = './good/good_deploy.prototxt'
model_weights = './good/change_iter_45000.caffemodel'
#初始化网络
net = caffe.Net(model_def,      
                model_weights,  
                caffe.TEST)     

#定义 均值大小
mu = np.array([105, 117, 123])
# 为输入数据做变换 做准备
transformer = caffe.io.Transformer({'data': net.blobs['data'].data.shape})

transformer.set_transpose('data', (2,0,1))  # 改变图像的维度 改为 通道，高度，宽度
transformer.set_mean('data', mu)            # 设置均值
transformer.set_raw_scale('data', 255)      # 归一化
transformer.set_channel_swap('data', (2,1,0))  # 将通道RGB改为BGR

net.blobs['data'].reshape(1,        # batch size
                          3,         # 通道数
                          416, 416)  #图像大小




image = caffe.io.load_image('darknet_v3/dog.jpg')#加载图片
transformed_image = transformer.preprocess('data', image) #处理图片



net.blobs['data'].data[...] = transformed_image #设置输入数据

### 执行forward操作
output = net.forward()

res = output['conv_reg'][0]  #获取网络输出

swap = np.zeros((13*13,5,25))

#改变数据结构
index = 0
for h in range(13):
    for w in range(13):
        for c in range(125):
            swap[h*13+w][c/25][c%25]  = res[c][h][w]

biases = [1.08,1.19,3.42,4.41,6.63,11.38,9.42,5.11,16.62,10.52]

boxes = list()
for h in range(13):
    for w in range(13):
        for n in range(5):
            box = list();
            cls = list();
            s = 0;
            x = (w + sigmoid(swap[h*13+w][n][0])) / 13.0; #center x
            y = (h + sigmoid(swap[h*13+w][n][1])) / 13.0; #center y
            ww = (math.exp(swap[h*13+w][n][2])*biases[2*n]) / 13.0; #w
            hh = (math.exp(swap[h*13+w][n][3])*biases[2*n+1]) / 13.0; #h
            obj_score = sigmoid(swap[h*13+w][n][4]);
            for p in range(20):
                cls.append(swap[h*13+w][n][5+p]);
            
            large = max(cls);
            for i in range(len(cls)):
                cls[i] = math.exp(cls[i] - large);
            
            s = sum(cls);
            for i in range(len(cls)):
                cls[i] = cls[i] * 1.0 / s;
                
            box.append(x); #0
            box.append(y); #1
            box.append(ww); #2
            box.append(hh); #3
            box.append(cls.index(max(cls))+1) #4
            box.append(obj_score); #5
            box.append(max(cls)); #6
            box.append(obj_score * max(cls))
            
            if box[5] * box[6] > 0.8:
                boxes.append(box);



res = apply_nms(boxes, 0.5)
show_boxes(res)






