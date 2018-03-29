python setup.py install --help
        
    Type of file	Override option
    Python modules	--install-purelib
    extension modules	--install-platlib
    all modules	--install-lib
    scripts	--install-scripts
    data	--install-data
    C headers	--install-headers


    python setup.py install --home=~ --install-scripts=scripts


    prefix:
        /usr/bin/python setup.py install --prefix=/usr/local
            Python modules	prefix/lib/pythonX.Y/site-packages
            extension modules	exec-prefix/lib/pythonX.Y/site-packages
            scripts	prefix/bin
            data	prefix
            C headers	prefix/include/pythonX.Y/distname
            
python setup.py build --help


clean:
    python setup.py clean --all
