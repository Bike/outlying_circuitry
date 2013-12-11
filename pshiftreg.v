`timescale 1ns / 1ps

// Parallel input serial output shift register.

// Parameters
// WIDTH. width of the state in bits

// Ports
// clk, in. clock signal
// data, in. data to be loaded
// load, in. high when data should be loaded (synchronous w/clk)
// out, out.

module pshiftreg
  #(parameter WIDTH = 16)
   (
    input 	      clk,
    input [WIDTH-1:0] data,
    input 	      load,
    output 	      out
    );
   
   reg [WIDTH-1:0]    state;
   
   assign out = state[WIDTH-1];

   // who needs explicit flipflops. should shift in zero
   always @(posedge(clk))
     begin
	state <= state << 1'b1;
	if (load == 1'b1) state <= data;
     end
   
endmodule
