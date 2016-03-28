Advanced Matplotlib:
    Object-oriented versus MATLAB styles:
            three ways to use Matplotlib:
                pyplot : The module used so far in this book
                pylab : A module to merge Matplotlib and NumPy together in 
                        an environment closer to MATLAB
                Object-oriented way: The Pythonic way to interface with 
                        Matplotlib

        using the pylab interface:
                python -pylab
                x = arange(0, 10, 0.1)
                In [2]: y = randn(len(x))
                In [3]: plot(x, y)
                In [4]: title('random numbers')
                In [5]: show()
    A brief introduction to Matplotlib objects:
            Object
            FigureCanvas
            Figure
            Axes
                Container class for the Figure instance
                Container for one or more Axes instances
                The rectangular areas to hold the basic elements, such as 
                        lines, text, and so on


Subplots:
        fig = plt.figure() : This function returns a Figure , where we can 
                        add one or more Axes instances.
        ax = fig.add_subplot(111) : This function returns an Axes instance
            add_subplot(numrows, numcols, fignum):
                numrows represents the number of rows of subplots to prepare
                numcols represents the number of columns of subplots to 
                        prepare
            fignum varies from 1 to numrows * numcols and specifies the 
                        current subplot (the one used now)
                        表示显示的第几个 和matlob一样
                        numrows=2, numcols=2, fignum=1
                        numrows=2, numcols=2, fignum=3
                        numrows=2, numcols=2, fignum=2
                        numrows=2, numcols=2, fignum=4

                when all of them are less than 10
                    ax2 = fig.add_subplot(212)
                    which is equivalent to:
                    ax2 = fig.add_subplot(2, 1, 2)

                import matplotlib.pyplot as plt
                fig = plt.figure()
                ax1 = fig.add_subplot(211)
                ax1.plot([1, 2, 3], [1, 2, 3]);
                ax2 = fig.add_subplot(212)
                ax2.plot([1, 2, 3], [3, 2, 1]);
                plt.show()
    Additional Y (or X) axes:
                import matplotlib.pyplot as plt
                import numpy as np
                x = np.arange(0., np.e, 0.01)
                y1 = np.exp(-x)
                y2 = np.log(x)
                fig = plt.figure()
                ax1 = fig.add_subplot(111)
                ax1.plot(x, y1);
                ax1.set_ylabel('Y values for exp(-x)');
                ax2 = ax1.twinx()
                # this is the important function
                ax2.plot(x, y2, 'r');
                ax2.set_xlim([0, np.e]);
                ax2.set_ylabel('Y values for ln(x)');
                ax2.set_xlabel('Same X for both exp(-x) and ln(x)');
                plt.show()
        The twinx() function does the trick: it creates a second set of 
            axes, putting the new ax2 axes at the exact same position of 
            ax1 , ready to be used for plotting.    twiny()

    Logarithmic axes:
                [1]: import matplotlib as mpl
                [2]: mpl.rcParams['font.size'] = 10.
                [3]: import matplotlib.pyplot as plt
                [4]: import numpy as np
                [5]: x = np.arange(0., 20, 0.01)
                [6]: fig = plt.figure()
                [7]: ax1 = fig.add_subplot(311)
                [8]: y1 = np.exp(x/6.)
                [9]: ax1.plot(x, y1);
                [10]: ax1.grid(True)
                [11]: ax1.set_yscale('log')
                [12]: ax1.set_ylabel('log Y');
                [13]: ax2 = fig.add_subplot(312)
                [14]: y2 = np.cos(np.pi*x)
                [15]: ax2.semilogx(x, y2);
                [16]: ax2.set_xlim([0, 20]);
                [17]: ax2.grid(True)
                [18]: ax2.set_ylabel('log X');
                [19]: ax3 = fig.add_subplot(313)
                [20]: y3 = np.exp(x/4.)
                [21]: ax3.loglog(x, y3, basex=3);
                [22]: ax3.grid(True)
                [23]: ax3.set_ylabel('log X and Y');
                [24]: plt.show()
                
    Share axes:
                [1]: import matplotlib as mpl
                [2]: mpl.rcParams['font.size'] = 11.
                [3]: import matplotlib.pyplot as plt
                [4]: import numpy as np
                [5]: x = np.arange(11)
                [6]: fig = plt.figure()
                [7]: ax1 = fig.add_subplot(311)
                [8]: ax1.plot(x, x);
                [9]: ax2 = fig.add_subplot(312, sharex=ax1)
                [10]: ax2.plot(2*x, 2*x);
                [11]: ax3 = fig.add_subplot(313, sharex=ax1)
                [12]: ax3.plot(3*x, 3*x);
                [13]: plt.show()

    Plotting dates:

            page 96:
                import matplotlib as mpl
                import matplotlib.pyplot as plt
                import numpy as np
                import datetime as dt
                dates = [dt.datetime.today() + dt.timedelta(days=i) \
                    for i in range(10)]
                values = np.random.rand(len(dates))
                plt.plot_date(mpl.dates.date2num(dates), values, linestyle='-');
                plt.show()
                

    Text properties, fonts, and LaTeX:
            Fonts:
                font.family This property has five values:
                •	 serif (example, Times)
                •	 sans-serif (example, Helvetica)
                •	 cursive (example, Zapf-Chancery)
                •	 fantasy (example, Western)
                •	 monospace (example, Courier)
                font.style This property has three values: normal 
                    (or roman), italic, or oblique. The oblique style will 
                    be used for italic, if it is not present.
                font.weight
                font.variant
                font.size
                font.strtch
    Using LaTeX formatting:
            Mathtext:
                In [1]: import matplotlib.pyplot as plt
                In [2]: fig = plt.figure()
                In [3]: ax= fig.add_subplot(111)
                In [4]: ax.set_xlim([1, 6]);
                In [5]: ax.set_ylim([1, 9]);
                In [6]: ax.text(2, 8, r"$ \mu \alpha \tau \pi \lambda \omega \tau \
                lambda \iota \beta $");
                In [7]: ax.text(2, 6, r"$ \lim_{x \rightarrow 0} \frac{1}{x} $");
                In [8]: ax.text(2, 4, r"$ a \ \leq \ b \ \leq \ c \ \Rightarrow \ a \
                \leq \ c$");
                In [9]: ax.text(2, 2, r"$ \sum_{i=1}^{\infty}\ x_i^2$");
                In [10]: ax.text(4, 8, r"$ \sin(0) = \cos(\frac{\pi}{2})$");
                In [11]: ax.text(4, 6, r"$ \sqrt[3]{x} = \sqrt{y}$");
                In [12]: ax.text(4, 4, r"$ \neg (a \wedge b) \Leftrightarrow \neg a
                \vee \neg b$");
                In [13]: ax.text(4, 2, r"$ \int_a^b f(x)dx$");
                In [14]: plt.show()
                                
    Contour plots and image plotting
            Contour plots:
                matr = np.random.rand(21, 31)
                cs = plt.contour(matr)
                plt.show(
    Image plotting:
            imread() and imshow()
                imread() reads an image from a file
                    converts it into a NumPy array
                imshow()take an array as input and displays it on the screen
                import matplotlib.pyplot as plt
                f = plt.imread('/path/to/image/file.ext')
                plt.imshow(f)
            imshow() can plot any 2D sets of data:
                import matplotlib.pyplot as plt
                import numpy as np
                x = np.arange(-2, 2, 0.01)
                y = np.arange(-2, 2, 0.01)
                X, Y = np.meshgrid(x, y)
                ellipses = X*X/9 + Y*Y/4 - 1
                plt.imshow(ellipses);
                plt.colorbar();
                plt.show()

                                
                
                
                

