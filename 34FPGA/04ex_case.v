module ex_case(
        input wire  rst_n,
        input wire  sclk,
        output  reg         o_dv,
        output reg  [7:0]   o_data
);

reg    [2:0] cnt_7;
//不同功能的寄存器分开always块来写  可维护性强可读性强
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

endmodule









