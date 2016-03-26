python之强大的日志模块:
        1.简单的将日志打印到屏幕:
            import logging

            logging.debug('This is debug message')
            logging.info('This is info message')
            logging.warning('This is warning message')
            
            屏幕上打印:
            WARNING:root:This is warning message

            默认情况下，logging将日志打印到屏幕，日志级别为WARNING；
            日志级别大小关系为：CRITICAL > ERROR > WARNING > INFO > DEBUG > 
                NOTSET，当然也可以自己定义日志级别
        2.通过logging.basicConfig函数对日志的输出格式及方式做相关配置:
            
            import logging
            
            logging.basicConfig(level=logging.DEBUG,
                format='%(asctime)s %(filename)s[line:%(lineno)d] %(levelname)s %(message)s',
                datefmt='%a, %d %b %Y %H:%M:%S',
                filename='myapp.log',
                filemode='w')
    
            logging.debug('This is debug message')
            logging.info('This is info message')
            logging.warning('This is warning message')
 
            ./myapp.log文件中内容为:
Sun, 24 May 2009 21:48:54 demo2.py[line:11] DEBUG This is debug message
Sun, 24 May 2009 21:48:54 demo2.py[line:12] INFO This is info message
Sun, 24 May 2009 21:48:54 demo2.py[line:13] WARNING This is warning message
            logging.basicConfig函数各参数:
            filename: 指定日志文件名
            filemode: 和file函数意义相同，指定日志文件的打开模式，'w'或'a'
            format: 指定输出的格式和内容，
                    format可以输出很多有用信息，如上例所示:
                %(levelno)s: 打印日志级别的数值
                %(levelname)s: 打印日志级别名称
                %(pathname)s: 打印当前执行程序的路径，其实就是sys.argv[0]
                %(filename)s: 打印当前执行程序名
                %(funcName)s: 打印日志的当前函数
                %(lineno)d: 打印日志的当前行号
                %(asctime)s: 打印日志的时间
                %(thread)d: 打印线程ID
                %(threadName)s: 打印线程名称
                %(process)d: 打印进程ID
                %(message)s: 打印日志信息
            datefmt: 指定时间格式，同time.strftime()
            level: 设置日志级别，默认为logging.WARNING
            stream: 指定将日志的输出流，可以指定输出到sys.stderr,
                sys.stdout或者文件，默认输出到sys.stderr，当stream和
                filename同时指定时，stream被忽略

        logging库提供了多个组件：Logger、Handler、Filter、Formatter。Logger
            对象提供应用程序可直接使用的接口，Handler发送日志到适当的目的地
            Filter提供了过滤日志信息的方法，Formatter指定日志显示格式。
        Logger
            Logger是一个树形层级结构，输出信息之前都要获得一个Logger（如果
             没有显示的获取则自动创建并使用root Logger，如第一个例子所示）。
        logger = logging.getLogger()返回一个默认的Logger也即root Logger，
            并应用默认的日志级别、Handler和Formatter设置。
        当然也可以通过Logger.setLevel(lel)指定最低的日志级别，可用的日志级别
            有logging.DEBUG、logging.INFO、logging.WARNING、logging.ERROR
                logging.CRITICAL。
        Logger.debug()、Logger.info()、Logger.warning()、Logger.error()、
            Logger.critical()输出不同级别的日志，只有日志等级大于或等于
            设置的日志级别的日志才会被输出。

            #coding:utf-8  
            import logging  
            
            # 创建一个logger    
            logger = logging.getLogger()  
            
            logger1 = logging.getLogger('mylogger')  
            logger1.setLevel(logging.DEBUG)  
            
            logger2 = logging.getLogger('mylogger')  
            logger2.setLevel(logging.INFO)  
            
            logger3 = logging.getLogger('mylogger.child1')  
            logger3.setLevel(logging.WARNING)  
            
            logger4 = logging.getLogger('mylogger.child1.child2')  
            logger4.setLevel(logging.DEBUG)  
            
            logger5 = logging.getLogger('mylogger.child1.child2.child3')  
            logger5.setLevel(logging.DEBUG)  
            
            # 创建一个handler，用于写入日志文件    
            fh = logging.FileHandler('/tmp/test.log')  
            
            # 再创建一个handler，用于输出到控制台    
            ch = logging.StreamHandler()  
            
            # 定义handler的输出格式formatter    
            formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')  
            fh.setFormatter(formatter)  
            ch.setFormatter(formatter)  
            
            #定义一个filter  
            #filter = logging.Filter('mylogger.child1.child2')  
            #fh.addFilter(filter)    
            
            # 给logger添加handler    
            #logger.addFilter(filter)  
            logger.addHandler(fh)  
            logger.addHandler(ch)  
            
            #logger1.addFilter(filter)  
            logger1.addHandler(fh)  
            logger1.addHandler(ch)  
            
            logger2.addHandler(fh)  
            logger2.addHandler(ch)  
            
            #logger3.addFilter(filter)  
            logger3.addHandler(fh)  
            logger3.addHandler(ch)  
            
            #logger4.addFilter(filter)  
            logger4.addHandler(fh)  
            logger4.addHandler(ch)  
            
            logger5.addHandler(fh)  
            logger5.addHandler(ch)  
            
            # 记录一条日志    
            logger.debug('logger debug message')  
            logger.info('logger info message')  
            logger.warning('logger warning message')  
            logger.error('logger error message')  
            logger.critical('logger critical message')  
            
            logger1.debug('logger1 debug message')  
            logger1.info('logger1 info message')  
            logger1.warning('logger1 warning message')  
            logger1.error('logger1 error message')  
            logger1.critical('logger1 critical message')  
            
            logger2.debug('logger2 debug message')  
            logger2.info('logger2 info message')  
            logger2.warning('logger2 warning message')  
            logger2.error('logger2 error message')  
            logger2.critical('logger2 critical message')  
            
            logger3.debug('logger3 debug message')  
            logger3.info('logger3 info message')  
            logger3.warning('logger3 warning message')  
            logger3.error('logger3 error message')  
            logger3.critical('logger3 critical message')  
            
            logger4.debug('logger4 debug message')  
            logger4.info('logger4 info message')  
            logger4.warning('logger4 warning message')  
            logger4.error('logger4 error message')  
            logger4.critical('logger4 critical message')  
            
            logger5.debug('logger5 debug message')  
            logger5.info('logger5 info message')  
            logger5.warning('logger5 warning message')  
            logger5.error('logger5 error message')  
            logger5.critical('logger5 critical message')  
                        
    


                
            










