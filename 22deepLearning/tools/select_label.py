#coding:utf-8

import random

label_name = "label.txt"
select_name = "label_select.txt"
per_label_percent = [1.0,0.1527,1.0,1.0,1.0]


if __name__ == "__main__":
    label_file = open(label_name,"r")
    label_select = open(select_name,"w")

    label_lines = label_file.readlines()
    #存储 每个年龄 需要保存下来的项的下标
    per_age_index_list = [[] for i in xrange(len(per_label_percent))]
    #遍历label文件 将每项的下表 存入到per_age_index_list
    for index,item in enumerate(label_lines):
        tmp_age =  int(item.split(" ")[-1])

        per_age_index_list[tmp_age].append(index)

    #随机抽取每label对应的数量
    for i in range(len(per_age_index_list)):
        if(len(per_age_index_list[i]) == 0):
            continue
        per_age_index_list[i] = random.sample(per_age_index_list[i], int(len(per_age_index_list[i])*per_label_percent[i]))


    #根据对应下表 读取label.txt文件 将需要的保存到select 文件中
    for item_v in per_age_index_list:
        for item_a in item_v:
            label_select.write(label_lines[item_a])
    print "hello all done "
    label_file.close()
    label_select.close()

