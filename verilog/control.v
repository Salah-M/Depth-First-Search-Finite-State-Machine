module FSM (LD_path,LD_pm,LD_adrs,a1,LD_SA,sa3,sa1,sa2,LD_ix,SI1,SI2,LD_SI,LD_nk,nk1,LD_k,LD_SN,sn1,sn2,LD_nc,LD_wpm,wpm1,LD_wp,wp1,wp2,LD_w,LD_WK1,LD_mn,mn1,done,clk,start,stop,DONE,kone,SNumel,nc0,nc1,nc2,nc3,nc4,wl,wg);
output reg LD_path,LD_pm,LD_adrs,a1,LD_SA,sa3,sa1,LD_ix,SI1,SI2,LD_SI,LD_nk,nk1,LD_k,LD_SN,sn1,LD_nc,LD_wpm,wpm1,LD_wp,wp1,wp2,LD_w,LD_WK1,LD_mn,mn1,done;
output reg [1:0] sn2;
output reg [3:0] sa2;
input clk,start,stop,DONE,kone,SNumel,nc0,nc1,nc2,nc3,nc4,wl,wg;
parameter START= 15'b000000000000001,ENTERLOOP = 15'b000000000000010,DECREMENTK=15'b000000000000100,GETIX=15'b000000000001000,GETSTACKIX=15'b000000000010000,GETnc=15'b000000000100000,ROOTW=15'b000000001000000,GETWEIGHTK1=15'b000000010000000,GETWEIGHTW=15'b000000100000000,CHILD1=15'b000001000000000,CHILD2=15'b000010000000000,CHILD3=15'b000100000000000,CHILD4=15'b001000000000000,LEAFNODE=15'b010000000000000,DONESTAGE=15'b100000000000000;

reg [14:0] state,nstate;
always @(posedge clk)
if(start)
state<=START;
else state<=nstate;

always @(state or start or stop or DONE or kone or SNumel or nc0 or nc1 or nc2 or nc3 or nc4)
begin
LD_path=0;LD_pm=0;LD_adrs=0;a1=0;LD_SA=0;sa3=0;sa1=0;sa2=0;LD_ix=0;SI1=0;SI2=0;LD_SI=0;LD_nk=0;nk1=0;LD_k=0;LD_SN=0;sn1=0;sn2=0;LD_nc=0;LD_wpm=0;
wpm1=0;LD_wp=0;wp1=0;wp2=0;LD_w=0;LD_WK1=0;LD_mn=0;mn1=0;
nstate= START;
case(state)
START:  begin
	if(start==0) begin nstate=START;
        LD_path=0;LD_pm=0;LD_adrs=0;a1=0;LD_SA=0;sa3=0;sa1=0;sa2=0;LD_ix=0;SI1=0;SI2=0;LD_SI=0;LD_nk=0;nk1=0;LD_k=0;LD_SN=0;sn1=0;sn2=0;LD_nc=0;LD_wpm=0;
        wpm1=0;LD_wp=0;wp1=0;wp2=0;LD_w=0;LD_WK1=0;LD_mn=0;mn1=0;done=0;
        end
        else if(start) begin
        LD_path=0;LD_pm=0;LD_adrs=0;a1=0;LD_SA=1;sa3=0;sa1=0;sa2=0;LD_ix=0;SI1=0;SI2=0;LD_SI=1;LD_nk=1;nk1=0;LD_k=0;LD_SN=1;sn1=0;sn2=0;LD_nc=0;LD_wpm=1;
        wpm1=0;LD_wp=0;wp1=0;wp2=0;LD_w=0;LD_WK1=0;LD_mn=0;mn1=0;done=0;
        end
        if(DONE==0) nstate= ENTERLOOP;
	end
ENTERLOOP:  begin
	    LD_path=0;LD_pm=0;LD_adrs=0;a1=0;LD_SA=0;sa3=0;sa1=0;sa2=0;LD_ix=0;SI1=0;SI2=0;LD_SI=0;LD_nk=0;nk1=0;LD_k=1;LD_SN=0;sn1=0;sn2=0;LD_nc=0;LD_wpm=0;
            wpm1=0;LD_wp=0;wp1=0;wp2=0;LD_w=0;LD_WK1=0;LD_mn=0;mn1=0;
            if(SNumel==1) nstate = DECREMENTK;
            else if(SNumel==0) nstate = GETIX;
	    end
DECREMENTK: begin
	    LD_path=0;LD_pm=0;LD_adrs=0;a1=0;LD_SA=0;sa3=0;sa1=0;sa2=0;LD_ix=0;SI1=0;SI2=0;LD_SI=0;LD_nk=1;nk1=2;LD_k=0;LD_SN=0;sn1=0;sn2=0;LD_nc=0;LD_wpm=0;
            wpm1=0;LD_wp=0;wp1=0;wp2=0;LD_w=0;LD_WK1=0;LD_mn=0;mn1=0;
            if(DONE==0) nstate=ENTERLOOP;
            else if(DONE==1) nstate = DONESTAGE;
	    end
GETIX:      begin
            LD_path=1;LD_pm=0;LD_adrs=1;a1=1;LD_SA=0;sa3=0;sa1=0;sa2=4;LD_ix=1;SI1=0;SI2=0;LD_SI=0;LD_nk=0;nk1=0;LD_k=0;LD_SN=1;sn1=0;sn2=1;LD_nc=0;LD_wpm=0;
            wpm1=0;LD_wp=0;wp1=0;wp2=0;LD_w=1;LD_WK1=0;LD_mn=0;mn1=0;
            nstate= GETSTACKIX;
            end
GETSTACKIX: begin
            LD_path=0;LD_pm=0;LD_adrs=1;a1=0;LD_SA=0;sa3=0;sa1=0;sa2=4;LD_ix=0;SI1=0;SI2=1;LD_SI=1;LD_nk=0;nk1=0;LD_k=0;LD_SN=0;sn1=0;sn2=0;LD_nc=0;LD_wpm=0;
            wpm1=0;LD_wp=0;wp1=0;wp2=0;LD_w=0;LD_WK1=0;LD_mn=0;mn1=0;
            nstate= GETnc;
            end
GETnc:      begin
            LD_path=0;LD_pm=0;LD_adrs=1;a1=0;LD_SA=0;sa3=0;sa1=0;sa2=4;LD_ix=0;SI1=0;SI2=0;LD_SI=0;LD_nk=0;nk1=0;LD_k=0;LD_SN=0;sn1=0;sn2=0;LD_nc=1;LD_wpm=0;
            wpm1=0;LD_wp=0;wp1=0;wp2=0;LD_w=0;LD_WK1=0;LD_mn=0;mn1=0;
            if(kone==0) nstate= GETWEIGHTK1;
            else if (kone==1) nstate=ROOTW;
            end
ROOTW:      begin
            LD_path=0;LD_pm=0;LD_adrs=0;a1=0;LD_SA=0;sa3=0;sa1=0;sa2=0;LD_ix=0;SI1=0;SI2=0;LD_SI=0;LD_nk=0;nk1=0;LD_k=0;LD_SN=0;sn1=0;sn2=0;LD_nc=0;LD_wpm=0;
            wpm1=0;LD_wp=1;wp1=0;wp2=0;LD_w=0;LD_WK1=0;LD_mn=0;mn1=0;
            if(nc0==1 && wl==1) nstate= LEAFNODE;
            else if(nc1==1) nstate = CHILD1;
            end
GETWEIGHTK1:  begin
              LD_path=0;LD_pm=0;LD_adrs=0;a1=0;LD_SA=0;sa3=0;sa1=0;sa2=0;LD_ix=0;SI1=0;SI2=0;LD_SI=0;LD_nk=0;nk1=0;LD_k=0;LD_SN=0;sn1=0;sn2=0;LD_nc=0;LD_wpm=0;
              wpm1=0;LD_wp=0;wp1=1;wp2=0;LD_w=0;LD_WK1=1;LD_mn=0;mn1=0;
              nstate= GETWEIGHTW;
              end
GETWEIGHTW: begin
            LD_path=0;LD_pm=0;LD_adrs=0;a1=0;LD_SA=0;sa3=0;sa1=0;sa2=0;LD_ix=0;SI1=0;SI2=0;LD_SI=0;LD_nk=0;nk1=0;LD_k=0;LD_SN=0;sn1=0;sn2=0;LD_nc=0;LD_wpm=0;
            wpm1=0;LD_wp=1;wp1=0;wp2=1;LD_w=0;LD_WK1=0;LD_mn=0;mn1=0;
            if(nc0==1 && wl==1) nstate= LEAFNODE;
            else if(nc1==1) nstate = CHILD1;
            end
LEAFNODE:   begin
            LD_path=0;LD_pm=1;LD_adrs=0;a1=0;LD_SA=0;sa3=0;sa1=0;sa2=0;LD_ix=0;SI1=0;SI2=0;LD_SI=0;LD_nk=0;nk1=0;LD_k=0;LD_SN=0;sn1=0;sn2=0;LD_nc=0;LD_wpm=1;
            wpm1=1;LD_wp=0;wp1=0;wp2=0;LD_w=0;LD_WK1=0;LD_mn=1;mn1=0;
            nstate = DECREMENTK;
            end
CHILD1:     begin
            LD_path=0;LD_pm=0;LD_adrs=1;a1=0;LD_SA=1;sa3=1;sa1=1;sa2=0;LD_ix=0;SI1=1;SI2=0;LD_SI=1;LD_nk=1;nk1=1;LD_k=0;LD_SN=1;sn1=1;sn2=0;LD_nc=0;LD_wpm=0;
            wpm1=0;LD_wp=0;wp1=0;wp2=0;LD_w=0;LD_WK1=0;LD_mn=0;mn1=0;
            if(nc2==1) nstate = CHILD2;
            else if(nc2==0) nstate = ENTERLOOP;
            end
CHILD2:     begin
            LD_path=0;LD_pm=0;LD_adrs=1;a1=0;LD_SA=1;sa3=1;sa1=1;sa2=1;LD_ix=0;SI1=1;SI2=0;LD_SI=0;LD_nk=1;nk1=1;LD_k=0;LD_SN=1;sn1=1;sn2=2;LD_nc=0;LD_wpm=0;
            wpm1=0;LD_wp=0;wp1=0;wp2=0;LD_w=0;LD_WK1=0;LD_mn=0;mn1=0;
            if(nc3==1) nstate = CHILD3;
            else if(nc3==0) nstate = ENTERLOOP;
            end
CHILD3:     begin
            LD_path=0;LD_pm=0;LD_adrs=1;a1=0;LD_SA=1;sa3=1;sa1=1;sa2=2;LD_ix=0;SI1=1;SI2=0;LD_SI=0;LD_nk=1;nk1=1;LD_k=0;LD_SN=1;sn1=1;sn2=2;LD_nc=0;LD_wpm=0;
            wpm1=0;LD_wp=0;wp1=0;wp2=0;LD_w=0;LD_WK1=0;LD_mn=0;mn1=0;
            if(nc4==1) nstate = CHILD4;
            else if(nc4==0) nstate = ENTERLOOP;
            end
CHILD4:     begin
            LD_path=0;LD_pm=0;LD_adrs=1;a1=0;LD_SA=1;sa3=1;sa1=1;sa2=2;LD_ix=0;SI1=1;SI2=0;LD_SI=0;LD_nk=1;nk1=1;LD_k=0;LD_SN=1;sn1=1;sn2=3;LD_nc=0;LD_wpm=0;
            wpm1=0;LD_wp=0;wp1=0;wp2=0;LD_w=0;LD_WK1=0;LD_mn=0;mn1=0;
            nstate = ENTERLOOP;
            end
DONESTAGE:  begin
            LD_path=0;LD_pm=0;LD_adrs=0;a1=0;LD_SA=0;sa3=0;sa1=0;sa2=0;LD_ix=0;SI1=0;SI2=0;LD_SI=0;LD_nk=0;nk1=0;LD_k=0;LD_SN=0;sn1=0;sn2=0;LD_nc=0;LD_wpm=0;
            wpm1=0;LD_wp=0;wp1=0;wp2=0;LD_w=0;LD_WK1=0;LD_mn=1;mn1=1;done=1;
            if(stop==0) nstate = DONESTAGE;
            else if(stop==1) nstate = START;
            end
default: nstate=START;

endcase
end
endmodule
