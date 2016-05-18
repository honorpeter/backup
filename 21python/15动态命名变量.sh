在C这种静态语言里，变量名这个标识符实际上会被编译器直接翻译成内存地址
        所以除了手动设置每个变量的值以外，没办法做到这点。而Python这种动态
        语言则是可以做到的。
    可以使用eval，但是危险
    Python的变量名就是一个字典的key而已。要获取这个字典，直接用
                locals和globals函数即可。   全局变量字典 局部变量字典

        createVar = locals()
        listTemp = range(1,10)
        for i,s in enumerate(listTemp):
            createVar['a'+i] = s        或则locals()['a'+i]=s 
        print a1,a2,a3

    对于class，推荐使用setattr()方法:
        class test(object) :
            def __init__(self,**dic):
                self.name="jon"
                for i in dic.keys() :
                    setattr(self,i,dic[i]) 
                        #第一个参数是对象，这里的self 其实就是test.
                        #第二个参数是变量名，第三个是变量值
        测试： 
            >>>t=test(a="1",b="2",c="3")
            >>>print t.a,t.b,t.c
            1 2 3
        class里面不能使用locals()来赋值因为locals()是__init__函数的
            而我们需要的是test类的成员，也就是self.a，self.b，self.c……
            比__init__还要高一级的。










