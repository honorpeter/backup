#coding: utf-8
import os
import cv2
import json
import threading

root = "label_good"
target = "label_good_processed"

many_thread = 12  #线程数必须大于2
dirs = []
threads = []

def process_img(img_path,json_path):
    factor_w = 2.5
    factor_h = 2.5
    img = cv2.imread(img_path)
    json_file = open(json_path,"r")
    info_all =  json.load(json_file)
    info = info_all["vpicinfo"]["roiparameter"]

    w = int(info["w"])
    h = int(info["h"])
    x = max(int(info["x"]) - (w*factor_w - w)/ 2,0)
    y = max(int(info["y"]) - (h*factor_h - h)/ 2,0)
    w = w * factor_w
    h = h * factor_h
    x = int(x)
    y = int(y)
    h = int(h)
    w = int(w)
    y_max = min(y+h,img.shape[0])
    x_max = min(x+w,img.shape[1])
    img = img[y:y_max,x:x_max]
    #img = img[y:y+h,x:x+w]

    tar_path =  img_path.replace(root,target)
    tar_dir = os.path.dirname(tar_path)
    if(not os.path.exists(tar_dir)):
        os.mkdir(tar_dir)
    cv2.imwrite(tar_path,img)
    json_file.close()

def process_dir(id,count,dir_size):
    global dirs
    count_ites = 0 #记录迭代次数 最后一个线程的次数是不同的
    if (id == (count - 1)):
        count_ites = dir_size % (count - 1)
    else:
        count_ites = dir_size / (count - 1)

    for i in xrange(count_ites):
        index = 0
        if (id == (count - 1)):
            index = id * (int)(dir_size / (count - 1)) + i
        else:
            index = count_ites * id + i

        #print str(index + 1) + "文件夹" + dirs[index]

        imgs_path = os.path.join(root, dirs[index])
        imgs = os.listdir(imgs_path)

        print "processing dir  " + str(dirs[index])
        for img in imgs:
            img_split = img.split(".")
            if (img_split[1] == "jpg"):
                img_path = os.path.join(imgs_path, img)
                json_path = os.path.join(imgs_path, img_split[0] + ".json")
                process_img(img_path, json_path)
            else:
                continue






if __name__ == "__main__":


    dirs = os.listdir(root)
    if(not os.path.exists(target)):
        os.mkdir(target)

    for i in xrange(many_thread):
        threads.append(threading.Thread(target=process_dir, args=(i,many_thread,len(dirs))))

    for t in threads:
        t.setDaemon(True)
        t.start()

    for t_ob in threads:
        t_ob.join()




