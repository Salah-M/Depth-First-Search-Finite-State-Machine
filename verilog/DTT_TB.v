module test_benchDTT ();
`timescale 1 ns/10 ps
reg clk,start,memload;
wire done;
wire [17:0] MIN_PATH_NODES;
wire [14:0] MIN_WEIGHT;
Top_lvl t(start,clk,memload,MIN_WEIGHT,MIN_PATH_NODES,done);
always
#26 clk=~clk;

initial begin
memload =1 ;start=0;clk=0;
#100
start=1;memload=0;clk=0;
#53
start=0;
end
endmodule //test_benchDTT
