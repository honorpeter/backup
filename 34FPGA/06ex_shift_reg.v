//移位寄存器：
module ex_shift_reg(
            input   wire    lvds_clk,
            input   wire    rst_n,
            input   wire    lvds_d,
            output  reg     o_lvds_d    //输出最好都是　ｒｅｇ变量
);

reg     [7:0]   shift_reg;  //用于存储我们的串转并的数据
reg     [2:0]   s_cnt;
reg             s_flag;//以组合逻辑实现

//位拼接符　可以把不同位宽的数据拼在一起    {}
// {7'b1010_000 , 3'b010} --> 10'1010_000_010
//
always @(posedge lvds_clk or negedge rst_n)
    if(rst_n == 1'b0)
        shift_reg <= 'd0;
    else
        shift_reg  <= {shift_reg[6:0],lvds_d};
        

always @(posedge lvds_clk or negedge rst_n)
    if(rst_n == 1'b0)
        s_cnt <= 'd0;
    else
        s_cnt <= s_cnt + 1'b1;
        
always @(s_cnt)
    if(s_cnt == 3'd7)
        s_flag <= 1'b1
    else
        s_flag <= 1'b0; //这个分支条件一定要写全　不然生成锁存器


always @(posedge lvds_clk or negedge rst_n)
    if(rst_n == 1'b0)
        o__lvds_d <= 'd0;
    else if(s_flag == 1'b1)
        o_lvds_d <= shift_reg;

endmodule
        
//tb_ex_shift_reg
`timescale 1ns/1ns

module tb_ex_shift_reg
reg lvds_clock,rst_n;
reg [0:0]   mem1_16 [15:0]; //声明memory类型变量 可以使用地址访问
//前面的中括号 声明的是位宽0:0 表示1byte   [15:0]声明位深

initial begin
    lvds_clock = 0;
    rst_n = -;
    #100
    rst_n = 1;
end
initial begin
    $readmemb("data.txt",mem1_16)   //$表示调用系统函数 readmemb读取内存二进制
                            //第一个参数 读取文件的地址 第二个读到哪里
end

initial begin
    #100
    lvds_send_data();
end

//读取mem
task    lvds_send_d();
    integer i;
    begin
        for(i <= 0; i < 255; i<= i + 1)
        begin
            @(posedge lvds_clock);
            mem1_16[i[3:0]] = 1'b0;
        end
    end
endtask

endmodule








