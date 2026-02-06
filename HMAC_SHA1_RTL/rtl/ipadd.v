//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mohamed Emam Hossein
// 
// Create Date: 25.01.2026 18:44:51
// Design Name: 
// Module Name: input_padder
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
module ipadd (
    input rst_n     ,
    input clk       ,
    input [511:0] key   ,
    input start     ,
    output reg [31:0] out_to_sha
);

    integer i;
    localparam IDLE     = 1'b0;
    localparam START    = 1'b1;

    reg [31:0] padd_block [15:0];
    reg [3:0] output_index;

    reg cs,ns;
    reg count_en;
    always @(*) begin
        for (i = 0; i < 16; i = i+1) begin
            padd_block[i] <= {4{8'h36}} ^ key[(i << 5) +: 32];
        end 
    end

    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            cs <= IDLE;
            out_to_sha <= 'b0;
        end
        else begin
            cs   <= ns;
            out_to_sha <= padd_block[output_index];
        end
    end

    always @(*) begin
        ns = cs;
        case (cs)
            IDLE:begin
                ns = (start)? START : IDLE;
                count_en = 1'b0;
            end 
            START: begin
                count_en = 1'b1;
                ns = (output_index == 15)? IDLE : START;
            end
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            output_index <= 'b0;
        end
        else if(count_en)begin
            output_index <= output_index + 4'b1;
        end
        else begin
            output_index <= 'b0;
        end
    end

endmodule