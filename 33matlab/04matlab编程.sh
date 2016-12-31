Matlab编程

    循环语句结构
            for i=v,循环体语句组，end
                for  ii=1:2:10
                    语句块
                end
                
            While 逻辑变量，循环体语句组，end
            break语句是终止循环，执行循环体后的语句。
            continue语句是终止本次循环，本次循环中的continue语句后的
                循环语句不再执行，而是执行新的循环。
            
    if 语句:
        if 条件式
            语句块1
        elseif  条件式2 
        
        else 
            语句块2
        end
    条件转移语句结构：try...catch 语句:
        try 
            语句段1
        catch
            语句段2
        end

    用户参数交互输入:
        input（'提示信息','选项'）
            用于向计算机输入一个参数，默认输入的是数字。如果需输入字
                符串，在后面加选项‘s’。
        pause（n）
            暂停程序的执行，n为暂停执行的时间秒数，如果省略延迟时间，
                直接使用pause，将暂停，后按任意键继续执行。
        disp（输出项）
            向命令窗口输出提示信息，可以是字符串或矩阵。
        fprintf( )
            fprintf(fid,format,variables)
            %d：整数格式                %e：实数，科学计数法格式      
            %f：小数格式（浮点数）        %s：字符串格式 
            %g：由系统自动选择实数或小数两种格式之一    

    Matlab函数编写:
        M脚本文件（M-script，简称为M文件）
        M函数格式
        函数的基本结构:
            function [返回变量列表] = 函数名（输入变量列表）
            nargin    nargout，它们一般出现在函数体内部，能自动判断实
                际参数有几个。

    其他函数：
            error(‘message’) : 将字符串中的信息反馈给用户，同时中断
                程序执行。
            warning(‘message’)：较为柔和的一种方式
            inputname(argnum): 获取第argnum个参数的名字

全局内存与全局变量:
Matlab的三种工作空间：
        外部空间称为workspace，用于浏览和存放工作变量。
        函数内部空间是局部空间，称为localspace。内部空间只能被改函数访问
            如果完成被调用，跳出，内部空间被系统收回。
        公共空间，称为globalworkspace，它既能被普通workspace访问，也能被函数
            的局部空间访问。

        定义全局变量:
            global A，B，C
    
        
                
            
        
                
        
            
        
        
        
    
