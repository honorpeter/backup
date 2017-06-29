#coding: utf-8

# 功能说明：
#         根据图片统计 每个的h w个数 并求出平均的h w
import os
import cv2
from fileTool import *
root = "."
save_result = "result.txt"
h_w_count = dict()
if __name__ == "__main__":
    result = open(save_result,"w")
    file_tool = fileTool(root)
    imgs_path = file_tool.getAllFile()
    for img_path in imgs_path:
        print "processing image "+img_path
        img_data = cv2.imread(img_path)
        if img_data is None:
            continue
        h = img_data.shape[0]
        w = img_data.shape[1]
        index = str(h)+","+str(w)
        if h_w_count.has_key(index):
            h_w_count[index] = h_w_count[index] + 1
        else:
            h_w_count[index] = 1
    all_count = 0
    ave_h=0
    ave_w = 0
    count = 0
    for k,v in h_w_count.iteritems():
        all_count = all_count + v
        tmp_h_w = str(k).split(",")
        ave_h = float(tmp_h_w[0])*v + ave_h
        ave_w = float(tmp_h_w[1])*v + ave_w
        count = count + v
        result.write(str(k)+","+str(v)+"\n")

    result.write("all image count is "+str(all_count)+"\n")
    result.write("ave_h is "+str(ave_h / count)+"\n")
    result.write("ave_w is "+str(ave_w / count)+"\n")
    result.close()

