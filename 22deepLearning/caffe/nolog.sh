设置glog不输出log信息：python
    import os
    os.environ["GLOG_minloglevel"] = "1"
    import caffe

