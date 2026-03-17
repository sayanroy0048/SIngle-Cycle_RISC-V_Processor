`timescale 1ns/1ps 
module instructionMemory(
  input [31:0] addr,
  output [31:0] instruction
);

  reg [31:0] memory [0:255];
  integer i;

  assign instruction = memory[addr[9:2]];

  initial begin
    for (i = 0; i < 256; i = i + 1)
      memory[i] = 32'h00000013;
   $readmemh("D:/PROCESSOR/riscV/test_program.hex", memory);	 

      end
endmodule
