Charts and Graphics
ggplot2:各种画图的文件包
    geom_histogram()   
            hh <- ggplot(userAction,aes(x=Ds))+geom_histogram()+
                        scale_x_date(major="50 years")
                    ggplot2操作的对象必须是数据框
                    scale_x_date指定间隔跨度 50 years
        hh        显示图形

The Grammar of Graphics:
        Here is the name for each different component of a chart in the 
                grammar of graphics:       
            Data
                    The data that is being visualized.
            Mappings
                Mappings between variables in the data and components of
                     the chart.
            Geometric Objects (geom)
                    The geometric objects that are used to display the 
                    data. For example, scatter plots use geom_point , bar 
                    plots use geom_bar , and line plots use geom_abline .
            Aesthetic Properties (aes)
                The aesthetic properties determine how the plot looks. For 
                example, typeface sizes, label locations, and tick marks 
                are all aesthetic properties.
            Coordinates Coordinates describe how data is mapped to the plot.
                    For example, you can use simple Cartesian coordinates
                    with coord_cartesian , polar coordinates with 
                    coord_polar , or geographic projections with coord_map .
            Statistical Transformations (stat)

            Scales
                    Scales control how variables are mapped to aesthetics.

    Creating Graphics with ggplot2:
                plt <- ggplot(data=d, mapping=aes(x=a, y=b)) + geom_point()
                summary(plt)
                    data: a, b, c [10x3]
                    mapping: x = a, y = b
            To create ggplot objects without qplot , you begin by using
                 the ggplot function.
            ggplot(data, mapping = aes(), ..., environment = globalenv())










