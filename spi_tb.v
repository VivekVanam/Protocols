`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2026 19:51:17
// Design Name: 
// Module Name: spi_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module spi_tb;
reg clk;
reg reset;
reg [15:0]datain;
reg [15:0]dataout;

wire spi_cs;
wire spi_clk;
wire spi_data;
wire master_data;
wire [4:0]counter;

spi dut(
.clk(clk),
.reset(reset),
.datain(datain),
.dataout(dataout),
.spi_cs(spi_cs),
.spi_clk(spi_clk),
.spi_data(spi_data),
.master_data(master_data),
.counter(counter)
);

initial
begin
clk = 0;
reset = 1;
datain = 0;
dataout= 0;
end

always #5 clk =~clk;

initial
begin
#10 reset =1'b0;

#10 datain = 16'hA569; dataout = 16'h3425;
#335 datain= 16'h2563; dataout = 16'h0001;
#335 datain= 16'h9B63; dataout = 16'hA569;
#335 datain= 16'h6A61; dataout = 16'h9B22;

end

endmodule
