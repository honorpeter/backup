commons-logging日志系统:
    commons-logging提供分级日志功能 有6级日志，但是apache建议使用4级，
            即 ERROR、WARN、INFO、DEBUG


        //导入类
        import org.apache.commons.logging.Log;
        import org.apache.commons.logging.LogFactory;
        public class TestLog
        {
            //获取以当前类为参数的日志对象
            private static Log log = LogFactory.getLog(TestLog.class);
            public static void main(String[] args){
                //输出4种不同级别的日志
                log.debug("111");
                log.info("222");
                log.warn("333");
                log.error("444");
            }
        }
