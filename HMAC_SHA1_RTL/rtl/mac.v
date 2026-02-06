//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mohamed Emam Hossein
// 
// Create Date: 25.01.2026 18:44:51
// Design Name: 
// Module Name: mac
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

module mac #(
    parameter WIDTH = 32
) (
    input               clk         ,
    input               rst_n       ,
    input               start       , // only take data when authentication is done

    input               tlast_s     ,
    input   [WIDTH-1:0] tdata_s     ,
    input   [WIDTH-1:0] weight_s    ,
    output reg          tready_s    ,

    output reg [2*WIDTH-1:0] result ,
    output reg          done
);

    reg [2*WIDTH-1:0] acc;
    reg op_start;

    wire [2*WIDTH-1:0] mult_result;
    assign mult_result = tdata_s * weight_s;


    always @(posedge clk) begin: MAC_Process
        if (!rst_n)  begin // Active low synchronous reset
            acc         <= 'b0; 
            done        <= 'b0;
            result      <= 'b0;
            op_start    <= 'b0;
            tready_s    <= 'b0;
        end 
        else if (start && ~op_start) begin
            acc         <= 'b0;
            done        <= 'b0;
            op_start    <= 'b1;
            tready_s    <= 'b1; // ready when start signal is asserted
        end 
        else if (op_start) begin
            if(tlast_s) begin
                done        <= 'b1;
                result      <= acc + mult_result;
                op_start    <= 'b0;
                tready_s    <= 'b0;
                acc         <= 'b0;
            end
            else
                acc <= acc + mult_result;
        end 
        else begin
            done    <= 'b0;
        end
    end
endmodule