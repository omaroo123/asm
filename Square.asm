// Square.asm
// Input:  R0 = integer (signed)
// Output: R1 = (R0)^2
// R0 must not be modified.
// Temporaries: R2 = loop counter, R3 = n = |R0|

// Compute |R0| into R3
@R0
D=M
@SQUARE_POS
D;JGE       // if R0 >= 0, jump to SQUARE_POS
  // R0 is negative: n = 0 - R0
  @R0
  D=M
  D=0-D
  @R3
  M=D
  @SQUARE_DONE
  0;JMP
(SQUARE_POS)
  @R0
  D=M
  @R3
  M=D
(SQUARE_DONE)

// Copy n into loop counter R2
@R3
D=M
@R2
M=D

// Initialize result in R1 = 0
@R1
M=0

// Loop: while (R2 > 0) { R1 = R1 + R3; R2 = R2 - 1 }
(SQUARE_LOOP)
  @R2
  D=M
  @SQUARE_END
  D;JEQ       // if R2 == 0, exit loop
  @R1
  D=M
  @R3
  D=D+M     // add n (in R3) to accumulator (R1)
  @R1
  M=D
  @R2
  M=M-1    // decrement loop counter
  @SQUARE_LOOP
  0;JMP
(SQUARE_END)
@END_SQUARE
0;JMP

(END_SQUARE)
@END_SQUARE
0;JMP

