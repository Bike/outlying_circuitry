`timescale 1ns / 1ps

// Clock divider.
// Given a clock signal, outputs a clock signal at a lower frequency.
// The output frequency is controlled at instantiation time with the CYCLES parameter.
// A change in the divided signal happens every time a counter counts CYCLES posedges on the input clock.
// So for example, if CYCLES is fifty million, and the input clock is 100 MHz, the output clock will be 1 Hz.
// The factor of two is of course confusing; this interface is not ideal.

// PARAMETERS
// CYCLES, as above

// PORTS
// clk, in, a clock signal
// reset, in, a synchronous reset
// out, out, the output clock signal

module clkdiv
  #(parameter CYCLES = 50000000)
   (
    input      clk,
    input      reset,
    output reg out = 1'b0
    );
   
   reg [$clog2(CYCLES)-1:0] count;
   
   always @(posedge(clk))
     if (reset == 1'b1)
       begin
	  count <= 0;
	  out <= 1'b1;
       end
     else if (count == CYCLES - 1)
       begin
	  count <= 0;
	  out <= ~out;
       end
     else
       count <= count + 1'b1;

endmodule
