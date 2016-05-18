glog:   is a library that implements application-level logging
        provides logging APIs based on C++-style streams and helper macros

        命名空间是：
            google

Introduction:
            #include <glog/logging.h>
            
            int main(int argc, char* argv[]) {
                // Initialize Google's logging library.
                google::InitGoogleLogging(argv[0]);
                FLAGS_alsologtostderr = 1; //同时输出到stderr
            
                // ...
                LOG(INFO) << "Found " << num_cookies << " cookies";
            }
            INFO:severity level
            INFO, 
            WARNING, 
            ERROR
            FATAL
    Output default:
            glog writes to the filename 
                "/tmp/<program name>.<hostname>.<user name>.log.<severity 
                level>.<date>.<time>.<pid>"
            By default, glog copies the log messages of severity level 
                ERROR or FATAL to standard error (stderr) in addition to 
                log files.


Setting Flags:
        If the Google gflags library is installed:
            ./your_application --logtostderr=1  指定错误输出0 1
        If not: set flags via environment variables
            prefixing the flag name with "GLOG_", e.g
                 GLOG_logtostderr=1 ./your_application
    Commonly used flags:
        logtostderr (bool, default=false)
                Log messages to stderr instead of logfiles.
        stderrthreshold (int, default=2, which is ERROR)
                Copy log messages at or above this level to stderr in 
                addition to logfiles. The numbers of severity levels INFO, 
                WARNING, ERROR, and FATAL are 0, 1, 2, and 3, respectively.
        minloglevel (int, default=0, which is INFO):
                Log messages at or above this level. Again, the numbers of 
                severity levels INFO, WARNING, ERROR, and FATAL are 0, 1, 
                2, and 3, respectively.
        log_dir (string, default=""):
                If specified, logfiles are written into this directory 
                instead of the default logging directory.
        v (int, default=0)
                Show all VLOG(m) messages for m less or equal the value of 
                this flag
        vmodule (string, default="")
    You can also modify flag values in your program by modifying 
        global variables FLAGS_* .    before calling 
        google::InitGoogleLogging

Conditional / Occasional Logging:
        LOG_IF(INFO, num_cookies > 10) << "Got lots of cookies";
            message is logged only when the variable num_cookies exceeds 10
        LOG_EVERY_N(INFO, 10) << "Got the " << google::COUNTER << "th cookie";
            The above line outputs a log messages on the 1st, 11th, 
                21st, ... times it is executed. 
        LOG_IF_EVERY_N(INFO, (size > 1024), 10) << "Got the " ;
            ombine conditional and occasional logging
        LOG_FIRST_N(INFO, 20) << "Got the " << google::COUNTER << "th cookie";
            log messages for the first 20 times it is executed.

Debug Mode Support:
        only have an effect in debug mode:

        DLOG(INFO) << "Found cookies";
        DLOG_IF(INFO, num_cookies > 10) << "Got lots of cookies";
            

CHECK Macros:
        the check will be executed 
        CHECK(fp->Write(x) == 4) << "Write failed!";
        CHECK_EQ,
        CHECK_NE,
             CHECK_NE(1, 2) << ": The world must be ending!";
        CHECK_LE, 
        CHECK_LT,
        CHECK_GE,
        CHECK_G
        CHECK_NOTNULL(some_ptr);
        some_ptr->DoSomething();

Verbose Logging:
    VLOG(1) << "I'm printed when you run the program with --v=1 or higher";
    VLOG(2) << "I'm printed when you run the program with --v=2 or higher";

信号处理:
        
        SIGKILL信号不能扑捉
        使用google::InstallFailureSignalHandler(); 注册一下
        默认是打印到stderr中。

        可以使用InstallFailureWriter()定义输出方式。该宏为：
        GOOGLE_GLOG_DLL_DECL void InstallFailureWriter(
            void (*writer)(const char* data, int size));
        }
        
        

            
        









