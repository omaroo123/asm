// IntegerDivision.asm
// Input: R0 = x, R1 = y (signed)
// Output: R2 = quotient, R3 = remainder, R4 = flag (1 if y==0, else 0)
// The values in R0 and R1 must not be modified.

// -- Check for division by zero --
    @R1
    D=M
    @DIV_BY_ZERO
    D;JEQ   // if y==0, jump to error handling

// -- Valid division: clear flag --
    @R4
    M=0

// -- Save original values --
    @R0
    D=M
    @R5
    M=D       // R5 <- x
    @R1
    D=M
    @R6
    M=D       // R6 <- y

// -- Compute absolute value of x into R7 --
    @R5
    D=M
    @X_POS
    D;JGE   // if x >= 0, jump to X_POS
    // x is negative
    @R5
    D=M
    D=0-D
    @R7
    M=D
    @AFTER_ABS_X
    0;JMP
(X_POS)
    @R5
    D=M
    @R7
    M=D
(AFTER_ABS_X)

// -- Compute absolute value of y into R8 --
    @R6
    D=M
    @Y_POS
    D;JGE   // if y >= 0, jump to Y_POS
    // y is negative
    @R6
    D=M
    D=0-D
    @R8
    M=D
    @AFTER_ABS_Y
    0;JMP
(Y_POS)
    @R6
    D=M
    @R8
    M=D
(AFTER_ABS_Y)

// -- Initialize quotient (R2 = 0) --
    @R2
    M=0

// -- Division loop: subtract |y| from |x| until remainder < |y| --
(DIV_LOOP)
    @R7
    D=M
    @R8
    D=D-M    // D = (current remainder) - |y|
    @END_DIV_LOOP
    D;JLT   // if (|x| < |y|) then exit loop
    // Subtract |y| from R7:
    @R8
    D=M
    @R7
    M=M-D   // R7 = R7 - |y|
    // Increment quotient in R2:
    @R2
    M=M+1
    @DIV_LOOP
    0;JMP
(END_DIV_LOOP)

// -- Adjust the quotient's sign --
// If x and y have opposite signs, the quotient is negated.
    @R5
    D=M
    @POS_X
    D;JGE   // if x >= 0, jump to POS_X
    // Here: x is negative.
    @R6
    D=M
    @NEGATE_Q
    D;JGE   // if y >= 0 then different signs → negate quotient.
    @SKIP_NEG_Q
    0;JMP
(POS_X)
    // x nonnegative: if y < 0 then negate quotient.
    @R6
    D=M
    @NEGATE_Q
    D;JLT   // if y < 0 → negate quotient.
    @SKIP_NEG_Q
    0;JMP
(NEGATE_Q)
    @R2
    D=M
    D=0-D
    @R2
    M=D
(SKIP_NEG_Q)

// -- Adjust the remainder's sign --
// The remainder must have the same sign as x.
    @R5
    D=M
    @R_REM_NEG
    D;JLT   // if x < 0, jump to negate remainder
    // Otherwise, remainder = R7 as is.
    @R7
    D=M
    @R3
    M=D
    @END_REM
    0;JMP
(R_REM_NEG)
    @R7
    D=M
    D=0-D
    @R3
    M=D
(END_REM)

// -- End of valid division --
    @END
    0;JMP

(DIV_BY_ZERO)
    // Division by zero: set flag to 1 and clear quotient and remainder.
    @R4
    M=1
    @R2
    M=0
    @R3
    M=0

(END)
    @END
    0;JMP



