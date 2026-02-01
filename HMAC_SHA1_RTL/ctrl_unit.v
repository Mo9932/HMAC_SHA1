module ctrl_unit (
    input rst_n     ,
    input clk       ,
    input sha_ready ,
    /* slave axis interface */
    input t_last    ,
    input t_valid   ,
    output reg t_ready   ,
    /* to input padding unit */
    output reg sel  ,  
    output reg padd_start  ,  
    output reg valid_to_sha   
);

    localparam IDLE         = 2'b00;
    localparam INNER_PADD   = 2'b01;
    localparam MESSAGE_SEND = 2'b11;
    localparam DONE         = 2'b10;

    reg [3:0] inner_padd_counter;
    reg counter_en;
    reg [1:0] cs, ns;
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            cs <= IDLE;
        end 
        else begin
            cs <= ns;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            inner_padd_counter <= 0;
        end 
        else if(counter_en)begin
            inner_padd_counter <= inner_padd_counter + 4'b1;
        end
    end

    always @(*) begin
        sel = 'b0;
        counter_en = 0;
        ns  = cs ;
        valid_to_sha = 0;
        t_ready = 0;
        padd_start = 0;
        case (cs)
           IDLE        : begin
                padd_start = 0;
                valid_to_sha = t_last;
                t_ready = t_last;
                sel =t_last;
                if(t_valid && !t_last)begin
                    ns = INNER_PADD;
                    padd_start = 1;
                end 
                else begin
                    ns = IDLE;
                end
            end 
            INNER_PADD  : begin
                sel = 0;
                valid_to_sha = 1;
                ns = (inner_padd_counter == 15)? MESSAGE_SEND : INNER_PADD;

                t_ready = (inner_padd_counter > 10)? 1'b1 : 1'b0;
                counter_en = (sha_ready)? 1'b1 : 1'b0;
            end 
            MESSAGE_SEND: begin
                t_ready = 1;
                valid_to_sha = 1;
                sel = 1;
                if(t_last) begin
                    ns = IDLE;
                end
            end 
            DONE        : begin
                ns = IDLE ;
            end  
        endcase
    end

endmodule