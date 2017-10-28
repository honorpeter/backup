#coding: utf-8

# 功能说明：
#         根据根目录，获取到每个目录对应图片的路径 已经对于的label
#         label默认是按照不同的目录名字 从0开始给定
#         可以使用dir_label指定所有的目录label
import os
from fileTool import *
root = "."
save_result = "label.txt"
dir_label = dict()
label_begin = 0
if __name__ == "__main__":
    result = open(save_result,"w")
    file_tool = fileTool(root)
    imgs_path = file_tool.getAllFile()
    for img_path in imgs_path:
        print "processing image "+img_path
        dir_name = str(img_path).replace(root,"").strip("/").split("/")[0]
        img_path = img_path.strip(". /")
        if dir_label.has_key(dir_name):
            result.write(img_path +" " + str(dir_label[dir_name])+"\n")
        else:
            dir_label[dir_name] = label_begin
            result.write(img_path +" " + str(label_begin)+"\n")
            label_begin = label_begin + 1

    result.close()

