`timescale 1ns/1ns

module sync_fifo_native_tb;

    parameter ADDR_WIDTH = 10    ;
    parameter DATA_WIDTH = 10    ;

    logic                       clk     ;
    logic                       rst     ;
    logic                       wr_en   ;
    logic                       rd_en   ;
    logic   [DATA_WIDTH-1:0]    wr_data ;
    logic   [DATA_WIDTH-1:0]    rd_data ;
    logic                       full    ;
    logic                       empty   ;

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        #100
        @(posedge clk)
        rst = 0;
        #25us
        $stop;
    end

    sync_fifo_native #(
        .ADDR_WIDTH             (ADDR_WIDTH),
        .DATA_WIDTH             (DATA_WIDTH),
        .BUFFER_OUT_EN          (0)
    )u_sync_fifo_native(
        .clk     ,
        .rst     ,
        .wr_en   ,
        .rd_en   ,
        .wr_data ,
        .rd_data ,
        .full    ,
        .empty
    );

    wrd_test#(
        .ADDR_WIDTH     (ADDR_WIDTH),
        .DATA_WIDTH     (DATA_WIDTH)
    )u_wrd_test(
        .clk     ,
        .rst     , 
        .wr_data ,
        .wr_en   ,
        .rd_en   
    );
endmodule