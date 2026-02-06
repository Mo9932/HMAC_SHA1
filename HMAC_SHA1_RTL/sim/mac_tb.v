module mac_tb;
    
    localparam WIDTH = 32;

    reg               clk         ;
    reg               rst_n       ;
    reg               start       ; // only take data when authentication is done
    reg               tlast_s     ;
    reg   [WIDTH-1:0] tdata_s     ;
    reg   [WIDTH-1:0] weight_s    ;
    wire  [2*WIDTH-1:0] result    ;
    wire                done      ;
    wire                tready_s  ;

    reg [2* WIDTH -1 :0] expected_result = 0;

    // clock generation
    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end


    initial begin
        rst_n     = 0;    
        start     = 0;    
        tlast_s   = 0;    
        tdata_s   = 0; 
        weight_s  = 0; 
        #30;
        @(posedge clk)   rst_n  = 1;

        // start mac
        @(posedge clk) start = 1;
        wait(tready_s);
        start = 0;
        repeat (19) begin
            tdata_s  = $random % 100; // random data from 0 to 99
            weight_s = $random % 100; // random data from 0 to 99
            expected_result = expected_result + tdata_s * weight_s;
            @(posedge clk);
        end
        tlast_s = 1;
        tdata_s = $random % 100; // random data from 0 to 99
        weight_s = $random % 100; // random data from 0 to 99
        expected_result = expected_result + tdata_s * weight_s;
        
        @(posedge clk);
        tlast_s = 0;
        #1;
        $display("expected_result: %d, result: %d", expected_result, result);
        $stop;
    end




    // DUT instantiation
    mac #(
        .WIDTH(WIDTH)
    ) DUT (
        .clk        (clk     ),
        .rst_n      (rst_n   ),
        .start      (start   ), // only take data when authentication is done
        .tlast_s    (tlast_s ),
        .tready_s   (tready_s),
        .tdata_s    (tdata_s ),
        .weight_s   (weight_s),
        .result     (result  ),
        .done       (done)
    );
endmodule