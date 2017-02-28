//同步 异步 是相对于时钟的 如果clk具有最高优先级 那么是同步出发
//  如果clk和clr具有相同的优先级 那么是异步
module ex_module(
    // 模块声明
    input   wire    sclk,        //声明模块的时候 输入一定是 wire变量
    input   wire    rst_n,      //n 表示低信号 复位
    input   wire  [7:0] d,
    output  reg  [7:0] q     //模块 输出可以是wire变量 也可以是reg变量
    //语言规定 reg必须在always块里面赋值
); //声明模块的关键字module      name  (输入 输出)

//实现异步D触发器
always @(posedge sclk or negedge rst_n)  //()内 敏感列表 既可以电平出发 也可以前沿触发
    if(rst_n == 1'b0)   //条件表 这里是组合逻辑 1表示 1byte   b表示二进制 
                        //0表示 0了     1byte的二进制的0    2'b01
                        //十进制 d  十六进制h   
        q<=8'h00;       //沿出发的逻辑里面一定都是用<=非阻塞赋值
    else
        q<=d;
//同步D触发器
always @(posedge sclk)
    if(rst_n == 1'b0)
        q<=8'h00;
    else
        q<=d;

endmodule









