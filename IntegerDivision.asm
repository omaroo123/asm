// IntegerDivision.asm
// Computes m and q such that x = y*m + q, with q having the same sign as x and |q| < |y|.
// x is initially in R0 and y in R1.
// The quotient m is stored in R2 and the remainder q in R3.
// The flag in R4 is set to 1 if y is zero (invalid division) and to 0 otherwise.
// The values in R0 and R1 are not modified.
// Temporary registers used:
//   R5 = copy of x, R6 = copy of y,
//   R7 = |x| (working remainder), R8 = |y|.

    // --- Copy original x and y into temporaries ---
    @R0
    D=M
    @R5
    M=D         // R5 <- x
    @R1
    D=M
    @R6
    M=D         // R6 <- y

    // --- Check for division by zero ---
    @R6
    D=M
    @DIV_BY_ZERO
    D;JEQ      // if y == 0, jump to error routine

    // Valid division: clear flag (R4 = 0)
    @R4
    M=0

    // --- Compute absolute value of x into R7 ---
    @R5
    D=M
    @X_POSITIVE
    D;JGE      // if x >= 0, jump to X_POSITIVE
    // x is negative: R7 = -x
    @R5
    D=M
    D=0-D
    @R7
    M=D
    @AFTER_X_ABS
    0;JMP
(X_POSITIVE)
    @R5
    D=M
    @R7
    M=D       // R7 = x (already nonnegative)
(AFTER_X_ABS)

    // --- Compute absolute value of y into R8 ---
    @R6
    D=M
    @Y_POSITIVE
    D;JGE      // if y >= 0, jump to Y_POSITIVE
    // y is negative: R8 = -y
    @R6
    D=M
    D=0-D
    @R8
    M=D
    @AFTER_Y_ABS
    0;JMP
(Y_POSITIVE)
    @R6
    D=M
    @R8
    M=D       // R8 = y (nonnegative)
(AFTER_Y_ABS)

    // --- Division loop on absolute values ---
    // Initialize quotient (m) in R2 to 0.
    @R2
    M=0

(DIV_LOOP)
    // If current remainder (in R7) is less than divisor (in R8), we are done.
    @R7
    D=M
    @R8
    D=D-M
    @DIV_END
    D;JLT     // if (|x| - |y|) < 0 then exit loop

    // Subtract divisor: R7 = R7 - R8
    @R8
    D=M
    @R7
    M=M-D

    // Increment quotient (R2 = R2 + 1)
    @R2
    D=M
    D=D+1
    @R2
    M=D

    @DIV_LOOP
    0;JMP

(DIV_END)
    // --- Adjust sign of the quotient ---
    // We want the quotient to be negative when x and y have different signs.
    // Check the sign of x (in R5).
    @R5
    D=M
    @X_NONNEG
    D;JGE     // if x >= 0, jump to X_NONNEG
    // Here x is negative.
    @R6
    D=M
    @XNEG_Y_NONNEG
    D;JGE     // if y >= 0 then x negative and y nonnegative: need to negate quotient.
    @SKIP_NEGATE
    0;JMP
(X_NONNEG)
    // Here x is nonnegative.
    @R6
    D=M
    @NEGATE_QUOTIENT
    D;JLT     // if y < 0 then different signs: negate quotient.
    @SKIP_NEGATE
    0;JMP
(XNEG_Y_NONNEG)
    // x negative and y nonnegative: fall through to negate.
    @NEGATE_QUOTIENT
    0;JMP
(NEGATE_QUOTIENT)
    // Negate quotient in R2: R2 = 0 - R2.
    @R2
    D=M
    D=0-D
    @R2
    M=D
(SKIP_NEGATE)

    // --- Adjust the remainder's sign ---
    // The remainder must have the same sign as x.
    @R5
    D=M
    @NO_REMAINDER_NEGATE
    D;JGE     // if x >= 0, no change is needed.
    // Otherwise, negate remainder in R7.
    @R7
    D=M
    D=0-D
    @R7
    M=D
(NO_REMAINDER_NEGATE)

    // --- Store final remainder ---
    @R7
    D=M
    @R3
    M=D

    // --- End of valid division ---
    @END_DIV
    0;JMP

(DIV_BY_ZERO)
    // Division by zero: set flag (R4 = 1) and clear quotient and remainder.
    @R4
    M=1
    @R2
    M=0
    @R3
    M=0

(END_DIV)
    // Infinite loop to end program.
    @END_DIV
    0;JMP



