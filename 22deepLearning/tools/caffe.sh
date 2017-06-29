caffe使用Ctrl-c 不能保存模型：是因为使用的是 tee输出日志
    解决方法：kill -s SIGINT <proc_id>
        或者使用
        GLOG_log_dir=/path/to/log/dir $CAFFE_ROOT/bin/caffee.bin train 
            —solver=/path/to/solver.prototxt来输出日志
