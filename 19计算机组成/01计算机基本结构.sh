历史:
    .......
冯若伊曼结构:
    EDVAC报告:
        主要思想:
            存储程序: 而不是靠开关的连接选择程序
    
    计算机的五大组成部分:
            运算器。简称CA
            控制器  CC
            存储器  M
            输入设备 I
            输出设备 O

        CPU: 控制器 运算器          现代计算机
        存储器: 主存 内存           

        CPU和存储器之间 通过系统总线进行连接

执行指令: 计算机运转的核心 内容:
        执行一条指令的主要步骤:
            1 取指
            2 译码
            3 执行
            4 会写

模型机的存储器:
        存储单元的地址是唯一的 不同存储单元地址互补相同

        存储单元的位宽 有设计计算机时 对存储器的编址方法确定
        如果存储器按字节编址 则每个存储单元存存放8位二进制数

        如果地址总线
                宽度为n 则CPU能管理的存储单元最多为2的n次方
        数据总线:
                宽度一般为存储单元位宽的整数倍
        控制总线:
                读 写 完成等控制信号

        控制器:
                用于控制计算机各个部件完成取指令分析指令执行指令等功能
            包含如下:
                指令寄存器  IR
                    用于存放正在执行或者即将执行的指令
                程序计数器PC
                    用于存放下一条指令的存储单元地址
                    取完下一条指令之后呢这个程序计数器需要自动递增以指向接下
                    来那一条指令的地址
                MAR寄存器:
                    访问存储器的地址
                用于写到存储器或者从存储器读回的数据在MDR iii

                指令译码部件:
                    用于对IR    当中的指令进行译码
                        以确定其中存放的是哪一条指令
                        控制电路就可以产生对应的控制信号
                        这些控制信号在持续脉冲的同步下去控制CPU当中各个控制
                            部件的动作
        运算器:
                算术运算
                    加法和减法
                逻辑运算
                     and or not











