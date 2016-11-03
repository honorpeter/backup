基本概念：
    transform：
        只是做了一个映射    结果并没有执行
    action：
        执行
术语解释：
    Application
        启动一个spark-shell  自动创建spark context
        一个spark context 就是application
    Job:
        包含多个任务的并行计算 可以和spark 的action对应

    Driver Program :
        运main函数 并且新建spark Context的程序
    Cluster Manager:
        在集群上获取资源的外部服务  管理集群
    Worker Node:
        集群中任何可以运行代码的几点
    Executor:
        是在一个worker node上位某个应用 启动的一个进行 该进程辅助运行任务
            并负责将数据存到内存或者磁盘上 每个应用都有各自独立的executor
    Task:
        被送到某个executor上的工作单元
    Stage：
        一个Job会被拆分为多组任务 每组任务被称为Stage


核心组件：
    
    your               spark client         cluster         worker
    program             RDD  graph          manager           task thread 
                        Schedular
                        Block tracker
                        shuffle tracker 


    RDD 分为几个partion  每个partion 都对应一个task
    数据本地性 ： 尽可能的不要移动数据 移动计算
        万一有数据置换出内存 直接从HDFS读取

    任务调度：
        RDD Objects:        DAGScheduler    TaskScheduler   Worker
                            split graph into   (Cluster 
                            stages of tasks      manager)
                            submit each         
                            stage as ready
                            面向stage的调度











