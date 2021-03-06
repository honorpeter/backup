MATLAB符号运算
    符号数学工具箱是建立在功能强大的Maple软件的基础上

这些功能主要包括：符号表达式的运算，符号表达式的复合、化简，符号矩阵的
    运算，符号微积分、 符号函数画图，符号代数方程求解，符号微分方程求解等

符号对象:
        对参与符号运算的各种形式量，
            包括符号常量、符号变量、符号表达式和符号矩阵或数组。
                符号常量和符号变量在被当做符号对象引用时必须有符号
                    （symbolic）对象的说明：
                        函数sym( )
                        命令syms 
            定义符号常量 :
                        函数sym( ) 
                            sym('A')或sym('A','flag')
                                flag: 可选
                            'r'：用有理数格式表达符号量(默认的表达格式，
                            其具体形式又有多种，如分式，指数式，开方式等。)
                            'e'：用带有机器浮点误差的有理数格式表达符号量。
                            'd'：用十进制数格式表达符号量(默认显示精度可
                                        达32 位)。
                            'f'：用浮点数格式表达符号量。

                            f2=sym('(3*4-2)/5+1')
                        命令syms:
                            syms arg1 arg2 ...
                            syms arg1 arg2 ... real
                            syms arg1 arg2 ... unreal
                            参数'real'定义为实型符号量，'unreal'定义为非实型符号量
                              syms a b c
            定义符号变量:
                sym('x')
            符号表达式:
                syms x y z r s t
                r^2+sin(x)+cos(y)+log(s)+exp(t)
            符号矩阵:
                符号矩阵的元素
                    符号常量、符号变量和符号表达式
                创建符号矩阵的方法：size( )可以得到符号矩阵的大小
                    函数sym
                    以矩阵元素的通式来创建符号矩阵
                        S=sym('[l,x,y,z;n,u,v,w;a,b,c,d;g,h,j,p]')
                        H=sym('[cos(t), -sin(t); sin(t), cos(t)]')
                    类似创建普通数值矩阵的方法创建符号矩阵
                        由数值矩阵转换为符号矩阵
                        M=[1.1, 1.2, 1.3; 2.1, 2.2, 2.3; 3.1, 3.2, 3.3]
                        S=sym(M)
                        如果元素是无理数，则符号形式中命令sym 
                                将用符号浮点数表示元素
                    抽取符号矩阵中的元素:
                        B=sym('[a,b,c;d,e,f;g,h,k]')
                            B(2,3)
符号算术运算:
        运算法则和运算符号同数值运算相同，只是参与运算的对象和运算所得结果
            是符号的而非数值的
        符号对象的加减:
            A+B、A-B 
            若A 与B 为同型数组时，A+B、A-B 分别对对应元素进行加减；
            若A 与B 中至少有一个为标量，则把标量扩大为数组，其大小与相加的
                另一数组同型，再按对应的元素进行加减。
        两个符号表达式的和与差
            fx = 2*x^2+3*x-5
            gx= x^2-x+7
             fx+gx
            fx-gx
        两个符号矩阵的加减运算:
            A=[a b;c d];B=[e f;g h];
            A+B
            A-B

        符号对象的乘除:
            A*B、A/B:求A 和B 两个符号矩阵 的乘法与除法
                线性矩阵相乘除
            A.*B 、A./B：实现 两个符号数组 的乘法
                对应元素相乘除

独立变量与表达式化简:
    表达式中的独立变量
            当符号表达式中含有多个变量时，只有一个变量是独立变量。
        选择独立变量规则：
            因为i 和j 是虚单位，它们不能作为独立变量。
            表达式中有x 作为符号变量时，x 就是独立变量。
            表达式中没有x 作为符号变量时，就从表达式中挑选打头字母最靠近x 
                的符号变量作为独立变量。如果表达式中有与x 前后等距的两个
                字母符号变量时，选择排序在x 后面的那一个。
        r=findsym(S)：以字母表的顺序返回表达式S中的所有符号变量(
            注：符号变量由除了i与j的字母与数字构成的、字母打头的字符串)。
            若表达式S中没有任何的符号变量，则函数findsym()返回一空字符串。
        r=findsym(S,n)：返回表达式S 中依接近x的顺序而排列的n个符号变量
    表达式化简:
        合并同类项(collect)
                R=collect(S)：对于多项式S 按默认独立变量的幂次降幂排列
                R=collect(S,v)：对指定的对象v 计算。
        多项式展开(expand)
                R = expand(S)
        因式分解(factor)
                factor(X)
                    X为一正整数，则factor(X)返回X 的 质数分解式。
                    X为多项式或整数矩阵，则factor(X) 分解矩阵的每一元素。
                        若整数数组中有一元素位数超过16 位，用户必须用命令
                        sym生成该元素。
                    F3 = factor(sym('12345678901234567890'))
                
        一般化简(simplify)
                R = simplify(S)
        不定化简(simple)
                r=simple(S)：试图找出符号表达式S 的代数上的简单形式，
                显示任意的能使表达式S 长度变短的表达式，且返回其中最短的一个
                [r,how]=simple(S)：没有显示中间的化简结果，但返回能找到的
                  最短的一个。输出参量r为一符号，how为一字符串，用于表示算法
        通分(numden)
                [N,D] = numden(A)
                输出的参量N 为分子的符号矩阵，输出的参量D 为分母的符号矩阵。
        书写格式美化(pretty)
                pretty(S)：用默认的线型宽度79 显示符号矩阵S 每一元素
                用指定的线型宽度n 显示

符号微积分运算:
        符号极限:   函数limit( )
            limit(F,v,a)：计算符号对象F 当指定变量v→a 时的极限。
            limit(F,a)：求符号对象F 当默认的独立变量趋近于a 时的极限。
            limit(F)：求符号对象F 当默认的独立变量趋近于0 时的极限。
            limit(F,v,a,'left')或limit(F,v,a,'right')：
                    计算符号函数F 的单侧极限：左极限v→ a− 或右极限v→ a+ 。
        符号微分: 函数diff( )
            diff(S,v)：对符号对象S 中指定的符号变量v 求其1 阶导数。
            diff(S)：对符号对象S 中的默认的独立变量求其1 阶导数。
            diff(S,n)：对符号对象S 中的默认的独立变量求其n 阶导数。
            diff(S,v,n)：对符号对象S 中指定的符号变量v 求其n 阶导数。
        符号积分：函数int( ):
            R=int(S,v)：对符号对象S 中指定的符号变量v 计算不定积分。注意的
                是，表达式R 只是函数S 的一个原函数，后面没有带任意常数C。
            R=int(S)：对符号对象S 中的默认的独立变量计算不定积分。
            R=int(S,v,a,b)：对符号对象S 中指定的符号变量v 计算从a到b的定积分
            R=int(S,a,b)：对符号对象S 中的默认的独立变量计算从a 到b 的定积分

        符号Taylor 级数展开:
            r=taylor(f,n,v)：返回符号表达式f 中指定的符号自变量v(若表达式
                f 中有多个变量时)的n-1阶的Maclaurin(麦克劳林)多项式(即在零
                点附近v=0)近似式。
            r=taylor(f)：返回符号表达式f 中默认的独立变量的 5阶 的
                Maclaurin 多项式的近似式。
            r=taylor(f,n,v,a)：返回符号表达式f 中指定的符号自变量v 的
                n-1阶的Taylor 级数(在指定的a 点附近v=a)的展开式。
            r=taylor(f,v)：返回符号表达式f 中指定的符号自变量v的5阶
                Maclaurin多项式
        符号积分变换:
            傅里叶变换及其反变换 
            拉普拉斯变换及其反变换 
                  L=laplace(f)：返回符号函数f的拉普拉斯变换
                  L=laplace(f,t)：返回值 L 的参量为指定变量t
                  L=laplace(f,w,z)：返回符号函数 f 的拉普拉斯变换。
                    f 的参量为指定变量w，返回值L的参量为指定变量z，
                反变换：
                    f=ilaplace(L)：L的参量为默认变量s，返回值f的参量为默认变量t
                    f=ilaplace(L,y)：返回值f的参量为指定变量y
                    F=ilaplace(L,y,x)：返回符号函数L的拉普拉斯反变换。
                        L的参量为指定变量y，返回值 f的参量为指定变量x，
            Z 变换及其反变换

        方程的解析解:
            线性方程组的解析解：函数solve( )
                g=solve(eq1,eq2,…,eqn)：
                    给出方程组eq1,eq2,…,eqn 中以默认的独立变量为求解对象
                    (如x1,x2,…,xn)的解。
                g=solve(eq1,eq2,…,eqn,var1,var2,…,varn)：
                    对方程组q1, eq2, …, eqn中指定的n 个变量如
                    var1,var2,…,varn 求解。
        非线性方程(组)的解析解：函数 solve( )
            f=sym('a*x^2+b*x+c=0');
            xf=solve(f)
            [y z]=solve('u*y^2+v*z+w=0', 'y+z+w=0', 'y', 'z')
            
常微分方程(组)的解析解：函数是dsolve():
            r=dsolve('equ')
            r=dsolve('equ', 'v')
            r=dsolve('equ’,'cond1,cond2,…','v')
            r=dsolve('equ1,equ2,…','v')
            r=dsolve('equ1,equ2,…','cond1,cond2,…','v')
                    
            

    
            
            
            
            
        
                
            
                    
                
                
                                    
                            
                    
            
