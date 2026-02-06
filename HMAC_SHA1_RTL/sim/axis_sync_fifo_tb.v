module axis_sync_fifo_tb;

    localparam WIDTH = 32;
    localparam DIPTH = 32;

    reg   i_clk   ;
    reg   i_rst_n ;

    // read channel
    reg              tvalid_s    ;
    reg [WIDTH-1:0]  tdata_s     ;
    reg              tready_s    ; // ready chosen to be input to capture data only when sha is ready

    // write channel
    reg                 tready_m    ;
    wire [WIDTH-1:0]    tdata_m     ;
    wire                tvalid_m    ;
    wire                tlast_m     ;       


    initial begin
        i_clk = 0;
        forever begin
            #5 i_clk = ~i_clk;
        end
    end    

    initial begin
        i_rst_n     = 0;
        tvalid_s    = 0;
        tdata_s     = 0;
        tready_s    = 0;  

        #20 i_rst_n = 1;

        @(posedge i_clk);
        repeat (10) begin
            @(posedge i_clk);
            tvalid_s <= 1;
            tdata_s  <= tdata_s + 1;
            tready_s <= 1;
        end 

        @(posedge i_clk);
        tvalid_s = 0;
        tready_s = 0;

        @(posedge i_clk);
        repeat (12) begin
            @(posedge i_clk);
            tready_m = 1;
        end
        @(posedge i_clk);
        $stop;
    end


    axis_sync_fifo #(
        .WIDTH (WIDTH),
        .DIPTH (DIPTH)
    ) DUT (
        .i_clk      (i_clk   ),
        .i_rst_n    (i_rst_n ),
        .tvalid_s   (tvalid_s),
        .tdata_s    (tdata_s ),
        .tready_s   (tready_s), // ready chosen to be input to capture data only when sha is ready
        .tready_m   (tready_m),
        .tdata_m    (tdata_m ),
        .tvalid_m   (tvalid_m),
        .tlast_m    (tlast_m )
    );
    
endmodule