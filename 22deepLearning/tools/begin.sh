每个类别生成对应的txt文件
        ls -1 >> ../smoke.txt  -1 每个文件一行显示

对每个类别添加标签：
        gawk '{print $1,1}' smoke.txt  >> smoke1.txt

对每个类别分别生成对应的train test文件 
        然后将他们合并
        split.py函数









