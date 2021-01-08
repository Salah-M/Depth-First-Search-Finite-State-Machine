module Datapath #(parameter C = 4,D=8)(data,LD_path,LD_pm,LD_adrs,a1,LD_SA,sa3,sa1,sa2,LD_ix,SI1,SI2,LD_SI,LD_nk,nk1,LD_k,LD_SN,sn1,sn2,LD_nc,LD_wpm,wpm1,LD_wp,wp1,wp2,LD_w,LD_WK1,LD_mn,mn1,done,clk,stop,DONE,kone,SNumel,nc0,nc1,nc2,nc3,nc4,wl,wg,addres,wpathmin,pathm);
input LD_path,LD_pm,LD_adrs,a1,LD_SA,sa3,sa1,LD_ix,SI1,SI2,LD_SI,LD_nk,nk1,LD_k,LD_SN,sn1,LD_nc,LD_wpm,wpm1,LD_wp,wp1,wp2,LD_w,LD_WK1,LD_mn,mn1,done;
input [1:0] sn2;
input [3:0] sa2;
input clk;
input [17:0] data;
output stop,DONE,kone,SNumel,nc0,nc1,nc2,nc3,nc4,wl,wg;
output reg [17:0] addres;
reg [3:0] k;
reg [3:0] nextk; //max number they can hold is 8 which is the max depth
reg [2:0] STACK_IX[1:8];//max number of children is 4 so we need to represent 4 in a stack ix entry
reg [2:0] ix;
reg [2:0] STACK_NUMEL[1:8];//max number of children is 4 so we need to represent 4 in a stack ix entry
reg [17:0] STACK_ADRS [1:D][1:C]; //2D array for the stack which has C max children in x dim and D depth in y dim with bit size 18 bits per element
// we have 18 bits since max num of nodes is 21845 and since in the array T[] in memory each of these wee have a max of 7 entries so biggest pointer is
//21845 *7  which needs 18 bits to represent it.
reg [14:0] wpath[1:8];
//here we need 15 bits since assume a tree where all nodes have max weight
//then we need 4095(max weight per node) *8 which needs 15 bits to represent
reg [17:0] pathmin [1:8];//18 bits since it stores the pointers
reg [3:0] minnodes;
reg [14:0] weightk1;
reg [17:0] path [1:8];
reg [2:0] nc;// maximum value=4
output reg [14:0] wpathmin;//same as wpath logic
output reg [17:0] pathm;
reg [11:0] w;// weight needs 12 bits
reg [17:0] adrs;//stores values form STACK_ADRS
integer i;
integer j;
integer y;
integer o;
integer p;
wire stop=(minnodes<=0);
wire DONE=(nextk==0);
wire kone=(k==1);
wire SNumel=(STACK_NUMEL[k]<=0);
wire nc0=(nc==0);
wire nc1=(nc>=1);
wire nc2=(nc>=2);
wire nc3=(nc>=3);
wire nc4=(nc>=4);
wire wl=(wpath[k]<wpathmin);
wire wg=(wpath[k]>wpathmin);
always @ (posedge clk)begin
if(LD_adrs==1)begin
              if(a1==0) begin adrs<=adrs+1;addres=adrs;end
              else if(a1==1)begin adrs <= STACK_ADRS[k][ix];addres=adrs;end
              end
if(LD_path==1) path[k]<=adrs;
if(LD_pm==1) for(i=1;i<9;i=i+1)begin
                pathmin[i]<=path[i];
              end
if(LD_mn==1) begin
          if(mn1==0) minnodes<=k;
          else if (mn1==1)begin minnodes <= minnodes-1;
          pathm<=pathmin[8-minnodes];
          end
          end
if(LD_nk==1)begin
          if(nk1==0) nextk<=1;
          else if(nk1==1) nextk<=k+1;
          else if(nk1==2) nextk<=k-1;
          end
if(LD_k==1) k<=nextk;
if(LD_nc==1) nc<=data[2:0];
if(LD_ix==1) ix<=STACK_IX[k];
if(LD_wpm==1) begin
          if(wpm1==0) wpathmin<=15'b111111111111111;
          else if(wpm1==1) wpathmin<= wpath[k];
          end
if(LD_WK1==1) weightk1<=wpath[k-1]+w;
if(LD_wp==1) begin
          if(wp1==0)begin
                    if(wp2==0) wpath[k]<=w;
                    else if(wp2==1) wpath[k]<=weightk1;
                    end
          //else if(wp1==1)begin     this is possibly useless since we dont need to write to k-1
                    //if(wp2==0) wpath[k-1]<=w;
                    //else if(wp2==1) wpath[k-1]<=weightk1;
                    //end
		end
if(LD_w==1) w<=data[11:0];
if(LD_SI==1)begin
            if(SI1==0)begin
                      if(SI2==0) for(j=1;j<9;j=j+1)begin
                                        STACK_IX[j]<=1;
                                        end

                      else if(SI2==1) STACK_IX[k]<=STACK_IX[k]+1;
                      end
            else if(SI1==1)begin
                      if(SI2==0) STACK_IX[k+1]<=1;
                      //else if(SI2==1) STACK_ix[k+1]<= STACK_ix[k+1]+1;  also possible useless will never happen in normal operation
                      end
            end
if(LD_SN==1)begin
            if(sn2==0)begin
                      if(sn1==0) for(y=1;y<9;y=y+1)begin
                                        STACK_NUMEL[y]<=1;
                                      end
                      //else if(sn1==1) STACK_NUMEL[k+1]<=1; wont happen
                      end
            else if(sn2==1)begin
                      if(sn1==0) STACK_NUMEL[k]<=STACK_NUMEL[k]-1;
                      //else if(sn1==1) STACK_NUMEL[k+1]<=STACK_NUMEL[k+1]-1; will never happen
                      end
            else if(sn2==2)begin
                      if(sn1==1) STACK_NUMEL[k+1]<=nc;
                      //else if(sn1==0) STACK_NUMEL[k]<=nc;  never happens
                      end
            end
if(LD_SA==1)begin
            if(sa3==0)begin
             for(o=1;o<D+1;o=o+1)begin
                for(p=1;p<C+1;p=p+1)begin
                    STACK_ADRS[o][p]<=0;
                end
              end
            end
            else if(sa3==1)begin
                  if(sa1==1) begin
                      if(sa2==0) STACK_ADRS[k+1][1]<= data;
                      else if(sa2==1) STACK_ADRS[k+1][2]<=data;
                      else if(sa2==2) STACK_ADRS[k+1][3]<=data;
                      else if(sa2==3) STACK_ADRS[k+1][4]<=data;
                  end//other scenarios dont happen only these are needed
            end
            end

end
endmodule //Datapath
