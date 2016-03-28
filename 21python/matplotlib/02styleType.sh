Decorate Graphs with Plot Styles and Types
       Markers and line styles  
            plot() supports an optional third argument:
                plt.plot(X, Y, '<format>', ...)

            Control colors:
                y = np.arange(1, 3)
                plt.plot(y, 'y');
                plt.plot(y+1, 'm');
                plt.plot(y+2, 'c');
                plt.show()
                        
                    b   blue
                    c   cyan
                    g   green
                    k   black
                    m   magenta
                    r   red
                    w   white
                    y yellow

            There are several ways to specify colors:
                    Hexadecimal string (the same format as in HTML code) 
                            such as #FF00FF
                    RGB or RGBA tuples, for example, (1, 0, 1, 1)
                	 Grayscale intensity, in string format such as '0.7' 
            Specifying styles in multiline plots:
                    plt.plot(x1, y1, fmt1, x2, y2, fmt2, ...)
        Control line styles:
                    plt.plot(y, '--', y+1, '-.', y+2, ':');
                    plt.show()

                    - solid line
                    -- dashed line
                    -. dash-dot line
                    : dotted line
        Control marker styles
                    .  point marker
                    , Pixel marker
                    o Circle marker

                    v triangle down
                    ^ Triangle up marker
                    < Triangle left marker
                    > Triangle right marker
                    1 Tripod down marker
                    2 Tripod up marker
                    3 Tripod left marker
                    4 Tripod right marker
                    s Square marker
                    p Pentagon marker
                    * Star marker
                    h Hexagon marker
                    H Rotated hexagon marker
                    + Plus marker
                    x Cross (x) marker
                    D Diamond marker
                    d Thin diamond marker
                    | Vertical line (vline symbol) marker
                    _ Horizontal line (hline symbol) marker

        Finer control with keyword arguments:
                color or c         Sets the color of the line
                linestyle           Sets the line style
                linewidth Sets the line width; 
                                accepts a float value in points.
                marker Sets the line marker style.
                markeedgecolor      Sets the marker edge color;
                                     accepts any Matplotlib color format .
                markeredgewidth Sets the marker edge width; 
                                    accepts float value in points.
                markerfacecolor Sets the marker face color; 
                                    accepts any Matplotlib color format.
                markersize Sets the marker size in points;
                                     accepts float values .

            plt.plot(y, color='blue', linestyle='dashdot', linewidth=4,
                marker='o', markerfacecolor='red', markeredgecolor='black',
                markeredgewidth=3, markersize=12);
    Handling X and Y ticks:
                import matplotlib.pyplot as plt
                x = [5, 3, 7, 2, 4, 1]
                plt.plot(x);
                plt.xticks(range(len(x)), ['a', 'b', 'c', 'd', 'e', 'f']);
                plt.yticks(range(1, 8, 2));
                plt.show()

                used xticks() to specify both, locations and labels and
                yticks() to only show ticks at odd numbered locations
Plot types:
    Histogram charts:
                y = np.random.randn(1000)
                plt.hist(y);
                plt.show()
            Histogram plots group up values into bins of values
                hist() uses a bin value of 10 default
                plt.hist(y, 25); or hist(y, bin=<bins>) 

    Error bar charts:
                x = np.arange(0, 4, 0.2)
                y = np.exp(-x)
                e1 = 0.1 * np.abs(np.random.randn(len(y)))
                plt.errorbar(x, y, yerr=e1, fmt='.-');
                plt.show()
                xerr , to draw horizontal error bars.
                yerr vertical error bars

            fmt : This is the plot format for lines. If None, then only the
                     error bars are plotted with no line connecting them.
            ecolor : This accepts any Matplotlib color and specifies the
                     color of the error bars. If None , then the marker 
                    color is used.
             elinewidth : This specifies the line width of the error bars.
                     If None , then the line width is used.
            capsize : This specifies the size of the cap of the error bars 
                    in pixels.

                    plt.errorbar(x, y, yerr=[e1, e2], fmt='.-');
                    In [12]: plt.show(
                    In this code snippet, -y is e1 and +y is e2 .

    Bar charts:
            plt.bar([1, 2, 3], [3, 2, 5]);
            In [3]: plt.show()
                    display rectangular bars

                width : The width of the bars
                color : The color of the bars
                xerr , yerr : The error bars on the bar chart (yes, bar() 
                            supports error bars)
                bottom : The bottom coordinates of the bars
    Pie charts:
                plt.figure(figsize=(3,3));
                x = [45, 35, 20]
                labels = ['Cats', 'Dogs', 'Fishes']
                plt.pie(x, labels=labels);
                plt.show()

                    •	 explode : If specified, it's an array of the same
                         length as that of X . Each of its values specify 
                         the radius fraction with which to offset the wedge
                         from the center of the pie.
            colors : This is a list of Matplotlib colors, cyclically used 
                    to color the wedges.
            labels , labeldistance : This is a list of labels, one for each
                     of the X values.  labeldistance is the radial distance
                     at which the labels are drawn.
            autopct , pctdistance : This formatting string or function is 
                    used to label wedges with their numeric values. 
                    pctdstance is the ratio between the center of the pie 
                    and the start of the text.
            shadow : This draws a shadow for wedges or pie.
    Scatter plots:
                x = np.random.randn(1000)
                y = np.random.randn(1000)
                plt.scatter(x, y);
                plt.show()
Polar charts:
                theta = np.arange(0., 2., 1./180.)*np.pi
                plt.polar(3*theta, theta/5);
                plt.polar(theta, np.cos(4*theta));
                plt.polar(theta, [1.4]*len(theta));
                plt.show()
                page 74

Text inside figure, annotations, and arrows:
    Text inside figure:
                import matplotlib.pyplot as plt
                import numpy as np
                x = np.arange(0, 2*np.pi, .01)
                y = np.sin(x)
                plt.plot(x, y);
                plt.text(0.1, -0.04, 'sin(0)=0');
                plt.show()

    Annotations:
                y = [13, 11, 13, 12, 13, 10, 30, 12, 11, 13, 12, 12, 12, 11,
12]
                 plt.plot(y);
                 plt.ylim(ymax=35);
                 plt.annotate('this spot must really\nmean something\
                    ', xy=(6, 30), xytext=(8, 31.5), arrowprops=dict(faceco\
                    lor='black', shrink=0.05));
                 plt.show()

                 width : The width of the arrow in points
        •	 frac : The fraction of the arrow length occupied by the head
        •	 headwidth : The width of the base of the arrow head in points
            shrink : Moves the tip and the base of the arrow some percent 
            away from the annotated point and text, in percentage (so 0.05 
            is equal to 5%)
    Arrows:
            plt.arrow(x, y, dx, dy)
                    angle Attributes (= default values)
                    angle3 angleA=90, angleB=0
                    arc angleA=0, angleB=0, armA=None, armB,=None, rad=0.0
                    arc3 rad=0.0

                    -> head_length=0.4, head_width=0.2
                    -[ WidthB=1.0, lengthB=0.2, angleB=None
                    <- head_length=0.4, head_width=0.2
                    fancy head_length=0.4, head_width=0.4, tail_width=0.4
                    simple head_length=0.5, head_width=0.5, tail_width=0.2
                    wedge tail_width=0.3, shrink_factor=0. 5

                    plt.axis([0, 10, 0, 20]);
                    arrstyles = ['-', '->', '-[', '<-', '<->', 'fancy', 'simple', 'wedge']
                    for i, style in enumerate(arrstyles):
                    plt.annotate(style, xytext=(1, 2+2*i), xy=(4, 1+2*i),
                    arrowprops=dict(arrowstyle=style));
                In [5]: connstyles=["arc", "arc,angleA=10,armA=30,rad=15",
                    "arc3,rad=.2", "arc3,rad=-.2", "angle", "angle3"]
                    In [6]: for i, style in enumerate(connstyles):
                    plt.annotate("", xytext=(6, 2+2*i), xy=(8, 1+2*i), arr
                    owprops=dict(arrowstyle='->', connectionstyle=style));
                    In [7]: plt.show()



            
            






