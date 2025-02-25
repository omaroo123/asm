// IntegerDivision.asm
// Computes signed division:
//   Given x in R0 and y in R1,
//   finds quotient m and remainder q such that:
//      x = y * m + q,
//   where q has the same sign as x and |q| < |y|.
// Outputs: R2 = m, R3 = q, R4 = flag (0 if valid, 1 if y==0)
// (R0 and R1 are not modified.)

    @R1
    D=M
    @DIVZERO
    D;JEQ            // if y == 0, jump to division-by-zero

    // Valid division: clear flag (R4 = 0)
    @R4
    M=0

    // Save originals: x -> R5, y -> R6
    @R0
    D=M
    @R5
    M=D
    @R1
    D=M
    @R6
    M=D

    // Compute |x| in R7
    @R5
    D=M
    @XPOS
    D;JGE          // if x >= 0, go to XPOS
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

    // Compute |y| in R8
    @R6
    D=M
    @YPOS
    D;JGE          // if y >= 0, go to YPOS
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

    // Initialize quotient (R2) to 0
    @R2
    M=0

(DIV_LOOP)
    // If (R7 - R8) < 0 then exit loop.
    @R7
    D=M
    @R8
    D=D-M
    @DIV_END
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
(DIV_END)

    // Adjust quotient sign:
    // If exactly one of x (R5) and y (R6) is negative, negate R2.
    @R5
    D=M          // D = x
    @XNEG_CHECK
    D;JLT        // if x < 0, go to XNEG_CHECK
    // x >= 0: if y < 0 then negate quotient.
    @R6
    D=M
    @DO_NEGATE
    D;JLT      // if y < 0, jump to DO_NEGATE
    @SKIP_NEGATE
    0;JMP
(XNEG_CHECK)
    // x < 0: if y >= 0 then negate quotient.
    @R6
    D=M
    @SKIP_NEGATE
    D;JLT      // if y < 0, both negative → no negate
    @DO_NEGATE
    0;JMP
(DO_NEGATE)
    @R2
    D=M
    D=0-D
    @R2
    M=D
(SKIP_NEGATE)

    // Adjust remainder sign to match x:
    // R7 holds the absolute remainder.
    @R5
    D=M
    @POS_REM
    D;JGE      // if x >= 0, remainder stays as in R7
    // x is negative: q = 0 - R7
    @R7
    D=M
    D=0-D
    @R3
    M=D
    @END_INTDIV
    0;JMP
(POS_REM)
    @R7
    D=M
    @R3
    M=D
(END_INTDIV)

    @END
    0;JMP

(DIVZERO)
    // Division by zero: set flag to 1 and clear outputs.
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

