图形的绘制:
    图形对象:
        Root 对计算机屏幕最高级别的对象
        Figure  用来显示图形和用户界面的窗口
            Hf_fig=figure 命令建立一个新的图形窗口
        Axes    在窗口中显示图形的轴
        Uicontrol   用户界面控制，执行一个对用户交互作用的函数
        Uimenu      用户定义窗口函数
        Uicontextmentu  右键单击对象时弹出的菜单
        Image   二维像素基础图
        Light   影响斑点和表面对象着色的光源
        Line    用于诸如plot plot3 semilogx等函数的线
        Patch    带边缘的填充多边形
        Rectangle   二维形状
        Surface 
        Text    字符串

    二维绘图:
        figure命令自动打开一个图形窗口Figure(1)，继续使用
            figure命令又会生成Figure(2)，也可以直接输入Figure(10)
        plot函数:
            plot(Y)
            plot(X1,Y1,...)
            plot(X1,Y1,LineSpec,...)
            plot(...,'PropertyName',PropertyValue,...)
            plot(axes_handle,...)
            h = plot(...)
            hlines = plot('v6',...)
        plotyy（t,y1,t,y2）函数
            画两条线
        隐函数的曲线绘制：
            ezplot('x^2 + 3*y^2=8',axis(-4,4,-4,4))
        图像的增强控制:
            plot(x1,y1,linespec,..., xn,yn,linespec)
            plot(x1,y1,linespec,'propertyname',propertyvalue)
                linewidth：指定线的宽度
                markeredgecolor：指定标识边缘的颜色
                markerfacecolor：指定标识填充的颜色
                markersize：指定标识大小

        Tex字符:
            \alpha
            \beta
            \gamma
            \delta
            \zeta
            \eta
            \theta
            \pi     等一些其他的转移字符

                texlabe（）l转换MATLAB表达式为等价的Tex格式字符
                    串。它处理希腊字母的变量名为实际显示的希腊字母字符串。
            Tex字符格式:
                ①  \bf：设置字体为粗体字。
                ②  \it：设置字体为斜体字。
                ③  \sl：设置字体为斜体字，很少使用。
                ④  \rm：设置字体为正常字体。
                ⑤  \fontname{字体名}：设置字体名。例如：\fontname{宋体}。
                ⑥  \fontsize{字体大小}：设置字体大小。例如：\fontsize{16}。
            Tex字符的颜色设置
                \color{颜色名}颜色名：颜色名有12种，分别为red、green、
                    yellow、magenta、blue、black、white、cyan、gray、
                    barkGreen、orange和lightBlue。例如：
                        \color{magenta} magenta。
        极坐标图的绘制：
            polar（theta，r）
        subplot函数:
            subplot是将多个图画到一个平面上的工具。其中，m表示是图排成m行，
                n表示图排成n列
    三维图形的绘制方法:
            plot3（x，y，z，选项）
            ezplot3（）
    三维曲面的绘制：mesh（）

    图形用户界面设计:
        
            
            
        
            
                
            
            
        
            
           









