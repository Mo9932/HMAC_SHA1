`timescale 1ns/1ns

`define message0_len  ((17*4)*8+160) // 4* 17 chars = 17 words = 86 bytes = 544 bits

module HMAC_SHA_tb;

    localparam message0 = {"0123456789abcdeff0123456789abcdeff0123456789abcdeff0123456789abcdeff",160'h3014894b6270d4e2974f17da50cf6adc6b4abe6d};
    localparam expected_hash0 = 160'h3014894b6270d4e2974f17da50cf6adc6b4abe6d;
    reg [`message0_len-1:0] input_vec ; // maximum message length + padding

    integer i;

    // Parameters
    parameter C_S_AXI_DATA_WIDTH	= 32;
    parameter C_S_AXI_ADDR_WIDTH	= 6;
    // AXI4-Lite signals
    reg S_AXI_ACLK; 
    reg S_AXI_ARESETN;
    reg [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR;
    reg S_AXI_AWVALID;
    wire S_AXI_AWREADY;
    reg [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA;
    reg [C_S_AXI_DATA_WIDTH/8-1 : 0] S_AXI_WSTRB;
    reg S_AXI_WVALID;
    wire S_AXI_WREADY;
    wire [1 : 0] S_AXI_BRESP;
    wire S_AXI_BVALID;
    reg S_AXI_BREADY;
    reg [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR;
    reg S_AXI_ARVALID;
    wire S_AXI_ARREADY;
    wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA;
    wire [1 : 0] S_AXI_RRESP;
    wire S_AXI_RVALID;
    reg S_AXI_RREADY;
    // AXI Stream signals
    reg s_axis_aclk;
    reg s_axis_aresetn;
    reg s_axis_tvalid;
    wire s_axis_tready;
    reg [C_S_AXI_DATA_WIDTH-1:0] s_axis_tdata;
    reg s_axis_tlast;
    // Outputs from DUT
    wire auth_err;
    wire auth_done;
    // Instantiate the DUT
    axi_hmac_unit #(
        .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
    ) DUT (
        .S_AXI_ACLK(S_AXI_ACLK),
        .S_AXI_ARESETN(S_AXI_ARESETN),
        .S_AXI_AWADDR(S_AXI_AWADDR),
        .S_AXI_AWVALID(S_AXI_AWVALID),
        .S_AXI_AWREADY(S_AXI_AWREADY),
        .S_AXI_WDATA(S_AXI_WDATA),
        .S_AXI_WSTRB(S_AXI_WSTRB),
        .S_AXI_WVALID(S_AXI_WVALID),
        .S_AXI_WREADY(S_AXI_WREADY),
        .S_AXI_BRESP(S_AXI_BRESP),
        .S_AXI_BVALID(S_AXI_BVALID),
        .S_AXI_BREADY(S_AXI_BREADY),
        .S_AXI_ARADDR(S_AXI_ARADDR),
        .S_AXI_ARVALID(S_AXI_ARVALID),
        .S_AXI_ARREADY(S_AXI_ARREADY),
        .S_AXI_RDATA(S_AXI_RDATA),
        .S_AXI_RRESP(S_AXI_RRESP),
        .S_AXI_RVALID(S_AXI_RVALID),
        .S_AXI_RREADY(S_AXI_RREADY),
        .s_axis_aclk(s_axis_aclk),
        .s_axis_aresetn(s_axis_aresetn),
        .s_axis_tvalid(s_axis_tvalid),
        .s_axis_tready(s_axis_tready),
        .s_axis_tdata(s_axis_tdata),
        .s_axis_tlast(s_axis_tlast),
        .auth_err(auth_err),
        .auth_done(auth_done)
    );

    // write a function to perform axi lite write transaction
    task axi_lite_write(
        input [3:0] addr,
        input [31:0] data
    );
        begin
            @(posedge S_AXI_ACLK);
            S_AXI_AWADDR <= addr;
            S_AXI_AWVALID <= 1'b1;
            S_AXI_WVALID <= 1'b1;

            S_AXI_WDATA <= data;
            S_AXI_WSTRB <= 4'hF;
            @(posedge S_AXI_ACLK);
            while(!S_AXI_AWREADY) @(posedge S_AXI_ACLK);
            S_AXI_AWVALID <= 1'b0;
            S_AXI_WVALID <= 1'b0;

            S_AXI_BREADY <= 1'b1;
            @(posedge S_AXI_ACLK);
            while(!S_AXI_BVALID) @(posedge S_AXI_ACLK);
            S_AXI_BREADY <= 1'b0;
        end 
    endtask

    // Clock generation
    initial begin
        S_AXI_ACLK = 0;
        forever #5 S_AXI_ACLK = ~S_AXI_ACLK; // 100MHz clock
    end
    initial begin
        s_axis_aclk = 0;
        forever #5 s_axis_aclk = ~s_axis_aclk; // 100MHz clock
    end
    // Test sequence
    initial begin
        // Initialize signals
        S_AXI_ARESETN = 0;
        s_axis_aresetn = 0;
        S_AXI_AWADDR = 0;
        S_AXI_AWVALID = 0;
        S_AXI_WDATA = 0;
        S_AXI_WSTRB = 0;
        S_AXI_WVALID = 0;
        S_AXI_BREADY = 0;
        S_AXI_ARADDR = 0;
        S_AXI_ARVALID = 0;
        S_AXI_RREADY = 0;
        s_axis_tvalid = 0;
        s_axis_tdata = 0;
        s_axis_tlast = 0;

        // Release reset
        #20;
        S_AXI_ARESETN = 1;
        s_axis_aresetn = 1;

        // Write CRC_EQ value to DUT
        axi_lite_write(6'd0, 32'h61000000); // Example CRC_EQ value
        axi_lite_write(6'h4, 32'h61000000); // Example CRC_EQ value


        input_vec = 'b0;
        input_vec[`message0_len-1: 0] = message0; // Input message


        #10;
        for (i = 0; i < `message0_len/32; i = i + 1) begin
            @(posedge S_AXI_ACLK);
            s_axis_tdata = input_vec[`message0_len-1- i*32 -: 32];
            s_axis_tvalid = 1;
            s_axis_tlast = (i == (`message0_len/32 - 1)); // Assert t_last on the last word
            @(negedge S_AXI_ACLK);
            wait(s_axis_tready); // Wait until DUT is ready to accept data
        end
        // Deassert valid after last word
        @(posedge S_AXI_ACLK);
        s_axis_tvalid = 0;
        s_axis_tlast = 0;


        wait(auth_done|auth_err)
        $display("**************************************************************************\n");
        $display("Expected Hash0: %h", expected_hash0);
        $display("Computed Hash0: %h", DUT.UNIT_HMAC_SHA1.hash_out_stg2);
        $display("\n**************************************************************************");

        $stop;
    end
    
endmodule
