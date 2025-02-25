// Square.asm
// Computes the square of the integer in R0 and stores the result in R1.
// R0 is not modified.
// The square is computed by adding |R0| to itself |R0| times.
    
    @R0
    D=M
    @POS_SQUARE
    D;JGE         // if R0 >= 0, jump to POS_SQUARE
      // R0 is negative: compute |R0| = 0 - R0
      @R0
      D=M
      D=0-D
      @R3
      M=D
      @SQUARE_ABS_DONE
      0;JMP
(POS_SQUARE)
      @R0
      D=M
      @R3
      M=D
(SQUARE_ABS_DONE)

    // Copy |R0| (stored in R3) into loop counter R2
    @R3
    D=M
    @R2
    M=D

    // Initialize result in R1 to 0
    @R1
    M=0

(SQUARE_LOOP)
    @R2
    D=M
    @SQUARE_END
    D;JEQ         // if counter == 0, finish loop
    // Add |R0| (in R3) to accumulator R1: R1 = R1 + R3
    @R1
    D=M
    @R3
    D=D+M
    @R1
    M=D
    // Decrement counter: R2 = R2 - 1
    @R2
    D=M
    D=D-1
    @R2
    M=D
    @SQUARE_LOOP
    0;JMP
(SQUARE_END)
    @FINAL_SQUARE
    0;JMP
(FINAL_SQUARE)
    @FINAL_SQUARE
    0;JMP
