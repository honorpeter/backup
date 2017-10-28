#coding: utf-8

# 功能：根据label.txt文件 获得 每个label的个数 作为统计工具使用
src = "label.txt"
save = "label_count.txt"
label_count = dict()
if __name__ == "__main__":
    label_file = open(src,"r")
    label_count_file = open(save,"w")

    lines = label_file.readlines()
    for line in lines:
        print "processing image "+line
        line_split = line.split(" ")
        if(len(line_split) != 2):
            print "broken line "+line_split
            continue
        label = int(line_split[1])
        if(label_count.has_key(label)):
            label_count[label] = label_count[label]+1
        else:
            label_count[label] = 1

    for k,v in label_count.iteritems():
        label_count_file.write(str(k)+","+str(v)+"\n")

    label_file.close()
    label_count_file.close()

