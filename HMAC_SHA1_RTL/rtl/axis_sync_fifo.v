//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mohamed Emam Hossein
// 
// Create Date: 25.01.2026 18:44:51
// Design Name: 
// Module Name: axis_sync_fifo
// Project Name: AI accelerator with secured fifo chain
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module axis_sync_fifo #(
    parameter WIDTH = 32,
    parameter DIPTH = 1024
) (
    input   i_clk   ,
    input   i_rst_n ,

    // read channel
    input                   tvalid_s    ,
    input wire [WIDTH-1:0]  tdata_s     ,
    input                   tready_s    , // ready chosen to be input to capture data only when sha is ready

    // write channel
    input                   tready_m    ,
    output wire [WIDTH-1:0] tdata_m     ,
    output wire             tvalid_m    ,
    output                  tlast_m                 
);

    integer i;

    reg [WIDTH-1:0] fifo_mem [DIPTH-1:0];

    reg [$clog2(DIPTH)-1:0] wr_ptr, rd_ptr;

    // assume fifo is never be full -> dipth >= max packer length
    always @(posedge i_clk) begin : write_pointer_proc
        if(~i_rst_n)begin
            wr_ptr      <= 'b0;
            for (i = 0; i < DIPTH ; i = i+1) begin
                fifo_mem[i] <= 'b0;
            end
        end
        else if(tvalid_s && tready_s)begin
            fifo_mem[wr_ptr] <= tdata_s;
            wr_ptr <= wr_ptr + 1'b1;
        end
    end

    always @(posedge i_clk) begin : read_pointer_proc
        if(~i_rst_n)begin
            rd_ptr      <= 'b0;
        end
        else if(tvalid_m && tready_m)begin
            rd_ptr <= rd_ptr + 1'b1;
        end
    end
    


    // master interface
    assign tdata_m = fifo_mem[rd_ptr];
    assign tvalid_m = (wr_ptr != rd_ptr);
    assign tlast_m = tvalid_m && (wr_ptr == rd_ptr + 1'b1);

    
endmodule