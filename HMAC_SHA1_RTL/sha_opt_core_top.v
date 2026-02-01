module sha_opt_core_top(
    input clk,
    input rst_n,
    input [159:0] sha_in,
    input [511:0] key   ,
    input start         ,
    output wire [31:0] out_to_sha,
    output wire sah_start,
    output wire valid   ,
    output wire sha_ready,
    output [159:0] hash_out
);


opadd U_padd(
    .rst_n     (rst_n     ),
    .clk       (clk       ),
    .sha_in    (sha_in    ),
    .key       (key       ),
    .start     (start     ),
    .out_to_sha(out_to_sha),
    .sah_start (sah_start )
);

SHA1_opt_stage2 U_SHA(
    .clk        (clk        ),
    .rst_n      (rst_n      ),
    .data_in    (out_to_sha ),
    .restart    (sah_start  ), // signal to start processing a new message block : must remain high for 16 cycles
    .valid      (valid      ),
    .sha_ready  (sha_ready  ),
    .hash_out   (hash_out   )
);



endmodule