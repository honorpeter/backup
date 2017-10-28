#coding: utf-8

import os
import shutil
src_dir = "/old/home/xlji/work/age/data/"
tar_dir = "class_img"
label = "train_test_val/val.txt"

def mk_dir(dir):
	if(os.path.exists(dir)):
		return 0
	else:
		os.mkdir(dir)

if __name__ == "__main__":
	with open(label) as f:
		for line in f:
			line_split = line.split(" ")
			if(len(line_split) != 2):
				print "broken line "+line
				continue
			label_dir = os.path.join(tar_dir,line_split[1].strip())
			mk_dir(label_dir)
			img_path = os.path.join(src_dir,line_split[0])
			shutil.copy(img_path,label_dir)

	
