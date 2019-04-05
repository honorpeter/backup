red = (255, 0, 0)

def get_com_value(value):
    specail_list = ['(',')','（','）', ' ']
    value = str(value)
    result = ''.join(e for e in value if e.isalnum())
    return result

def check_tel(tel):
    tel = str(tel).strip()
    if len(tel) == 11 and tel[0] == '1':
        return True
    else:
        return False

def get_tel(tel):
    if tel == None:
        return None
    tel = str(tel)
    if len(tel) < 11:
        return None
    tel_split = tel.split(';')
    for item in tel_split:
        if check_tel(item):
            return item

    return None

def process_row(sht, row, info, com_name, tel_name, tel_more):
    com_index = info[com_name]
    tel_index = info[tel_name]

    cell_value = sht.cells(row, com_index).value 
    sht.cells(row, com_index).value = get_com_value(cell_value)

    cell_value = sht.cells(row, tel_index).value 
    if check_tel(cell_value):
        sht.cells(row, tel_index).color = red
        return
    else:
        for item in tel_more:
            index = info[item]
            cell_value = sht.cells(row, index).value 
            tel = get_tel(cell_value)
            if tel != None:
                sht.cells(row, tel_index).color = red
                sht.cells(row, tel_index).value = tel

def get_cols(sht, row):
    i = 0
    cout = 0
    while True:
        i += 1
        if sht.cells(row, i).value != None:
            cout = 0
        else:
            cout += 1
        if cout > 10:
            return i - 10
        

def get_header_row(sht, com_name, tel_name, tel_more):
    result = dict()
    header = [com_name, tel_name]
    header.extend(tel_more)
    header = set(header)
    # rows = sht.cells(1,1).end('down').row
    rng=sht.range('A1').expand('table')
    rows=rng.rows.count
    cols=rng.columns.count

    result['rows'] = rows
    print(header)
    for i in range(1, rows+1):
        tmp_rows = []
        cols = get_cols(sht, i)
        for j in range(1, cols):
            tmp_rows.append(sht.cells(i, j).value)
        if header.issubset(set(tmp_rows)):
            print(tmp_rows)
            for item in header:
                result[item] = tmp_rows.index(item) + 1
            result['begin_row'] = i + 1
            result['status'] = True
            print(result)
            return result
    result['status']  = False
    result['msg'] = "can't find header"
    return result



