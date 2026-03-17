`timescale 1ns / 1ps

module aluControl(
    input [1:0] ALUOp,
    //using the opcode and then connect it 
    input [2:0] funct3,
    input [6:0] funct7,
    output reg [3:0] ALUControl
    );
        
        always @(*)begin 
            case (ALUOp)
                2'b00: begin  //load /store
                    ALUControl= 4'b0010;
                end
                2'b01: begin //branch
                    case(funct3)
                    3'b000: ALUControl=4'b0110; //beq
                    3'b001: ALUControl=4'b0110;//bne
                    3'b100: ALUControl=4'b0111;//blt
                    3'b101: ALUControl=4'b0111;//bge
                    3'b110: ALUControl=4'b1000;//bltu
                    3'b111: ALUControl=4'b1000;//bgeu
                    default: ALUControl=4'b1111;
                    endcase 
                end
               2'b10:begin
               //R-type and I-type
               if (funct7 == 7'b0000000) begin
                    case(funct3)
                    3'b000: ALUControl= 4'b0010;// ADD
                    3'b001: ALUControl= 4'b0100;//sll
                    3'b010: ALUControl= 4'b0111;//slt
                    3'b011: ALUControl= 4'b1000;//sltu
                    3'b100: ALUControl= 4'b0011;//xor
                    3'b101: ALUControl= 4'b0101;//srl
                    3'b110: ALUControl= 4'b0001;//or
                    3'b111: ALUControl= 4'b0000;//and
                    default: ALUControl =4'b1111; 
                    
                    endcase 
               end
               else begin 
               case ({funct7,funct3})
               10'b0100000000: ALUControl = 4'b0110; // SUB
               10'b0100000101: ALUControl = 4'b1101; // SRA
               default: ALUControl = 4'b0010; // Default to ADD
               endcase 
               end
               end
               default:ALUControl =4'b1111;
            endcase 
        end
    
    
endmodule
