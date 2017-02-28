//实现计数器 时序逻辑 D触发器
module ex_cnt(
		input wire	sclk,
		input wire	rst_n,
		output wire		[9:0] cnt

);

reg	[7:0]	cnt_r;
always @(posedge sclk or negedge rst_n)
	if (rst_n == 1'b0)
		cnt_r<='d0; //这样不写几位 默认32位 截取10位来复制
	else
		cnt_r<=cnt_r+1'b1;
    assign cnt = cnt_r;
//仿真工具 modelsim
endmodule

//tb_ex_cnt.v 写模拟测试文件
`timescale 1ns/100ps  //时间基准 精度100ps 最小单位  延时1ns

module tb_ex_cnt;   //没有输出 输入端口 可以省略
	reg 	tb_sclk,tb_rst_n;//激励信号的声明
    wire    [9:0]   tb_cnt; //输出信号
	initial		//上电之后赋初始值  只被执行一次
	begin		//顺序执行 在begin end里面只能对reg变量复制
		tb_sclk<=0;//这两个语句之间有先后顺序 但是间隔是0
		tb_rst_n<=0;
		#200.1 		//间隔200ns100ps 再执行		
		tb_rst_n<=1
	end

always #10 tb_sclk <= ~tb_sclk; //过了10ns 进行后边的操作
                            //循环震荡周期是20ns

//例话的方法
//原始模块名字 例化的名字(自定义) 
ex_cnt ex_cnt_inst(
        .sclk   (tb_sclk),//这样便可以连接了
        .rst_n  (tb_rst_n),
        .cnt    (tb_cnt)    //例化模块的时候 如果原始模块是输出变量 那么
                            //括号内必须是wire变量
)
endmodule
