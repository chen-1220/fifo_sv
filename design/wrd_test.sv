/*
*   文件名：wrd_test.sv
*   模块名：wrd_test
*   作者  ：Will Chen
*   日期  ：
*       -- 2024.10.8 完成代码的编写与验证
*
*   模块功能：该模块用于存储类模块的读写测试，复位结束后周期性的生成写读信号
*
*   模块参数：
*       -- ADDR_WIDTH   ：数据深度
*       -- DATA_WIDTH   ：数据位宽
*
*   模块接口：native接口，读写使能、读写数据
*
*   说明：
*       -- 该模块的信号产生是固定的，不会进行握手或者等待存储模块响应
*/
module wrd_test#(
    parameter   ADDR_WIDTH = 18,
    parameter   DATA_WIDTH = 32
)(
    input   logic                       clk     ,
    input   logic                       rst     , 
    output  logic   [ADDR_WIDTH-1:0]    wr_addr ,
    output  logic   [ADDR_WIDTH-1:0]    rd_addr ,
    output  logic   [DATA_WIDTH-1:0]    wr_data ,
    output  logic                       wr_en   ,
    output  logic                       rd_en   
);

    logic   [$clog2(2**ADDR_WIDTH)-1:0] wrd_cnt;
    logic                               wrd_flag;
    logic                               wr_flag;
    logic                               rd_flag;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            wrd_cnt <= '0;
            wrd_flag<=  1'b1;
        end
        else begin
            if (wrd_cnt == 2**ADDR_WIDTH - 1) begin
                wrd_cnt <= '0;
                wrd_flag<= ~wrd_flag;
            end
            else begin
                wrd_cnt <= wrd_cnt + 1;
                wrd_flag<= wrd_flag;
            end
        end
    end

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_addr <=  '0;
            rd_addr <=  '0;
            wr_data <=  '0;
            wr_en   <=  '0;
            rd_en   <=  '0;
        end
        else begin
            if (wrd_flag) begin
                wr_addr <= wrd_cnt;
                wr_data <= wrd_cnt;
                wr_en   <= 1'b1;
                rd_en   <= 1'b0;
            end 
            else begin
                rd_addr <= wrd_cnt;
                rd_en   <= 1'b1;
                wr_en   <= 1'b0;
            end
        end
    end

endmodule
