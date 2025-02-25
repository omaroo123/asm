// IntegerDivision.asm
// Input:  R0 = x, R1 = y (signed)
// Output: R2 = quotient m, R3 = remainder q, R4 = flag (0 if valid, 1 if y==0)
// The originals in R0 and R1 must not be modified.

@R1
D=M
@DIVZERO
D;JEQ          // if y==0, go to DIVZERO

// Valid division: clear flag
@R4
M=0

// Save originals: R5 <- x, R6 <- y
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
@XPOS
D;JGE        // if x>=0, jump to XPOS
  // x is negative: |x| = 0 - x
  @R5
  D=M
  D=0-D
  @R7
  M=D
  @XABS_DONE
  0;JMP
(XPOS)
  @R5
  D=M
  @R7
  M=D
(XABS_DONE)

// Compute |y| into R8
@R6
D=M
@YPOS
D;JGE        // if y>=0, jump to YPOS
  // y is negative: |y| = 0 - y
  @R6
  D=M
  D=0-D
  @R8
  M=D
  @YABS_DONE
  0;JMP
(YPOS)
  @R6
  D=M
  @R8
  M=D
(YABS_DONE)

// Initialize quotient (absolute) in R2 = 0
@R2
M=0

// Repeated subtraction: while (R7 >= R8) { R7 = R7 - R8; R2++ }
(DIV_LOOP)
  @R7
  D=M
  @R8
  D=D-M      // D = |x| - |y|
  @DIV_END
  D;JLT      // if |x| < |y|, exit loop
  // Subtract |y| from |x|
  @R8
  D=M
  @R7
  M=M-D
  // Increment quotient
  @R2
  M=M+1
  @DIV_LOOP
  0;JMP
(DIV_END)

// Adjust quotient sign.
// Quotient must be negative if exactly one of x and y is negative.
// Use original x in R5 and original y in R6.
@R5
D=M         // D = x
@CHECK_XNEG
D;JLT      // if x < 0, go to CHECK_XNEG branch
  // x is nonnegative; if y < 0 then negate quotient.
  @R6
  D=M
  @DO_NEGATE
  D;JLT    // if y < 0, go negate
  @SKIP_NEGATE
  0;JMP
(CHECK_XNEG)
  // x is negative; if y is nonnegative then negate quotient.
  @R6
  D=M
  @SKIP_NEGATE
  D;JLT    // if y < 0, both negative → no negate
  @DO_NEGATE
  0;JMP
(DO_NEGATE)
  @R2
  D=M
  D=0-D
  @R2
  M=D
(SKIP_NEGATE)

// Adjust remainder’s sign to match x.
// R7 holds the absolute remainder.
@R5
D=M
@REM_CHECK
D;JGE      // if x >= 0, remainder stays positive
  // x is negative: negate remainder
  @R7
  D=M
  D=0-D
  @R3
  M=D
  @END_DIV
  0;JMP
(REM_CHECK)
  @R7
  D=M
  @R3
  M=D
(END_DIV)
@END
0;JMP

(DIVZERO)
// Division by zero: set flag and clear outputs.
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





