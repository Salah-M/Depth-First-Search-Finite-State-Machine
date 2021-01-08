module Memory #(parameter memsize = 100
)(address,data,clk,memload);
input [17:0] address;
input clk;
output reg [17:0] data;
input memload;
reg signed [17:0] mem [0:memsize-1];
always @ (posedge clk)
begin
if(memload==1)begin
	$readmemb("C:\\Users\\Salah\\Desktop\\tree_1binary.txt",mem,0,60);
end
else begin
data<=mem[address];
end
end
endmodule // Memory
