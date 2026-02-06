module SHA1_core (
    input clk   ,
    input rst_n ,
    input [31:0] data_in,
    input start     , // signal to start processing a new message block : must remain high for 16 cycles
    input restart   , // signal to start processing a new message block : must remain high for 16 cycles
    output wire valid,
    output reg sha_ready,
    output [159:0] hash_out
);

    integer i;
    
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


    reg valid_r;
    // Internal signals
    reg [31:0] hash_state[0:4];
    reg [4:0] word_index;
    reg [6:0] word_to_be_generated;

    reg [31:0] H [0:4];
    reg [31:0] a, b, c, d, e;
    reg [31:0] w     [0:79];
    // reg [31:0] w_gen [0:63];
    reg [31:0] f0, f1, f2, f3;

    reg [31:0] temp;
    reg done_reg;
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

    // Generate words w16 to w79
    wire [31:0]next_worgen0;


    /* load word w0 to w15 */
    always @(posedge clk) begin
        if (!rst_n) begin
            word_index              <= 'd0;
            word_to_be_generated    <= 'd16;
            start_gen <= 1'b0;
            done_reg  <= 'b0;
            for (i = 0; i < 80; i = i + 1) begin
                w[i] <= 32'h0;
            end
        end
        else if (done_reg) begin
            word_index <= 'd0;
            start_gen <= 1'b0;
            done_reg  <= 'b0;
            word_to_be_generated    <= 'd16;
        end
        else if ((next_state != IDLE && next_state != DONE) && (word_index < 16)) begin // Load data into w array
            // start and restart signal indicates new message block and must remain high for 16 cycles
            w[word_index] <= data_in;
            word_index <= word_index + 1'b1;
            start_gen <= (word_index == 15) ? 1'b1 : 1'b0;
        end 
        else if(start_gen && word_to_be_generated < 80)begin
            w[word_to_be_generated]   <= {next_worgen0[30:0], next_worgen0[31]};
            word_to_be_generated <= word_to_be_generated + 1'd1;
            done_reg <= (word_to_be_generated > 78) ? 1'b1 : 1'b0; // Indicate done when w79 is generated
        end
    end


    assign next_worgen0 = (w[word_to_be_generated - 3] ^ w[word_to_be_generated - 8] ^ w[word_to_be_generated - 14] ^ w[word_to_be_generated - 16]);


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
		  temp = 'b0;
        case (current_state)
            IDLE    :begin 
                if (start || restart)
                    next_state = LOAD;
            end 
            LOAD    :begin 
                next_state = PROCESS;
            end 

            PROCESS :begin 
                if (round == 7'd79) begin
                    next_state = DONE;
                end else begin
                    next_state = PROCESS;
                end 

                // temp calculation
                if(round < 7'd20) begin
                    // Processing for rounds 0-19
                    temp = {a[26:0],a[31:27]} + f0 + e + w[round]+ K0;
                end else if (round < 7'd40) begin
                    // Processing for rounds 20-39
                    temp = {a[26:0],a[31:27]} + f1 + e + w[round]+ K1;
                end else if (round < 7'd60) begin
                    // Processing for rounds 40-59
                    temp = {a[26:0],a[31:27]} + f2 + e + w[round]+ K2;
                end else begin
                    // Processing for rounds 60-79
                    temp = {a[26:0],a[31:27]} + f3 + e + w[round]+ K3;
                end
            end
            DONE    :begin 

                next_state = IDLE;
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
            valid_r <= 1'b0;
            round <= 7'd0;
            sha_ready <= 1'b1;
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
                    valid_r <= 1'b0;
                    sha_ready <= 1'b1;
                    round <= 7'd0;
                    if(restart) begin
                        H[0] <= H0;
                        H[1] <= H1; 
                        H[2] <= H2;
                        H[3] <= H3;
                        H[4] <= H4;

                        {a, b, c, d, e} <= {H0, H1, H2, H3, H4};
                    end
                    else if (start) begin
                        {a, b, c, d, e} <= {H[0], H[1], H[2], H[3], H[4]};
                    end
                    
                end
                LOAD: begin
                    round <= 7'd0;
                    sha_ready <= 1'b0;
                end
                PROCESS: begin
                    // SHA-1 main loop processing here
                    // Update a, b, c, d, e based on w[round] and f functions
                    round <= round + 1'b1;

                    // Update working variables
                    e <= d;
                    d <= c;
                    // write c = b rotated right by 2 == rotate left by 30
                    c <= {b[1:0], b[31:2]};
                    b <= a;
                    a <= temp;

                end
                DONE: begin
                    // Update hash state
                    H[0] <= H0_next;
                    H[1] <= H1_next;
                    H[2] <= H2_next;
                    H[3] <= H3_next;
                    H[4] <= H4_next;
                    hash_state[0] <= H4_next;
                    hash_state[1] <= H3_next;
                    hash_state[2] <= H2_next;
                    hash_state[3] <= H1_next;
                    hash_state[4] <= H0_next;
                    valid_r <= 1'b1;
                end
            endcase
        end
    end

    // Output hash value

    assign hash_out = {hash_state[0],hash_state[1],hash_state[2],hash_state[3],hash_state[4]}; // Output the first 32 bits of the hash
    assign valid = valid_r;
endmodule