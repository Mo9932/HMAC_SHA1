//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mohamed Emam Hossein
// 
// Create Date: 25.01.2026 18:44:51
// Design Name: 
// Module Name: output_padder
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

module opadd (
    input rst_n     ,
    input clk       ,
    input t_valid   ,
    input t_ready   ,

    input [159:0] sha_in,
    input [511:0] key   ,
    input start     ,
    output reg [511:0] out_to_sha,
    output reg sah_start,
    output reg sah_restart
);

    integer i, j;
    localparam IDLE     = 1'b0;
    localparam START    = 1'b1;

    reg [31:0] padd_block_key   [15:0];
    reg [31:0] padd_block       [15:0];
    reg [4:0] output_index;

    reg out_select;
    reg op_flag   ;

    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            for (i = 0; i < 16; i = i+1) begin
                padd_block[i] <= 'b0;  
            end 
            for (i = 0; i < 16; i = i+1) begin
                padd_block_key[i] <= 'b0;  
            end 
            sah_start   <= 'b0;
            sah_restart <= 'b0;
            out_select  <= 'b0;
            op_flag     <= 'b0;
        end
        else if(t_valid && t_ready && ~op_flag)begin
            out_select  <= 'b0;
            sah_restart <= 'b1;
            op_flag     <= 'b1;
            for (i = 0; i < 16; i = i+1) begin
                padd_block_key[i] <= {4{8'h5c}} ^ key[((i+1) << 5)-1 -: 32];
            end 
        end
        else if(start)begin
            out_select  <= 'b1;
            op_flag     <= 'b0;
            padd_block[0] <= sha_in[31 :0  ]; 
            padd_block[1] <= sha_in[63 :32 ]; 
            padd_block[2] <= sha_in[95 :64 ]; 
            padd_block[3] <= sha_in[127:96 ]; 
            padd_block[4] <= sha_in[159:128]; 
            padd_block[5] <= 32'h80000000;
            for (i = 6; i < 15; i = i+1) begin
                padd_block[i] <= 'b0;
            end 
            padd_block[15]      <= 32'd672; // fixed length for outer padding
            sah_start  <= 1'b1;
        end
        else begin
            sah_restart <= 'b0;
            sah_start   <= 'b0;
        end
    end
    
    always @(*) begin
        for (j = 0 ; j < 16; j = j+1) begin
            out_to_sha[((j+1) << 5)-1 -: 32] = (out_select)? padd_block[j] : padd_block_key[j];
        end
    end
endmodule