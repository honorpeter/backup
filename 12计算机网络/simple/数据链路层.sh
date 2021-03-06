数据链路层的作用
    1 为网络层提供一个良好的接口
    2 定义一个合适的传输差错率
    3 对数据流进行管理
为网络层提供的服务
    无确认 无连接服务
            发送数据之前不与接收方 发起链接
            直接发送一个帧的数据不用等待对方发送确认 
            继续发送下一个帧的数据
    有确认 无连接
            发送数据之前不与接收方 发起链接
            直接发送一个帧的数据 等待对方发送确认 
            再发送下一个帧的数据
    有确认 有连接
            发送数据之前与接收方 发起链接
            链接好了发送一个帧的数据 等待对方发送确认 
            再发送下一个帧的数据
            

发送的基本单元为一个贞

怎么组织一个帧
    1 字符统计法
        基本没有协议用这个方法
        帧头为 数字 告诉接收方几个 但是一个错了后面全错
    2 带字符填充的首尾届符法
        每一个帧 首尾都有 相同的字符 如7E 不常用的字符
        如果帧里面的数据 和 首尾的字符相同时
            插入 另一个字符 如 1B  
            如果 1B 也有的话  在前面再 插入1B
        接收方去掉这些 插入的字符
    3 带位填充的首尾标志法
        帧的首尾 都是用    111111
            如果 帧内容里面有相同
                则在 第五位后面插入0
               接收方 去掉0
    4 物理层编码违例法
        物理层  首尾 和 内容使用 不同编码发送

可靠性传输
    差错控制： 校验 重发 和 序号
        避免帧错误 的保证： 帧的校验
        避免帧丢失的保证： 超时和重发
        避免帧重复的保证： 帧有序号

    校验方法：
        校验和： 算法简单 实现容易 但纠错强度弱
            按 8 位 16位 。。。分割 每段求和 有进位
            加到 最后的求和中
            一般用在 距离近的网络中
        块校验：
            分段 求与 8位进行与或 进行校验
            强度弱
        循环冗余校验发(CRC)：
            强度更大


    将数据和 校验值一起发过去
    对方确认：
            必须经过错误检错才可以发送
        肯定性确认  
        如果检验出错发送 否定确认  将会重发

    数据帧丢失：
        发送方 定时器 解决发送方发送的数据丢失
        超时：重发 
            接收方发送的确认丢失 会导致： 接收方重复数据帧
    重复帧：帧序号解决

基于以上探讨： 一个帧 应该拥有一下内容
    帧类型  帧序号  确认号  信息数据 校验值

    流量控制
        发送方的速度太快 接收方接收不了 则需要流量控制
            太快接收不了 告诉发送方 等会再发

数据链路层协议：
    单工协议：只有一个发送方
    基本链路协议：
        协议1 ：无限制的单工协议： 什么都没有治愈要发送就行
        协议2 ：等协议
                不需要 差错控制  但 必须进行流量控制
        协议3： 噪声信道单工协议
            
    双工协议：双发 即使发送放也是接收方
    滑动窗口协议：
        协议4:  1 1
        协议5:  
        协议6:
