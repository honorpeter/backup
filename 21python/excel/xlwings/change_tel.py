import xlwings as xw
import utils
import os
# 打开一个新的 workbook 
dir = "/Users/jixiaolong01/Desktop/excel/ok"
file_name = "华映资本查过的不是.xlsx"
file_path = os.path.join(dir, file_name)
if not os.path.exists(file_path):
    print(file_path + " not exits")
    exit(0)

com_name = "企业名称"
tel = "联系电话"
tel_more = ["工商年报电话"]
# 打开当前目录已经存在的一个 workbook 
wb = xw.Book(file_path)

# 打开第一个 sheet
sht = wb.sheets[0]
red = (255, 0, 0)
header_info = utils.get_header_row(sht, com_name, tel, tel_more)
if header_info['status'] == False:
    print(header_info['msg'])
    exit(1)

#cell是行列 
for i in range(header_info['begin_row'], header_info['rows']):
    utils.process_row(sht, i, header_info, com_name, tel, tel_more)
wb.save()

