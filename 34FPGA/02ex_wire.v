//选择器    组合逻辑
module ex_wire(
        input wire  sel,
        input wire  a,
        input wire  b,
        output wire  c
);
//wire只能使用 assign连续赋值语句赋值 而且必须使用阻塞赋值  = 表阻塞
assign c=(sel == 1'b1)?a:b; //c必须是wire变量 a b可以是reg变量
/*
* 同等于
*   if(sel == 1'b1)
    *   c = a;
*   else 
    *   c=b;
*/
endmodule









