Spark Streaming：
    不用独立安装 已经集成到Spark中了    流处理运算  和Storm相似
    Streaming 基础Spark之上 运行在spark上


    input 
    data stream     Spark Streaming     batch data      spark   process



    kalka                                   HDFS
    Flume
    HDFS            Spark streaming         Databases 
    ZeroMQ
    Twitter                                 databoards


支持很多transformation和Spark基本一致：
    map flatMap filter count reduce etc
    groupByKey reduceByKey sortByKey join etc

    其他操作：
        带状态：
            updateStatebyKey
        window操作：    window 三个RDD
            window  countByWindow reduceByWindow    countByValueAndWindow 
            reduceByKeyAndWindow

    持久化：
        允许用户调用persist来持久化
        默认级别为： 内存+序列化
        对于window和stateful操作默认持久化
        对于来自网络的数据源 每份数据会在内存中存两份
