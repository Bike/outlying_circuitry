`timescale 1ns / 1ps

// clk should be 25 MHz

module vga
  (
   input  clk,
   input  reset,
   output hs,
   output vs,
   );
   
wire carriage;

wire [9:0] hpos;
counter #(800) horiz(.enable(1'b1),.clk(pixclk),.reset(reset),.terminal(carriage),.out(hpos));

wire [9:0] vpos;
wire mover; // for anim
counter #(525) vert(.enable(carriage),.clk(pixclk),.reset(reset),.out(vpos),.terminal(mover));

assign hs = (hpos < 96) ? 1'b1 : 1'b0;
assign vs = (vpos < 2) ? 1'b1 : 1'b0;

endmodule
