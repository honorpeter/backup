#coding: utf-8

import caffe
import numpy as np
import os
import shutil
import pickle

class classifer:
    #记录标签 映射到 下标
    __label_map_index = dict()
    #记录 下标对应的label
    __index_map_label = []
    #存放所有的图片地址
    __label_images = []
    #存放每个label对错信息
    __info = dict()

    def __init__(self,label,deploy,model,image_folder=None,use_gpu=None,cache_dir=None,right_label=None):
        if label == None or deploy == None or model == None:
            print "must give the label deploy model "
            exit()
        if image_folder == None:
            self.image_folder = ""
        else:
            self.image_folder = image_folder
        if use_gpu == None:
            self.use_gpu = False
        else:
            self.use_gpu = use_gpu
        if cache_dir == None:
            self.cache_dir = "cache"
        else:
            self.cache_dir = cache_dir
        if right_label == None:
            self.save_right_label = False
        else:
            self.save_right_label = True
            self.right_label = right_label

        self.label = label
        self.model = model
        self.deploy = deploy
        self.wrong_folder = os.path.join(self.cache_dir,"wrong_folder")
        self.right_folder = os.path.join(self.cache_dir,"right_folder")
    def get_images(self):
        with open(self.label) as f:
            i = 0
            for line in f:
                line_split = line.strip().split(" ")
                if (len(line_split) < 2):
                    print "broken line " + line
                    continue

                if (self.__label_map_index.has_key(line_split[-1])):
                    self.__label_images[self.__label_map_index[line_split[-1]]].append(line_split[0])
                else:
                    self.__label_map_index[line_split[-1]] = i
                    self.__index_map_label.append(line_split[-1])
                    i = i + 1
                    self.__label_images.append([line_split[0]])

    def mk_dir(self,dir):
        if os.path.exists(dir):
            return 0
        else:
            os.makedirs(dir)

    def get_feature(self,img_paths,net):

        data_shape = list(net.blobs['data'].data.shape[1:4])
        data_shape.insert(0,len(img_paths))
        #存储数据
        data = np.zeros((data_shape[0],data_shape[2],data_shape[3],data_shape[1]),dtype=np.float)
        for i,img_path in enumerate(img_paths):
            im = caffe.io.load_image(os.path.join(self.image_folder,img_path))  # 加载图片
            im = caffe.io.resize_image(im,data_shape[2:4])
            data[i,:,:,:] = im

        #改变通道顺序
        channel_swap = (0, 3, 1, 2)
        data = data.transpose(channel_swap)
        data = data[:,(2,1,0),:,:]
        #get the normal range
        data *= 255
        #预处理
        data -= 128
        data *= 0.0078125

        # 执行上面设置的图片预处理操作，并将图片载入到blob中
        net.blobs['data'].data[0:data_shape[0],:,:,:] = data
        # 执行测试
        out = net.forward()
        probs = []
        for i in xrange(len(img_paths)):
            prob = net.blobs['prob'].data[i].flatten()
            probs.append(prob)
        return probs

    def classify(self):
        self.get_images()
        images_feature = self.get_features()
        self.judge_pred(images_feature)
        self.save_info()

    def get_features(self):

        self.mk_dir(self.cache_dir)
        #如果存在缓存 直接读取 返回
        path = os.path.join(self.cache_dir,os.path.basename(self.model) + "pkl")
        if os.path.exists(path):
            with open(path) as f:  # Python 3: open(..., 'rb')
                images_feature  = pickle.load(f)
                return images_feature

        if self.use_gpu:
            caffe.set_mode_gpu()
        else:
            caffe.set_mode_cpu()

        # 定义caffe网络
        net = caffe.Net(self.deploy, self.model, caffe.TEST)
        num = net.blobs['data'].data.shape[0]


        #求出每个图片的特征
        images_feature = []
        for i,images in enumerate(self.__label_images):
            images_feature.append([])

            quotient = len(images) / num
            remainder = len(images) % num
            for j in xrange(quotient):
                images_feature[i].extend(self.get_feature(images[(j*num):(j*num+num)],net))
            if remainder == 0:
                continue
            images_feature[i].extend(self.get_feature(images[quotient*num:],net))
        #缓存 feature特征
        with open(path, 'w') as f:  # Python 3: open(..., 'wb')
            pickle.dump(images_feature, f)

        return images_feature


    def proc_wrong(self,image_path,pred_label,real_label):
        name = "pred_" + str(pred_label) + "_real_"+ str(real_label)+ "_"+ str(image_path).replace("/","_")
        path_dir = os.path.join(self.wrong_folder,str(pred_label))
        self.mk_dir(path_dir)
        path = os.path.join(path_dir,name)
        shutil.copy(os.path.join(self.image_folder,image_path),path)



    def proc_right(self,image_path):

        src_path = os.path.join(self.image_folder,image_path)
        tar_path = os.path.join(self.right_folder,image_path)
        self.mk_dir(os.path.dirname(tar_path))
        shutil.copy(src_path,tar_path)

    def judge_pred(self,images_feature):
        self.mk_dir(self.wrong_folder)
        self.mk_dir(self.right_folder)
        if self.save_right_label:
            label_file = open(self.right_label,"w")

        for i in xrange(len(images_feature)):
            for j in xrange(len(images_feature[i])):
                max_index = np.argmax(images_feature[i][j])
                if max_index != int(self.__index_map_label[i]):
                    #保存到 wrong folder目录中
                    self.proc_wrong(self.__label_images[i][j],max_index,self.__index_map_label[i])
                    self.update_info("WRONG",self.__index_map_label[i])
                else:
                    self.update_info("RIGHT",self.__index_map_label[i])
                    if self.save_right_label:
                        label_file.write(self.__label_images[i][j]+" "+str(self.__index_map_label[i])+"\n")
                    else:
                        self.proc_right(self.__label_images[i][j])

        if self.save_right_label:
            label_file.close()
    def update_info(self,type,label):
        if self.__info.has_key(label):
            if type == "WRONG":
                self.__info[label][1] = self.__info[label][1] + 1
            elif(type == "RIGHT"):
                self.__info[label][0] = self.__info[label][0] + 1
            else:
                print "wrong type"
        else:
            self.__info[label] = [0,0]
            if type == "WRONG":
                self.__info[label][1] =  1
            elif(type == "RIGHT"):
                self.__info[label][0] =  1
            else:
                print "wrong type"
    def save_info(self):
        info_path = os.path.join(self.cache_dir,"info.txt")

        with open(info_path,"w") as f:
            for k,v in self.__info.iteritems():
                line = "label "+k+" right number is "+str(v[0]) + " wrong number is "+str(v[1]) + " right percent is "+str(v[0]/float(v[1]+v[0]))+"\n"
                f.write(line)
