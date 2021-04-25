// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
  @R2
  M = 0
  @R1
  D = M
  @i
  M = D

(LOOP)
  @i
  M = M - 1
  D = M
@END
  D;JLT
  @R0 // 3
  D = M // D = 3
  @R2
  M = M + D // R2 = 0 + 3
@LOOP
  0;JEQ

(END)
  @END
  0;JMP
