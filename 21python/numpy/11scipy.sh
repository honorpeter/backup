Optimization and Minimization:
            import numpy as np
            from scipy.optimize import curve_fit
            # Creating a function to model and create data
            def func(x, a, b):
                return a * x + b
            # Generating clean data
            x = np.linspace(0, 10, 100)
            y = func(x, 1, 2)
                        # Adding noise to the data
            yn = y + 0.9 * np.random.normal(size=len(x))
            # Executing curve_fit on noisy data
            popt, pcov = curve_fit(func, x, yn)
            # popt returns the best fit values for parameters of
            # the given model (func).
            print(popt)

读取图片：
        from scipy import misc

        image = misc.imread(fp)     Read an image from a file as an array
                
            def imread(name, flatten=False, mode=None):
                flatten : bool, optional
                    If True, flattens the color layers into a 
                            single gray-scale layer.
                mode : str, optional
                    Mode to convert image to,
                    `imread` uses the Python Imaging Library (PIL) to 
                            read an image.
                            * 'L' (8-bit pixels, black and white)
        * 'P' (8-bit pixels, mapped to any other mode using a color palette)
        * 'RGB' (3x8-bit pixels, true color)
        * 'RGBA' (4x8-bit pixels, true color with transparency mask)
        * 'CMYK' (4x8-bit pixels, color separation)
        * 'YCbCr' (3x8-bit pixels, color video format)
        * 'I' (32-bit signed integer pixels)
        * 'F' (32-bit floating point pixels)









