module opadd (
    input rst_n     ,
    input clk       ,
    input [159:0] sha_in,
    input [511:0] key   ,
    input start     ,
    output reg [1023:0] out_to_sha,
    output reg sah_start
);

    integer i, j;
    localparam IDLE     = 1'b0;
    localparam START    = 1'b1;

    reg [31:0] padd_block [31:0];
    reg [4:0] output_index;
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            for (i = 0; i < 32; i = i+1) begin
                padd_block[i] <= 'b0;  
            end 
            sah_start   <= 'b0;
        end
        else if(start)begin
            for (i = 0; i < 16; i = i+1) begin
                padd_block[i] <= {4{8'h5c}} ^ key[((i+1) << 5)-1 -: 32];
            end 
            padd_block[16] <= sha_in[31 :0  ]; 
            padd_block[17] <= sha_in[63 :32 ]; 
            padd_block[18] <= sha_in[95 :64 ]; 
            padd_block[19] <= sha_in[127:96 ]; 
            padd_block[20] <= sha_in[159:128]; 
            padd_block[21] <= 32'h80000000;
            for (i = 22; i < 31; i = i+1) begin
                padd_block[i] <= 'b0;
            end 
            
            padd_block[31]      <= 32'd672;

            sah_start  <= 1'b1;
        end
        else begin
            sah_start   <= 'b0;
        end
    end
    
    always @(*) begin
        for (j = 0 ; j < 32; j = j+1) begin
            out_to_sha[((j+1) << 5)-1 -: 32] = padd_block[j];
        end
    end
endmodule