Making Your Own Classes :
    class Person:
        def setName(self, name):
            self.name = name
        def getName(self):
            return self.name
        def greet(self):
            print "Hello, world! I'm %s." % self.name

    foo = Person()
    __便可以 将属性或方法变为私有
    To make a method or attribute private (inaccesible from the outside), 
        simply start its name with two underscores:
        def __inaccessible(self):
        但是还是可以访问的:
            foo._Person__inaccessible() 
                __方法被翻译成这种形式   _类名      不建议这么做

    isinstance:

Attributes, Functions, and Methods:
    

指定超类: 继承:
    class Filter:
        def init(sel):
            print "hhhh"

    class SPAMFilter(Filter):   括号指定超类 父类

    查看一个类是不是另一个类的子类: issubclass函数:
        issubclass(SPAMFilter,Filter)
            True
    检查一个对象是否为一个类的实例:
        isinstance(s,SPAMFilter)

    多个超类:                   多继承
        SPAMFilter(Filter,Hh)

构造方法:
        __init__()  声明对象的时候自动执行  
        __del__()   析构方法






