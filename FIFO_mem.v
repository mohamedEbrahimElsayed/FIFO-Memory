module FIFO_mem(wdata,waddr,wclk,raddr,full,empty,overflow,underflow,threshold,rst,wen,rdata);
parameter DATA_WIDTH = 8;
parameter DATA_DEPTH =16;
parameter ASIZE = 4;
input [DATA_WIDTH-1:0] wdata;
input wclk,wen,rst;
input [ASIZE-1:0] raddr,waddr;
output full,empty,overflow,underflow,threshold;
output reg [DATA_WIDTH-1:0] rdata;
reg [ASIZE:0] wr_ptr,rd_ptr;
reg [DATA_WIDTH-1:0] fifo [DATA_DEPTH-1:0];

assign full = (rd_ptr[ASIZE-1:0] == wr_ptr[ASIZE-1:0])&&(rd_ptr[ASIZE] != wr_ptr[ASIZE])? 1'b1:1'b0 ;
assign empty = (rd_ptr == wr_ptr)? 1'b1:1'b0;
assign overflow = (full == 1 && wr_ptr[ASIZE-1:0] > rd_ptr[ASIZE-1:0])? 1'b1:1'b0;
assign underflow = (empty == 1 && rd_ptr > wr_ptr)? 1'b1:1'b0;

always @(posedge wclk) begin
	if (rst) begin
		rdata <= 'b0;
		wr_ptr <= 1'b0;
		rd_ptr <= 1'b0;
	end
	else begin
		if (~full && wen) begin
			fifo[waddr] <= wdata;
			wr_ptr <= wr_ptr + 1;
		end
		if (~empty)begin
			rdata <= fifo[raddr];
			rd_ptr <= rd_ptr + 1;
		end
	end
end
endmodule