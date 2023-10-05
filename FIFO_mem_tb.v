module FIFO_mem_tb();
reg [7:0] wdata;
reg wclk,wen,rst;
reg [3:0] raddr,waddr;
wire full,empty,overflow,underflow,threshold;
wire [7:0] rdata;

FIFO_mem DUT(wdata,waddr,wclk,raddr,full,empty,overflow,underflow,threshold,rst,wen,rdata);

integer i= 0;
initial begin
	wclk=0;
	forever
	#1 wclk=~wclk;
end
initial begin
rst=1;
wdata=0;
wen=0;
raddr=0;
waddr=0;
#50;
rst=0;
#50;
wen=1;
for(i=0;i<1000;i=i+1)begin
#2
wdata=$random;
waddr=$random;
raddr=$random;
end
wen=0;
for(i=0;i<1000;i=i+1)begin
#2
wdata=$random;
waddr=$random;
raddr=$random;
end
for(i=0;i<1000;i=i+1)begin
#2
wen=$random;
wdata=$random;
waddr=$random;
raddr=$random;
end
#1 $stop;
end
endmodule


