#coding=utf-8
import pdb
import os
import os.path
import caffe
import numpy as np
import sys
import argparse
import sklearn.metrics
import matplotlib.pyplot as plt
import itertools


def get_parser():
    parser = argparse.ArgumentParser(prog='Test real car plate accuracy')
    parser.add_argument('--iters_num',help=u'caffemodel对应的迭代次数')
    parser.add_argument('--model_name',help=u'caffemodel对应的名称，可选')
    return parser


def plot_confusion_matrix(cm, classes,
                          normalize=False,
                          title='Confusion matrix',
                          cmap=plt.cm.Blues):
    """
    This function prints and plots the confusion matrix.
    Normalization can be applied by setting `normalize=True`.
    """
    plt.imshow(cm, interpolation='nearest', cmap=cmap)
    plt.title(title)
    plt.colorbar()
    tick_marks = np.arange(len(classes))
    plt.xticks(tick_marks, classes, rotation=45)
    plt.yticks(tick_marks, classes)

    if normalize:
        cm = cm.astype('float') / cm.sum(axis=1)[:, np.newaxis]
        print("Normalized confusion matrix")
    else:
        print('Confusion matrix, without normalization')

    #print(cm)

    thresh = cm.max() / 2.
    for i, j in itertools.product(range(cm.shape[0]), range(cm.shape[1])):
        plt.text(j, i, cm[i, j],
                 horizontalalignment="center",
                 color="white" if cm[i, j] > thresh else "black")

    plt.tight_layout()
    plt.ylabel('True label')
    plt.xlabel('Predicted label')


def get_confusion_matrix(keyword,tmp_log):
    os.system('cat {}'.format(tmp_log + '| grep '+ keyword +' | awk \'{ print $2}\' > real.txt'))
    os.system('cat {}'.format(tmp_log + '| grep '+ keyword +' | awk \'{ print $4}\' > predict.txt'))

    real = []
    predict = []
    with open('real.txt' ,'r') as f:
        for line in f.readlines():
            real.append(line.strip('\n'))
    with open('predict.txt','r') as f:
        #predict = f.readlines()
        for line in f.readlines():
            predict.append(line.strip('\n'))

    labels = [
    '0','1','2','3','4','5','6','7','8','9',
    'A','B','C','D','E','F','G','H','J','K',
    'L','M','N','P','Q','R','S','T','U','V',
    'W','X','Y','Z'] #读取类别名称文件

    if len(real) == len(predict) :
        array = sklearn.metrics.confusion_matrix(real,predict,labels)
        np.set_printoptions(threshold='nan')
        #print len(array)
        plt.figure()
        plot_confusion_matrix(array,labels,title='confusion matrix')
        plt.show()

    os.system('rm real.txt predict.txt')


def putImgsIntoDir(imgsFoldersDir):
	#把所有图片分类,放到对应首字母或者数字文件夹，例如，1_1.jpg 放到1文件夹
	print("\n put imgs into the dir now \n")
	for file in os.listdir(imgsFoldersDir):
		if not os.path.isdir(file):
			if not os.path.exists(imgsFoldersDir + '/'+ file[0]):
				os.system('mkdir {}'.format(imgsFoldersDir + '/'+ file[0]))
			if not os.path.isdir(imgsFoldersDir + '/'+file):
				os.system('mv {}'.format(imgsFoldersDir + '/'+file +' ' +imgsFoldersDir + '/'+ file[0]+'/'))


def testPics(imgsFoldersDir,deploy,caffe_model,tmp_log):
    labels = [
    'X','S','B','H','K','P','R','8','M','Y',
    'J','6','7','4','Z','U','9','G','L','3',
    '5','W','T','A','1','N','C','0','F','2',
    'E','D','V','Q'] #读取类别名称文件

    net = caffe.Net(deploy,caffe_model,caffe.TEST)   #加载model和network
    
    #图片预处理设置
    transformer = caffe.io.Transformer({'data': net.blobs['data'].data.shape})  #设定图片的shape格式(1,3,28,28)
    transformer.set_transpose('data', (2,0,1))    #改变维度的顺序，由原始图片(28,28,3)变为(3,28,28)
    #transformer.set_mean('data', np.load(mean_file).mean(1).mean(1))    #减去均值，前面训练模型时没有减均值，这儿就不用
    transformer.set_raw_scale('data', 255)    # 缩放到【0，255】之间
    transformer.set_channel_swap('data', (2,1,0))   #交换通道，将图片由RGB变为BGR
    
    count = 0
    right = 0
    f = open(tmp_log,"w")
    for dir_img in os.listdir(imgsFoldersDir):
        dir_img = os.path.join(imgsFoldersDir,dir_img)
        if os.path.isdir(dir_img):
            #print dir_img
            for img in os.listdir(dir_img):
                img_path = os.path.join(dir_img,img)
    
                im=caffe.io.load_image(img_path)  #加载图片
                #执行上面设置的图片预处理操作，并将图片载入到blob中
                net.blobs['data'].data[...] = transformer.preprocess('data',im) 
                #执行测试
                out = net.forward()
                prob= net.blobs['prob'].data[0].flatten() #取出最后一层（Softmax）属于某个类别的概率值，并打印
                #print prob
                order=prob.argsort()[-1]  #将概率值排序，取出最大值所在的序号 
                if labels[order]==dir_img[-1]:
                    right+=1
                    #print img_path,dir_img[-1],'->',labels[order]
                    print >>f,img_path,dir_img[-1],'->',labels[order]
                else:
                    print img_path,dir_img[-1],'->',labels[order]   
                    print >>f,img_path,dir_img[-1],'->',labels[order]   
                    print 'the predict class is:',labels[order],'\n'   #将该序号转换成对应的类别名称，并打印
                count+=1
    
    print 'right nums=', right
    print 'imgs nums=', count
    print 'acc = right /count=', right/float(count)


if __name__ == '__main__':
    parser = get_parser()
    if len(sys.argv) < 2:
        parser.print_help()
    else:
        args = parser.parse_args()
    if args.iters_num :
        iters_num = args.iters_num
    if args.model_name :
        model_name = args.model_name
 
    #设置根目录以及deploy 和 caffemodel
    root='/home/mqli/myFiles/carPlateRecog/'   #根目录
    deploy=root + 'gender_20170204/deploy.prototxt'    #deploy文件
    if not args.model_name :
        model_name = 'gender_train'
    caffe_model=root + 'gender_20170204/' + model_name + '_iter_'+ iters_num +'.caffemodel'   
    #caffe_model=root + 'gender_20170204/max_458_lr001_stepsize_5w/' + model_name + '_iter_'+ iters_num +'.caffemodel'   

    #设置测试图片路径
    imgsFoldersDir = root+'imgTest'
    
    # 处理之前先把图片批量放入对应的文件夹里
    putImgsIntoDir(imgsFoldersDir)
    
    tmp_log = "accu.txt"
    #测试单张图片
    testPics(imgsFoldersDir,deploy,caffe_model,tmp_log)
    
    #获取混淆矩阵
    get_confusion_matrix(imgsFoldersDir,tmp_log)
