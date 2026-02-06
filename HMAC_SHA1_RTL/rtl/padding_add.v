module padding_add (
    input clk           ,
    input rst_n         ,
    input [31:0] data_in,
    input t_valid       , // input data valid signal
    input t_last        , // input data last signal
    input sha_valid     ,
    input sha_ready     ,
    output reg start    , // signal to start processing a new message block: must remain high for 16 cycles
    output reg restart  , // signal to start processing a new message block: must remain high for 16 cycles
    output reg t_ready  , // signal indicating readiness to accept input data
    output reg [31:0] padded_data_out,
    output reg sha_done
);

    // Algorithm implementation
    // If the size of the input message is less than 448 bits (56 bytes),
    // we append a single '1' bit followed by '0' bits until the length
    // reaches 448 bits, and then append the original message length as a 64-bit big-endian integer.
    // If the size of the input message is 448 bits or more, we pad the message
    // to the next multiple of 512 bits.
    // and send the message in 512-bit blocks to the SHA-1 core.

    // Internal signals
    reg [3:0] word_count; // counts the number of words received
    wire [3:0] next_word_count;
    reg [31:0] data_len_words; // length of the original message in words (32 bits)
    reg counter_start;

    assign next_word_count = word_count + 4'd1;
    // counter to track words received
    always @(posedge clk) begin
        if (!rst_n) begin
            word_count <= 4'd0;
        end
        else if (counter_start) begin
                word_count <= next_word_count; // increment by 1 word (32 bits)
        end
        else if(!counter_start) begin
            word_count <= 4'd0;
        end
    end
    
    // State machine states
    // Gray code for states
    localparam  IDLE        = 4'd0,
                TRANS_DATA  = 4'd1,
                PAD_1_DIR   = 4'd3,
                WAIT_0_PAD  = 4'd2, 
                PAD_1       = 4'd4,
                PAD_0       = 4'd5, 
                PAD_LEN     = 4'd7,
                WAIT        = 4'd6,
                WAIT_SHA    = 4'd12;
    reg [3:0] current_state, next_state;

    // State machine sequential logic
    always @(posedge clk) begin
        if (!rst_n) begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end

    // State machine combinational logic

    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE: begin
                if(t_valid && t_ready) begin
                    next_state = TRANS_DATA;
                end
            end
            TRANS_DATA: begin
                if( next_word_count < 4'd13 && t_last) begin // last word received and less than 13 words
                    next_state = PAD_1;
                end
                else if(next_word_count > 4'd12 && next_word_count < 4'd15 && t_last) begin // last word received and between 13 and 15 words
                    next_state = PAD_1_DIR;
                end
                else if(next_word_count == 4'd15) begin // last word received and exactly 15 words
                    next_state = WAIT;
                end
            end
            PAD_1_DIR: begin
                if(next_word_count < 4'd15) begin
                    next_state = PAD_0; // padding with zeros directly
                end
                else begin
                    next_state = WAIT_0_PAD;      // wait for sha core to be ready
                end
            end
            WAIT_0_PAD: begin
                if(sha_ready) begin
                    next_state = PAD_0; // back to idle
                end
                else begin
                    next_state = WAIT_0_PAD; // back to idle
                end
            end
            PAD_1: begin
                next_state = PAD_0;
            end
            PAD_0: begin
                if(next_word_count < 4'd14) begin
                    next_state = PAD_0; // continue padding with zeros
                end
                else begin
                    next_state = PAD_LEN; // move to length padding
                end
            end
            PAD_LEN: begin
                next_state = WAIT_SHA; // move to wait state
            end
            WAIT_SHA: begin
                if(sha_valid) begin
                    next_state = IDLE; // back to idle
                end
                else begin
                    next_state = WAIT_SHA; // stay in wait_sha
                end
            end
            WAIT: begin
                if(t_valid && sha_valid) begin
                    next_state = TRANS_DATA; // new data block
                end
                else if(!t_valid && sha_valid) begin
                    next_state = PAD_0; // back to idle
                end
                else begin
                    next_state = WAIT; // back to idle
                end
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Padded data output logic
    always @(posedge clk) begin
        if (!rst_n) begin
            counter_start   <= 1'b0;
            data_len_words  <= 4'b0;
            padded_data_out <= 32'b0;
            start <= 1'b0;
            restart <= 1'b0;
            t_ready <= 1'b0;
            sha_done <= 0;
        end
        else begin
            case (current_state)
                IDLE: begin
                    padded_data_out <= data_in; // pass through input data
                    start   <= 1'b0;
                    if(sha_ready && t_valid) begin
                        t_ready <= 1'b1;
                    end
                    else begin 
                        t_ready <= 1'b0;
                    end

                    if(t_ready)begin
                        counter_start   <= 1'b1;
                        restart <= 1'b1;
                        data_len_words <= 'b0;
                    end
                    else begin
                        counter_start  <= 1'b0;
                        restart <= 1'b0;
                    end
                end
                TRANS_DATA: begin
                    restart <= 1'b0;
                    start   <= 1'b1;
                    t_ready <= 1'b1;
                    counter_start   <= 1'b1;
                    padded_data_out <= data_in; // pass through input data
                    data_len_words <= data_len_words + 4'd1; // calculate length in words
                    if(next_word_count == 4'd15) begin
                        counter_start  <= 1'b0;
                        t_ready <= 1'b0; // not ready to accept more data
                    end
                end
                PAD_1_DIR: begin
                    padded_data_out <= 32'h80000000; // append '1' bit
                end
                WAIT_0_PAD: begin
                    t_ready <= 1'b0;
                    sha_done <= 1'b0;
                    padded_data_out <= 32'h00000000; // append '1' bit
                    if(next_state == PAD_0)begin
                        counter_start   <= 1'b1;
                        start   <= 1'b1;
                    end
                    else begin
                        start   <= 1'b0;
                        counter_start   <= 1'b0;
                    end
                end
                PAD_1: begin
                    t_ready <= 1'b0;
                    start   <= 1'b0;
                    counter_start   <= 1'b1;
                    padded_data_out <= 32'h80000000; // append '1' bit
                end
                PAD_0: begin
                    t_ready <= 1'b0;
                    start   <= 1'b0;
                    padded_data_out <= 32'h00000000; // append '0' bits
                end
                PAD_LEN: begin
                    t_ready <= 1'b0;
                    counter_start   <= 1'b0;
                    padded_data_out <= (data_len_words + 16'd1) << 5; // append length (for simplicity, assuming length fits in 32 bits)
                end
                WAIT: begin
                    sha_done <= 1'b0;
                    counter_start   <= 1'b0;
                    start <= 1'b0;
                    t_ready <= 1'b0;
                    if(sha_valid) begin
                        t_ready <= (next_state == TRANS_DATA ) ? 1'b1 : 1'b0; // ready if next state is not PAD_1
                    end

                    if(next_state == PAD_0) begin
                        counter_start   <= 1'b1;
                        start <= 1'b1;
                        padded_data_out <= 32'h80000000; // pass through input data
                    end
                    else begin
                        padded_data_out <= data_in; // pass through input data
                    end
                end
                WAIT_SHA: begin
                    sha_done <= 1'b1;
                end
            endcase
        end
    end
    
endmodule
