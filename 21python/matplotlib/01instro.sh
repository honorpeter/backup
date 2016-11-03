Output formats:
        Raster images:
            png jpg bmp
                these images is like a matrix, with rows and columns
                at every matrix cell we have a pixel description
                An important parameter for raster images is the DPI
                     (dots-per-inch) value 分辨率
        Vector images:
            mathematical equations and geometrical primitives
        Matplotlib supports both the categories particularly:
            EPS Vector Encapsulated PostScript.
            JPG Raster Graphic format with lossy compression method for 
                            photographic output.
            PDF Vector Portable Document Format (PDF).
            PNG Raster Portable Network Graphics (PNG), a raster graphics 
                        format with a lossless compression method 
            PS Vector Language widely used in publishing and as printers 
                        jobs format.
            SVG Vector Scalable Vector Graphics (SVG), XML based.

Build dependencies:
        python 
        numpy
        libpng
        freeType

                
pylab matplotlib绘图
            sin函数 绘制:
                import numpy as np
                import matplotlib.pyplot as plt
                x = np.arange(0,5,0.1)
                y = np.sin(x)
                plt.plot(x,y)
                plt.show()


Pyplot:
        matplotlib.pyplot is a collection of command style functions that 
                make matplotlib work like MATLAB
                Each pyplot function makes some change to a figure:
                    creates a figure creates a plotting area in a figure..
Getting Started with Matplotlib:
        First plot:
            import matplotlib.pyplot as plt
            plt.plot([1, 3, 2, 4])   default x= 1 2 3 4.... y is the arg
            plt.show()
        Multiline plots:
                import matplotlib.pyplot as plt
                x = range(1, 5)
                plt.plot(x, [xi*1.5 for xi in x])
                [<matplotlib.lines.Line2D object at 0x2076ed0>]
                plt.plot(x, [xi*3.0 for xi in x])
                [<matplotlib.lines.Line2D object at 0x1e544d0>]
                plt.plot(x, [xi/3.0 for xi in x])
                [<matplotlib.lines.Line2D object at 0x20864d0>]
                plt.show()
    
                automatically chooses different colors for each line
                another syntax :
                plt.plot(x, [xi*1.5 for xi in x], x, [xi*3.0 for xi in x], \
                        x,[xi/3.0 for xi in x])
                plt.show()
            set:
                plt.hold(False) # empty window will pop up
                    each plot() command overwrites the current figure.
    Grid, axes, and labels:
            Adding a grid:
                x = np.arange(1, 5)
                plt.plot(x, x*1.5, x, x*3.0, x, x/3.0)
                plt.grid(True)
                plt.show()
            Handling axes:
                x = np.arange(1, 5)
                In [4]: plt.plot(x, x*1.5, x, x*3.0, x, x/3.0)
                plt.axis() # shows the current axis limits values
                plt.axis([0, 5, -1, 13]) # set new axes limits
                plt.show()
    
                two ways to pass parameters to axis() : by a list of four 
                        values or by keyword arguments
                        keyword arguments [xmin, xmax, ymin, ymax]
                        access them:
                            plt.xlim()....

            Adding labels:
                        plt.plot([1, 3, 2, 4])
                        [<matplotlib.lines.Line2D object at 0x26f8f10>]
                        plt.xlabel('This is the X axis')
                        <matplotlib.text.Text object at 0x26e9110>
                        plt.ylabel('This is the Y axis')
                        <matplotlib.text.Text object at 0x26e9cd0>
                        plt.show()
            Titles and legends:
                Adding a title:
                        plt.title('Simple plot')
                Adding a legend:
                        x = np.arange(1, 5)
                        plt.plot(x, x*1.5, label='Normal')
                        plt.plot(x, x*3.0, label='Fast')
                        plt.plot(x, x/3.0, label='Slow')
                        plt.legend()
                        plt.show()
                        or:
                        plt.plot(x, x*1.5)
                        plt.plot(x, x*3.0)
                        plt.plot(x, x/3.0)
                        plt.legend(['Normal', 'Fast', 'Slow'])
    Saving plots to a file:
                        plt.savefig('plot123.png')
                            file format is based on the filename extension
                    the figure size and the DPI: default value 
                        import matplotlib as mpl
                        mpl.rcParams['figure.figsize']
                        [8.0, 6.0]
                        mpl.rcParams['savefig.dpi']
                        100
                        an 8x6 inches figure with 100 DPI results 
                                                in an 800x600 pixels image
                    set the DPI value when saving:
                        plt.savefig('plot123_2.png', dpi=200)
                    plot to a file without any display available:
                        import matplotlib as mpl
                        mpl.use('Agg') #before importing pyplot
                        import matplotlib.pyplot as plt
                        plt.plot([1,2,3])
                        plt.savefig('plot123_3.png')
    Interactive navigation toolbar:
                import matplotlib as mpl
                mpl.use('GTKAgg') # to use GTK UI
                import matplotlib.pyplot as plt
                plt.plot([1, 3, 2, 4])
                plt.show()
    Controlling the interactive mode:
            interactive property is available in the rcParams dictionary:
                import matplotlib as mpl
                mpl.rcParams['interactive']
            also change it using a Matplotlib function::
                mpl.interactive(False)

                isinteractive() : Returns True or False , the value of 
                                    interactive property
            	ion() : Enables interactive mode
            	ioff() : Disables interactive mode
            	draw() : Forces a figure canvas redraw
    Configuring Matplotlib:
            Global machine configuration file: This is used to configure 
                    Matplotlib for all the users of the machine.
                    /etc/matplotlibrc 
            User configuration file: A separate file for each use
                    $HOME/.matplotlib/matplotlibrc
            Configuration file in the current directory: Used for specific 
                    customization to the current script or program
            Python code in the current script or program or interactive 
                    session
    Configuration files:
            interactive Specifies to enable the interactive mode (boolean).
            line.linewidth Specifies the default line width (in points) 
                    used on plots.
            line.linecolor Specifies the default line color used on plots.
            figure.figsize Specifies the figure sizes, in inches.
            savefig.dpi Specifies the DPI when saving to file.
            savefig.edgecolor Specifies the edge color when saving to file.
            savefig.facecolor Specifies the face color when saving to file.
    Configuring through the Python code
            import matplotlib as mpl
            mpl.rcParams

                    
                        
    





