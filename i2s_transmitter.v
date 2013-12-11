`timescale 1ns / 1ps

// I2S transmitter
// Presents serialized data suitable for an I2S receiver using the same clocks.
// As per the I2S intent, should automatically truncate or zero-fill samples
//  if sclk is not SAMPLE_WIDTH * lrclk.
// See port descriptions, and relevant standards, for more info.
// Based on a schematic from 1996 I found on the internet. Reliable stuff.

// Dependencies
// pshiftreg

// Parameters
// SAMPLE_WIDTH, width of a sample in bits

// Ports
// left, in. sample to play on left channel
// right, in. sample to play on right channel
// lrclk, in. "left-right clock" signal controlling stereo. Low indicates left channel, and high right
// sclk, in. sample clock controlling serialization.
// sdat, out. serialized data output

module i2s_transmitter
  #(parameter SAMPLE_WIDTH = 16)
   (
    input [SAMPLE_WIDTH-1:0] left,
    input [SAMPLE_WIDTH-1:0] right,
    input 		     lrclk,
    input 		     sclk,
    output 		     sdat
    );

   // delay reg
   reg 			     wsd;
   always @(posedge sclk) wsd <= lrclk;
   
   // another delay reg
   reg 			     idunno;
   always @(posedge sclk) idunno <= wsd;
   
   wire 		     wsp = wsd ^ idunno;

   wire [SAMPLE_WIDTH-1:0]   data = wsd ? right : left;
   
   pshiftreg #(SAMPLE_WIDTH) loader(.clk(~sclk),.data(data),.load(wsp),.out(sdat));
   
endmodule
