// IntegerDivision.asm
// Computes quotient m and remainder q satisfying:
//      x = y * m + q,
// with q having the same sign as x and |q| < |y|.
// Inputs:  R0 = x, R1 = y (signed)
// Outputs: R2 = m (quotient), R3 = q (remainder), R4 = flag (0 if valid, 1 if y==0)
// The original values in R0 and R1 must not be modified.
// Temporaries used:
//   R5: copy of x, R6: copy of y,
//   R7: working |x| (absolute x), R8: working |y| (absolute y)

    // --- Check for division by zero ---
    @R1
    D=M
    @DIV_BY_ZERO
    D;JEQ

    // --- Valid division: clear flag ---
    @R4
    M=0

    // --- Save original values (x and y) ---
    @R0
    D=M
    @R5
    M=D       // R5 <- x
    @R1
    D=M
    @R6
    M=D       // R6 <- y

    // --- Compute absolute value of x into R7 ---
    @R5
    D=M
    @X_NONNEG
    D;JGE     // if x >= 0, jump to X_NONNEG
    // x is negative: |x| = 0 - x
    @R5
    D=M
    D=0-D
    @R7
    M=D
    @X_DONE
    0;JMP
(X_NONNEG)
    @R5
    D=M
    @R7
    M=D
(X_DONE)

    // --- Compute absolute value of y into R8 ---
    @R6
    D=M
    @Y_NONNEG
    D;JGE     // if y >= 0, jump to Y_NONNEG
    // y is negative: |y| = 0 - y
    @R6
    D=M
    D=0-D
    @R8
    M=D
    @Y_DONE
    0;JMP
(Y_NONNEG)
    @R6
    D=M
    @R8
    M=D
(Y_DONE)

    // --- Division loop on absolute values ---
    // Initialize quotient (absolute value) in R2 to 0.
    @R2
    M=0

(DIV_LOOP)
    @R7
    D=M
    @R8
    D=D-M      // D = (|x| - |y|)
    @END_DIV_LOOP
    D;JLT      // if |x| < |y|, exit loop
    // Subtract |y| from |x|
    @R8
    D=M
    @R7
    M=M-D
    // Increment quotient (absolute value)
    @R2
    M=M+1
    @DIV_LOOP
    0;JMP
(END_DIV_LOOP)

    // --- Adjust quotient sign ---
    // Negate quotient if (x>=0 and y<0) OR (x<0 and y>=0)
    @R5
    D=M
    @X_NEG_CHECK
    D;JLT      // if x < 0, jump to X_NEG_CHECK branch
    // x is nonnegative:
    @R6
    D=M
    @NEGATE_FLAG
    D;JLT      // if y < 0 then signs differ → need to negate
    @CONTINUE_DIV
    0;JMP
(X_NEG_CHECK)
    @R6
    D=M
    @CONTINUE_DIV
    D;JLT      // if y < 0 then both x and y are negative → no negate
    @NEGATE_FLAG
    0;JMP
(NEGATE_FLAG)
    @R2
    D=M
    D=0-D
    @R2
    M=D
(CONTINUE_DIV)

    // --- Set remainder with the same sign as x ---
    // R7 holds the absolute remainder.
    @R5
    D=M
    @SET_REMAINDER_NEG
    D;JLT      // if x < 0, need to negate remainder
    // x is nonnegative:
    @R7
    D=M
    @R3
    M=D
    @END_INTDIV
    0;JMP
(SET_REMAINDER_NEG)
    @R7
    D=M
    D=0-D
    @R3
    M=D
(END_INTDIV)
    @END_INTDIV
    0;JMP

    // --- Division by zero handling ---
(DIV_BY_ZERO)
    @R4
    M=1       // Set flag to 1 (invalid division)
    @R2
    M=0       // Clear quotient
    @R3
    M=0       // Clear remainder
    @END_INTDIV
    0;JMP




