


// `define message0_len  (17*4)*8 // 4* 17 chars = 17 words = 86 bytes = 544 bits
// `define message1_len  (16*3)*8 // 3* 16 chars = 12 words = 48 bytes = 384 bits
// `define message2_len  (16*5)*8 // 5* 16 chars = 20 words = 80 bytes = 640 bits
// `define message3_len  (16*8)*8 // 8* 16 chars = 32 words = 128 bytes= 1024 bits
// `define message4_len  (60*8)   // 60    chars = 15 words = 60 bytes = 480 bits
// `timescale 1ns/1ns
// module sha1_core_tb;

//     localparam message0 = "0123456789abcdeff0123456789abcdeff0123456789abcdeff0123456789abcdeff";
//     localparam expected_hash0 = 160'h24eec7aa22c1928d0a11c28ff57f28b1c5f4fdae; // SHA-1 hash of message0
    
//     localparam message1 = "0123456789abcdef0123456789abcdef0123456789abcdef";
//     localparam expected_hash1 = 160'h480f0a5bfe9d1ec3f8936b9441f6e89d301711f5; // SHA-1 hash of message1
    
//     localparam message2 = "0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef";
//     localparam expected_hash2 = 160'hbf77b0a0017bc455d1d6e93c7b807f3805a8eb9d; // SHA-1 hash of message2
    
//     localparam message3 = "0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef";
//     localparam expected_hash3 = 160'h7539151d4f12a92e310f26c847cd81279b451729; // SHA-1 hash of message3

//     localparam message4 = "012345678901234567890123456789012345678901234567890123456789";
//     localparam expected_hash4 = 160'hf52e3c2732de7bea28f216d877d78dae1aa1ac6a; // SHA-1 hash of message3


//     reg clk;
//     reg rst_n;
//     reg [31:0] data_in;
//     reg t_valid;
//     reg t_last;
//     reg read_req;

//     wire t_ready;

//     wire [31:0] hash_out;
//     wire sha_done;

//     reg [`message3_len + 32:0] input_vec ; // maximum message length + padding

//     integer i;

//     sha_1_top DUT (
//         .clk(clk),
//         .rst_n(rst_n),
//         .t_data(data_in),
//         .t_valid(t_valid),
//         .t_last(t_last),
//         .sha_done(sha_done),
//         .t_ready(t_ready),
//         .hash_out(hash_out),
//         .read_req(read_req)
//     );

//     // Clock generation
//     initial begin
//         clk = 0;
//         forever #5 clk = ~clk; // 10ns clock period
//     end

//     // Test sequence
//     initial begin
//         // Initialize signals
//         rst_n       = 0;
//         data_in     = 32'b0;
//         t_valid     = 0;
//         t_last      = 0;
//         read_req    = 0;

//         // Apply reset
//         #15;
//         rst_n = 1;

//         // Send input data in 32-bit chunks
//         // test message0
//         input_vec = 'b0;
//         input_vec[`message0_len-1: 0] = message0; // Input message

//         for (i = 0; i < 65 ; i = i+1) begin
//             input_vec[i] = "a";
//         end
//         #10;
//         for (i = 0; i < `message0_len/32; i = i + 1) begin
//             @(posedge clk);
//             data_in = input_vec[`message0_len-1- i*32 -: 32];
//             t_valid = 1;
//             t_last = (i == (`message0_len/32 - 1)) ? 1 : 0; // Assert t_last on the last word
//             #10
//             wait(t_ready); // Wait until DUT is ready to accept data
//         end
//         // Deassert valid after last word
//         @(posedge clk);
//         t_valid = 0;
//         t_last = 0;
//         #1;

//         wait(sha_done);
//         $display("**************************************************************************\n");
//         $display("Expected Hash0: %h", expected_hash0);
//         $display("Computed Hash0: %h", {DUT.u_sha1_core.H[0], DUT.u_sha1_core.H[1], DUT.u_sha1_core.H[2], DUT.u_sha1_core.H[3], DUT.u_sha1_core.H[4]});
//         $display("\n**************************************************************************");


//         // test message1
//         input_vec = 'b0;
//         input_vec[`message1_len-1: 0] = message1; // Input message

//         #100;
//         for (i = 0; i < `message1_len/32; i = i + 1) begin
//             @(posedge clk);
//             data_in = input_vec[`message1_len-1- i*32 -: 32];
//             t_valid = 1;
//             t_last = (i == (`message1_len/32 - 1)) ? 1 : 0; // Assert t_last on the last word
//             #10
//             wait(t_ready); // Wait until DUT is ready to accept data
//         end
//         // Deassert valid after last word
//         @(posedge clk);
//         t_valid = 0;
//         t_last = 0;
//         #1;

//         wait(sha_done);
//         $display("**************************************************************************\n");
//         $display("Expected Hash1: %h", expected_hash1);
//         $display("Computed Hash1: %h", {DUT.u_sha1_core.H[0], DUT.u_sha1_core.H[1], DUT.u_sha1_core.H[2], DUT.u_sha1_core.H[3], DUT.u_sha1_core.H[4]});
//         $display("\n**************************************************************************");

//         // test message2
//         input_vec = 'b0;
//         input_vec[`message2_len-1: 0] = message2; // Input message

//         #100;
//         for (i = 0; i < `message2_len/32; i = i + 1) begin
//             @(posedge clk);
//             data_in = input_vec[`message2_len-1- i*32 -: 32];
//             t_valid = 1;
//             t_last = (i == (`message2_len/32 - 1)) ? 1 : 0; // Assert t_last on the last word
//             #10
//             wait(t_ready); // Wait until DUT is ready to accept data
//         end
//         // Deassert valid after last word
//         @(posedge clk);
//         t_valid = 0;
//         t_last = 0;
//         #1;

//         wait(sha_done);
//         $display("**************************************************************************\n");
//         $display("Expected Hash2: %h", expected_hash2);
//         $display("Computed Hash2: %h", {DUT.u_sha1_core.H[0], DUT.u_sha1_core.H[1], DUT.u_sha1_core.H[2], DUT.u_sha1_core.H[3], DUT.u_sha1_core.H[4]});
//         $display("\n**************************************************************************");
//         // test message3
//         input_vec = 'b0;
//         input_vec[`message3_len-1: 0] = message3; // Input message

//         #100;
//         for (i = 0; i < `message3_len/32; i = i + 1) begin
//             @(posedge clk);
//             data_in = input_vec[`message3_len-1- i*32 -: 32];
//             t_valid = 1;
//             t_last = (i == (`message3_len/32 - 1)) ? 1 : 0; // Assert t_last on the last word
//             #10
//             wait(t_ready); // Wait until DUT is ready to accept data
//         end
//         // Deassert valid after last word
//         @(posedge clk);
//         t_valid = 0;
//         t_last = 0;
//         #1;

//         wait(sha_done);
//         $display("**************************************************************************\n");
//         $display("Expected Hash3: %h", expected_hash3);
//         $display("Computed Hash3: %h", {DUT.u_sha1_core.H[0], DUT.u_sha1_core.H[1], DUT.u_sha1_core.H[2], DUT.u_sha1_core.H[3], DUT.u_sha1_core.H[4]});
//         $display("\n**************************************************************************");
//         // Wait for some time to observe output
//         #100;
//         // test message4

//         input_vec = 'b0;
//         input_vec[`message4_len-1: 0] = message4; // Input message

//         #100;
//         for (i = 0; i < `message4_len/32; i = i + 1) begin
//             @(posedge clk);
//             data_in = input_vec[`message4_len-1- i*32 -: 32];
//             t_valid = 1;
//             t_last = (i == (`message4_len/32 - 1)) ? 1 : 0; // Assert t_last on the last word
//             #10
//             wait(t_ready); // Wait until DUT is ready to accept data
//         end
//         // Deassert valid after last word
//         @(posedge clk);
//         t_valid = 0;
//         t_last = 0;
//         #1;

//         wait(sha_done);
//         $display("**************************************************************************\n");
//         $display("Expected Hash4: %h", expected_hash4);
//         $display("Computed Hash4: %h", {DUT.u_sha1_core.H[0], DUT.u_sha1_core.H[1], DUT.u_sha1_core.H[2], DUT.u_sha1_core.H[3], DUT.u_sha1_core.H[4]});
//         $display("\n**************************************************************************");
//         // Wait for some time to observe output
//         read_req = 1;
//         wait(!sha_done);
//         #100;

//         // Finish simulation
//         $stop;
//     end

// endmodule