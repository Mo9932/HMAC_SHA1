module SHA1_opt_stage2 (
    input clk   ,
    input rst_n ,
    input [1023:0] data_in,
    input restart   , // signal to start processing a new message block : must remain high for 16 cycles
    output wire valid,
    output reg sha_ready,
    output [159:0] hash_out
);

    integer i, j;
    
    // SHA-1 constants
    localparam H0 = 32'h67452301;
    localparam H1 = 32'hefcdab89;
    localparam H2 = 32'h98badcfe;
    localparam H3 = 32'h10325476;
    localparam H4 = 32'hc3d2e1f0;

    // SHA-1 round constants
    localparam K0 = 32'h5A827999;
    localparam K1 = 32'h6ED9EBA1;
    localparam K2 = 32'h8F1BBCDC;
    localparam K3 = 32'hcA62C1D6;

    // Output hash value
    reg valid_r;

    // Internal signals
    reg [31:0] hash_state[0:4];

    reg [6:0] word_to_be_generated;

    reg [31:0] H [0:4];
    reg [31:0] a, b, c, d, e;
    reg [31:0] w [0:79];
    reg block_id;
    reg [31:0] w_block1 [0:15];
    reg [31:0] w_block2 [0:15];
    reg [31:0] f0, f1, f2, f3;

    reg [31:0] temp;
    reg start_gen;

    wire [31:0] H0_next;
    wire [31:0] H1_next;
    wire [31:0] H2_next;
    wire [31:0] H3_next;
    wire [31:0] H4_next;
    
    localparam [1:0]  IDLE    = 2'b00,
                LOAD    = 2'b01,
                PROCESS = 2'b10,
                DONE    = 2'b11;


    reg [1:0] current_state, next_state;



    /* load word w0 to w15 */

    // Generate words w16 to w79
    wire [31:0]next_worgen0;

    assign next_worgen0 = (w[word_to_be_generated-3] ^ w[word_to_be_generated-8] ^ w[word_to_be_generated-14] ^ w[word_to_be_generated-16]);
    
    always @(posedge clk) begin 
        if (!rst_n) begin
            for ( j= 16; j < 79; j = j + 1) begin
                w[j] <= 32'h0;
            end
            word_to_be_generated <= 7'd16;
        end
        else if (!start_gen) begin
            word_to_be_generated <= 7'd16;
            if(!block_id) begin
                for ( j= 0; j < 16; j = j + 1) begin
                    w[j] <= w_block1[j];
                end
            end
            else begin
                for ( j= 0; j < 16; j = j + 1) begin
                    w[j] <= w_block2[j];
                end
            end

        end
        else if (start_gen && word_to_be_generated < 7'd80) begin
            w[word_to_be_generated]   <= {next_worgen0[30:0], next_worgen0[31]};
            word_to_be_generated <= (word_to_be_generated == 7'd79)? 7'd16 :word_to_be_generated + 1'd1;
        end
    end


    // f0, f1, f2, f3 functions
    always @(*) begin
        f0 = (b & c) | (~b & d);
        f1 = b ^ c ^ d;
        f2 = (b & c) | (b & d) | (c & d);
        f3 = b ^ c ^ d;
    end

    // State machine states

    reg [6:0] round;

    always @(posedge clk) begin
        if (!rst_n) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        next_state = current_state;
        start_gen  = 'b0;
        temp       = 'b0;
        case (current_state)
            IDLE    :begin 
                if (restart)
                    next_state = LOAD;
            end 
            LOAD    :begin 
                next_state = PROCESS;
            end 

            PROCESS :begin 

                if(round > 14)begin
                    start_gen   = 'b1;
                end
                else begin
                    start_gen   = 'b0;
                end

                if (round == 7'd79) begin
                    next_state =(block_id)? DONE : LOAD;
                end else begin
                    next_state = PROCESS;
                end 
                // temp calculation
                if(round < 7'd20) begin
                    // Processing for rounds 0-19
                    temp = {a[26:0],a[31:27]} + f0 + e + w[round]  + K0;
                end else if (round < 7'd40) begin
                    // Processing for rounds 20-39
                    temp = {a[26:0],a[31:27]} + f1 + e + w[round] + K1;
                end else if (round < 7'd60) begin
                    // Processing for rounds 40-59
                    temp = {a[26:0],a[31:27]} + f2 + e + w[round] + K2;
                end else begin
                    // Processing for rounds 60-79
                    temp = {a[26:0],a[31:27]} + f3 + e + w[round] + K3;
                end
            end
            DONE    :begin 
                next_state = (block_id) ? IDLE : LOAD;
            end 
        endcase
    end

    // Main SHA-1 processing

    assign H0_next = H[0] + a;
    assign H1_next = H[1] + b;
    assign H2_next = H[2] + c;
    assign H3_next = H[3] + d;
    assign H4_next = H[4] + e;

    always @(posedge clk) begin
        if (!rst_n) begin
            block_id    <= 'b0;
            round       <= 7'd0;
            valid_r     <= 'b0;
            sha_ready   <= 1'b1;
            for (i = 0; i < 16; i = i + 1) begin
                w_block1[i] <= 32'h0;
                w_block2[i] <= 32'h0;
            end
            H[0] <= H0;
            H[1] <= H1; 
            H[2] <= H2;
            H[3] <= H3;
            H[4] <= H4;
            hash_state[0] <= 'b0;
            hash_state[1] <= 'b0;
            hash_state[2] <= 'b0;
            hash_state[3] <= 'b0;
            hash_state[4] <= 'b0;


            {a, b, c, d, e} <= {H0, H1, H2, H3, H4};
        end else begin
            case (current_state)
                IDLE: begin
                    sha_ready <= 1'b1;
                    valid_r     <= 'b0;
                    round <= 7'd0;
                    if(restart) begin
                        for (i = 0; i < 16; i = i + 1) begin
                            w_block1[i] <= data_in[((i+1)<<5) -1 -: 32 ];
                            w_block2[i] <= data_in[((i+1)<<5) +511 -: 32 ];
                        end
                        H[0] <= H0;
                        H[1] <= H1; 
                        H[2] <= H2;
                        H[3] <= H3;
                        H[4] <= H4;
                        {a, b, c, d, e} <= {H0, H1, H2, H3, H4};
                        
                    end
                end
                LOAD: begin
                    round <= 7'd0;
                    sha_ready <= 1'b0;
                    if(block_id)begin
                        H[0] <= H0_next;
                        H[1] <= H1_next;
                        H[2] <= H2_next;
                        H[3] <= H3_next;
                        H[4] <= H4_next;
                        a <= H0_next;
                        b <= H1_next;
                        c <= H2_next;
                        d <= H3_next;
                        e <= H4_next;
                    end
                end
                PROCESS: begin
                    // SHA-1 main loop processing here
                    // Update a, b, c, d, e based on w[round] and f functions
                    round <= (next_state == PROCESS) ? round + 7'd1 : 7'b0;
                    // Update working variables
                    e <= d;
                    d <= c;
                    // write c = b rotated right by 2 == rotate left by 30
                    c <= {b[1:0], b[31:2]};
                    b <= a;
                    a <= temp;
                    
                    block_id <= (next_state == LOAD) ? block_id + 1'b1 : block_id;

                end
                DONE: begin
                    // Update hash state
                    H[0] <= H0_next;
                    H[1] <= H1_next;
                    H[2] <= H2_next;
                    H[3] <= H3_next;
                    H[4] <= H4_next;
                    hash_state[0]   <= H4_next;
                    hash_state[1]   <= H3_next;
                    hash_state[2]   <= H2_next;
                    hash_state[3]   <= H1_next;
                    hash_state[4]   <= H0_next;
                    valid_r         <= 'b1;
                end
            endcase
        end
    end

   
    
    // Output hash value

    assign hash_out = {hash_state[4],hash_state[3],hash_state[2],hash_state[1],hash_state[0]}; // Output the first 32 bits of the hash
    assign valid = valid_r;
endmodule