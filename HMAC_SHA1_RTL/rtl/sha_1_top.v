module sha_1_top (
    input clk,
    input rst_n,
    input [31:0] t_data,
    input t_valid,
    input t_last,
    output t_ready,
    output sha_done,
    output [159:0] hash_out
);

    wire sha_ready;
    wire [31:0] padded_data_out;

    wire start;
    wire restart;
    wire sha_valid;
    wire sha_done_tmp;

    // Padding module instance
    padding_add u_padding_add (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(t_data),
        .t_valid(t_valid),
        .t_last(t_last),
        .sha_valid(sha_valid),
        .sha_ready(sha_ready),
        .restart(restart),
        .start(start),
        .padded_data_out(padded_data_out),
        .t_ready(t_ready),
        .sha_done(sha_done_tmp)
    );

    // SHA-1 core instance
    SHA1_core u_sha1_core (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(padded_data_out),
        .start(start),
        .restart(restart),
        .valid(sha_valid),
        .sha_ready(sha_ready),
        .hash_out(hash_out)
    );

    assign sha_done = sha_done_tmp && !t_valid && sha_valid;

endmodule