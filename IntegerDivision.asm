// IntegerDivision.asm
// Computes signed division:
//   Given x in R0 and y in R1,
//   finds quotient m and remainder q such that:
//       x = y * m + q,
//   where q has the same sign as x and |q| < |y|.
// Outputs:
//   R2 = m (quotient)
//   R3 = q (remainder)
//   R4 = flag (0 if valid division; 1 if y==0)
// The original values in R0 and R1 are not modified.

    @R1
    D=M
    @DIVZERO
    D;JEQ            // if y == 0, go to DIVZERO

    // Valid division: clear flag (R4 = 0)
    @R4
    M=0

    // Copy x to R5 and y to R6
    @R0
    D=M
    @R5
    M=D
    @R1
    D=M
    @R6
    M=D

    // Compute |x| into R7
    @R5
    D=M
    @X_POS
    D;JGE          // if x >= 0, jump to X_POS
      // x is negative: |x| = 0 - x
      @R5
      D=M
      D=0-D
      @R7
      M=D
      @X_DONE
      0;JMP
(X_POS)
      @R5
      D=M
      @R7
      M=D
(X_DONE)

    // Compute |y| into R8 using R6
    @R6
    D=M
    @Y_POS
    D;JGE          // if y >= 0, jump to Y_POS
      // y is negative: |y| = 0 - y
      @R6
      D=M
      D=0-D
      @R8
      M=D
      @Y_DONE
      0;JMP
(Y_POS)
      @R6
      D=M
      @R8
      M=D
(Y_DONE)

    // Initialize quotient R2 to 0
    @R2
    M=0

(DIV_LOOP)
    // If (|x| - |y|) < 0, exit loop.
    @R7
    D=M
    @R8
    D=D-M
    @END_DIV_LOOP
    D;JLT

    // Subtract: R7 = R7 - R8
    @R7
    D=M
    @R8
    D=D-M
    @R7
    M=D

    // Increment quotient: R2 = R2 + 1
    @R2
    D=M
    D=D+1
    @R2
    M=D

    @DIV_LOOP
    0;JMP
(END_DIV_LOOP)

    // Adjust quotient sign.
    // If exactly one of x (R5) and y (R6) is negative, then negate R2.
    @R5
    D=M           // D = x
    @X_NEG_CHECK
    D;JLT         // if x < 0, go to X_NEG_CHECK
      // x >= 0: check if y < 0
      @R6
      D=M
      @DO_NEGATE
      D;JLT     // if y < 0, need to negate quotient
      @AFTER_QUOTIENT
      0;JMP
(X_NEG_CHECK)
      // x < 0: if y >= 0 then negate quotient
      @R6
      D=M
      @AFTER_QUOTIENT
      D;JLT     // if y < 0, both are negative so no change
      @DO_NEGATE
      0;JMP
(DO_NEGATE)
      @R2
      D=M
      D=0-D
      @R2
      M=D
(AFTER_QUOTIENT)

    // Adjust remainder sign to match x.
    // R7 holds the absolute remainder.
    @R5
    D=M
    @REMAINDER_NEG
    D;JLT         // if x < 0, go to REMAINDER_NEG
      // x is nonnegative: remainder = R7
      @R7
      D=M
      @R3
      M=D
      @END_INTDIV
      0;JMP
(REMAINDER_NEG)
      @R7
      D=M
      D=0-D
      @R3
      M=D
(END_INTDIV)
    @END
    0;JMP

(DIVZERO)
    // Division by zero: set flag and clear quotient and remainder.
    @R4
    M=1
    @R2
    M=0
    @R3
    M=0
    @END
    0;JMP

(END)
    @END
    0;JMP

