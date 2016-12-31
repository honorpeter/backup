The Module Search Path:
        When a module named spam is imported, the interpreter first searches
            for a built-in module with that name. If not found, it then 
            searches for a file named spam.py in a list of directories 
            given by the variable sys.path. sys.path is initialized from 
            these locations:

            the directory containing the input script (or the current 
                directory).
            PYTHONPATH (a list of directory names, with the same syntax 
                as the shell variable PATH).
            the installation-dependent default.
        After initialization, Python programs can modify sys.path.
    so: sys.path.append('folder')

Packages:
        Packages are a way of structuring Python’s module namespace by
             using “dotted module names”.

        example:
    sound/                          Top-level package
      __init__.py               Initialize the sound package
      formats/                  Subpackage for file format conversions
              __init__.py
              wavread.py
              wavwrite.py
              aiffread.py
              aiffwrite.py
              auread.py
              auwrite.py
              ...
      effects/                  Subpackage for sound effects
              __init__.py
              echo.py
              surround.py
              reverse.py
              ...
      filters/                  Subpackage for filters
              __init__.py
              equalizer.py
              vocoder.py
              karaoke.py
              ...
        The __init__.py files are required to make Python treat the 
                directories as containing packages
                it can also execute initialization code for the package or 
                    set the __all__ variable

        Importing * From a Package:
            ......


        包内互相调用:
            The submodules often need to refer to each other. For example, 
                    the surround module might use the echo module
            the import statement first looks in the containing package 
                    before looking in the standard module search path.
            If the imported module is not found in the current package 
                (the package of which the current module is a submodule), 
                the import statement looks for a top-level module with the 
                given name.
            包内支持相对路径:
                from . import echo
                from .. import formats
                from ..filters import equalizer
        Packages in Multiple Directories:
            Packages support one more special attribute, __path__. 
                This is initialized to be a list containing the name of 
                the directory holding the package’s __init__.py before
                the code in that file is executed. This variable can be 
                modified; doing so affects future searches for modules and 
                subpackages contained in the package.

    









