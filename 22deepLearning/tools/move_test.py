#coding:  utf-8
import os
import shutil

src_dir = ""
target_dir = "val_data"
label_file = "val.txt"


def mk_dir(path):
    if os.path.exists(path):
        return 0
    else:
        os.makedirs(path)

if __name__ == "__main__":
    with open(label_file,"r") as f:
        for line in f.readlines():
            line = line.split(" ")[0].strip()
            src_path = os.path.join(src_dir,line)
            line_split = line.split("/")
            sub_line = line_split[-3:]
            sub_line = "/".join(sub_line)
            print sub_line
            tar_path = os.path.join(target_dir,sub_line)
            #创建目录
            mk_dir(os.path.dirname(tar_path))
            #移动文件
            shutil.move(src_path,tar_path)





