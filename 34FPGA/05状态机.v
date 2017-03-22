//状态机：
        //由寄存器组和组合逻辑构成的硬件时序电路
        //

module ex_fsm(
    input wire  sclk,  
    input wire  rst_n,
    output reg  k1,
    output  reg k2,
    input   wire   A
);

//reg     [1:0]   state;
//2b'00 2b'01 2b'10 2b'11   二进制编码用的寄存器数量少 
//最好 不要用 二进制编码 容易出现中间状态 出问题
//但是用的组合逻辑资源多    if(state == 2'b11)  比较器是一个2byte的
//reg   [3:0]   4'b0001 4b0010  4b'0100 4b'1000 杜热玛占用寄存器数量多
// 但是用的组合逻辑资源少   if(state == 4'b0001) 优化 if(state[0] == 1'b1)
parameter   IDLE    = 4'b0001;
parameter   START   =   4'b0010;
parameter   STOP    =   4'b0100;
parameter   CLEAR   =   4'b1000;

reg     [3:0]   state;
//第一段描述状态机
always @(posedge sclk or negedge rst_n)
    if(rst_n ==  1'b0)
        state<= IDLE;
    else
        case(state)
            IDLE:if(A == 1'b1)
                    state <= START;
            START:if(A == 1'b0)
                state <=  STOP;
            STOP: if(A==1'b1)
                state <= CLEAR
            CLEAR: if(A==1'1)
                STATE <= IDLE;
            default:state <= IDLE;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        k <= 1'b0;
    else if(state == IDLE && A == 1'b1)
        k1 < = 1'b0;
    else if (state == CLEAR && A == 1'b0)
        k1<=1'b1;

always @(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
        k2<=1'b0
    else if(state == stop && A==1'1)
        k2<= 1'b1;
    else if(state == CLEAR && A==1'b0)
        k2<= 1'b0;

endmodule










