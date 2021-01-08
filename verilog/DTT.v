module Top_lvl (start,clk,memload,MIN_WEIGHT,MIN_PATH_NODES,donee);
input start,clk,memload;
output reg [14:0] MIN_WEIGHT;
output reg [17:0] MIN_PATH_NODES;//therefore this will give the output each clockcycle for the minimum path
				//but we will lose the value after each clk cycle this shouldnt be an issue since
				//we would be able to see the values an i cant put an array as an output in verilog
output reg donee;


wire LD_path,LD_pm,LD_adrs,a1,LD_SA,sa3,sa1,LD_ix,SI1,SI2,LD_SI,LD_nk,nk1,LD_k,LD_SN,sn1,LD_nc,LD_wpm,wpm1,LD_wp,wp1,wp2,LD_w,LD_WK1,LD_mn,mn1,done;
wire [1:0] sn2;
wire [3:0] sa2;
wire [17:0] data;
wire stop,kone,DONE,SNumel,nc0,nc1,nc2,nc3,nc4,wl,wg;
wire [17:0] addres;
wire [17:0] pathm;
wire [14:0] wpathmin;


Memory m(.memload(memload),.clk(clk),.data(data),.address(addres));
Datapath d(.clk(clk),.LD_path(LD_path),.LD_pm(LD_pm),.LD_adrs(LD_adrs),.a1(a1),.LD_SA(LD_SA),.sa3(sa3),.sa1(sa1),.LD_ix(LD_ix),.SI1(SI1),.SI2(SI2),.LD_SI(LD_SI),.LD_nk(LD_nk),.nk1(nk1),.LD_k(LD_k),.LD_SN(LD_SN),.sn1(sn1),.LD_nc(LD_nc),.LD_wpm(LD_wpm),.wpm1(wpm1),.LD_wp(LD_wp),.wp1(wp1),.wp2(wp2),.LD_w(LD_w),.LD_WK1(LD_WK1),.LD_mn(LD_mn),.mn1(mn1),.done(done),.stop(stop),.DONE(DONE),.kone(kone),.SNumel(SNumel),.nc0(nc0),.nc1(nc1),.nc2(nc2),.nc3(nc3),.nc4(nc4),.wl(wl),.wg(wg),.addres(addres),.wpathmin(wpathmin),.pathm(pathm),.data(data),.sn2(sn2),.sa2(sa2));

FSM f(.sn2(sn2),.sa2(sa2),.start(start),.clk(clk),.LD_path(LD_path),.LD_pm(LD_pm),.LD_adrs(LD_adrs),.a1(a1),.LD_SA(LD_SA),.sa3(sa3),.sa1(sa1),.LD_ix(LD_ix),.SI1(SI1),.SI2(SI2),.LD_SI(LD_SI),.LD_nk(LD_nk),.nk1(nk1),.LD_k(LD_k),.LD_SN(LD_SN),.sn1(sn1),.LD_nc(LD_nc),.LD_wpm(LD_wpm),.wpm1(wpm1),.LD_wp(LD_wp),.wp1(wp1),.wp2(wp2),.LD_w(LD_w),.LD_WK1(LD_WK1),.LD_mn(LD_mn),.mn1(mn1),.done(done),.stop(stop),.DONE(DONE),.kone(kone),.SNumel(SNumel),.nc0(nc0),.nc1(nc1),.nc2(nc2),.nc3(nc3),.nc4(nc4),.wl(wl),.wg(wg));

always @(posedge clk) begin
if(DONE==1)begin
  MIN_PATH_NODES=pathm;
  MIN_WEIGHT = wpathmin;
  donee = DONE;
  end
end
endmodule //Top_lvl
