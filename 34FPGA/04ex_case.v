module ex_case(
        input wire  rst_n,
        input wire  sclk,
        output  reg         o_dv,
        output reg  [7:0]   o_data,
        input wire  [9:0]   i_data,
        input wire  [7:0]   i_add
);

reg    [2:0] cnt_7;
//不同功能的寄存器分开always块来写  可维护性强可读性强
//时钟信号 再FPGA内 使用金线做的 延迟低 
//数据线 使用铜线做的 质量不好 所以边沿触发 不要用其他寄存器
always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0) 
        cnt_7 <= 3'd0;
    else
        cnt_7 <= cnt_7 - 1'b1
always @(posedge sclk or negedge rst_n)
    if (rst_n == 1'b0) begin
        o_data <= 8'd0;
        o_dv <= 1'b0;
    end
    else begin
        //case 语句必须写下always块中 
        //case语句是一个并行处理的语句 并行触发的 
        //case对应电路中 编码器或者译码器
        //相对于 if else块很多  if else 是多级选择器
            //一级延迟可能是1ns 两级就是2ns
            //译码器就是一级
            //case在fpga中使用LUT实现 lookup table 也就是真值表
            
        case(cnt_7)
            3'd0: begin
                o_data<= 3'd7;
                o_dv<=1'b1;
                end
            3'd1:begin
                o_data<= 3'd0;
                o_dv<=1'b0;
                end
            3'd2:begin
                o_data<= 3'd5;
                o_dv<=1'b1;
                end
            default: begin
                o_data <= 3'd0;
                o_dv <= 1'd0;
                end
        endcase
    end


//组合逻辑 电平触发的
//消除锁存器  怎么做：1 把敏感列表写全  ：case条件 赋值语句的右边变量
// 2 所有条件分支写全
//如果产生 锁存器 布线不固定 没办法时序分析 定时炸弹

always @(cnt_7)
        case(cnt_7)
        3'd0: begin
            o_data<= 3'd7;
            o_dv<=1'b1;
            end
        3'd1:begin
            o_data<= 3'd0;
            o_dv<=1'b0;
            end
        3'd2:begin
            o_data<= 3'd5;
            o_dv<=1'b1;
            end
        default: begin
            o_data <= 3'd0;
            o_dv <= 1'd0;
            end
    endcase
endmodule



//tb_ex_case
`timescale  1ns/1ns



module  tb_ex_case;
reg     sclk,rst_n;
wire    [7:0]   data;
wire            dv;
reg     [7:0]   i_addr;
reg     [9:0]   i_data;
initial begin
    sclk    = 0;
    rst_n   = 0;
    #200
    rst_n   =1;

end

initial begin
    #500
    send_data(255);
end

always  #10 sclk <= ~sclk; //周期20ns时钟

ex_case ex_case_inst(
        .rst_n  (rst_n),
        .sclk   (sclk),
        .o_dv   (dv),
        .o_data (data),
        .i_data (i_data),
        .i_addr (i_addr)
);


//task语句 用于生成数据
task    send_data  (len);//任务的声明 过程描述
    integer len,i;//变量声明区 32变量integer
    begin
       for(i=0;i < len;i=i+1) begin //begin end顺序执行
            @(posedge sclk);
            i_addr <= i[7:0];
            i_data <= i[7:0];
       end 
       i_addr<=0;
       i_data<=0;
    end

endtask


endmodule



