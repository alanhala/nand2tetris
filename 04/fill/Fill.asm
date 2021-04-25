// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.
  @SCREEN
  D = A
  @8192
  D = D + A
  @n
  M = D
  @LAST_COLOR
  M = 1

(LOOP)
  @KBD
  D = M
  @DRAW
  D; JEQ
  D = -1

(DRAW)
  // Check if color needs to be changed.
  @COLOR
  M = D
  @LAST_COLOR
  D = M - D
  @LOOP
  D; JEQ

  // COLOR changed
  @COLOR
  D = M
  @LAST_COLOR
  M = D

  @SCREEN
  D = A
  @i
  M = D

(DRAW_LOOP)
  @i
  D = M
  @n
  D = D - M
  @LOOP
  D; JEQ

  @COLOR
  D = M
  @i
  A = M
  M = D
  @i
  M = M + 1
  @DRAW_LOOP
  0; JMP
