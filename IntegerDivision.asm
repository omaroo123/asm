// IntegerDivision.asm
// Computes quotient m and remainder q satisfying:
//      x = y * m + q,
// where q has the same sign as x and |q| < |y|.
// Input:  R0 = x, R1 = y (signed)
// Output: R2 = m (quotient), R3 = q (remainder), R4 = flag (0 if valid, 1 if y==0)
// The values in R0 and R1 must not be modified.

// --- Check for division by zero ---
    @R1
    D=M
    @DIV_BY_ZERO
    D;JEQ

// --- Valid division: clear flag ---
    @R4
    M=0

// --- Save original x and y ---
    @R0
    D=M
    @R5
    M=D        // R5 <- x
    @R1
    D=M
    @R6
    M=D        // R6 <- y

// --- Compute |x| into R7 ---
    @R5
    D=M
    @X_NONNEG
    D;JGE     // if x >= 0, jump
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

// --- Compute |y| into R8 ---
    @R6
    D=M
    @Y_NONNEG
    D;JGE
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

// --- Division loop (using absolute values) ---
// Initialize quotient (absolute value) in R2 to 0.
    @R2
    M=0
(DIV_LOOP)
    @R7
    D=M
    @R8
    D=D-M      // D = (|x| - |y|)
    @END_DIV_LOOP
    D;JLT     // if |x| < |y|, exit loop
    // Subtract |y| from |x|
    @R8
    D=M
    @R7
    M=M-D
    // Increment quotient (absolute)
    @R2
    M=M+1
    @DIV_LOOP
    0;JMP
(END_DIV_LOOP)

// --- Adjust quotient sign ---
// The desired quotient is negative when x and y have opposite signs.
// Check: if (x >= 0 and y < 0) or (x < 0 and y >= 0), then negate R2.
    @R5
    D=M
    @POS_X_NEG_CHECK
    D;JLT     // if x < 0, branch to POS_X_NEG_CHECK
    // x is nonnegative:
    @R6
    D=M
    @NEGATE_QUOTIENT
    D;JLT     // if y < 0 then signs differ → negate quotient
    @CONTINUE_DIV
    0;JMP
(POS_X_NEG_CHECK)
    // x is negative:
    @R6
    D=M
    @NEGATE_QUOTIENT
    D;JGE     // if y >= 0 then signs differ → negate quotient
(NEGATE_QUOTIENT)
    @R2
    D=M
    D=0-D
    @R2
    M=D
(CONTINUE_DIV)

// --- Set remainder ---
// We already have the absolute remainder in R7.
// To give q the same sign as x, if x is negative then q = -|r|; otherwise, q = |r|.
    @R5
    D=M
  



