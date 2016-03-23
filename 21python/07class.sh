Making Your Own Classes :
    class Person:
        def setName(self, name):
            self.name = name
        def getName(self):
            return self.name
        def greet(self):
            print "Hello, world! I'm %s." % self.name

    foo = Person()
    To make a method or attribute private (inaccesible from the outside), 
        simply start its name with two underscores:
        def __inaccessible(self):








