// Integer Division with Sign Handling and Error Check
// ---------------------------------------------------
// Inputs:
//   R0 - Dividend (can be positive or negative)
//   R1 - Divisor (can be positive or negative)
// Outputs:
//   R2 - Quotient (signed)
//   R3 - Remainder (signed)
//   R4 - Error flag (1 if division by zero, otherwise 0)
// Registers used:
//   R5 - Absolute value of dividend
//   R6 - Absolute value of divisor
//   R7 - Sign of dividend (+1 or -1)
//   R8 - Sign of divisor (+1 or -1)
// ================================================

// === Step 1: Division by Zero Check ===
@R1        // Load divisor
D=M
@DIV_BY_ZERO
D;JEQ      // If R1 == 0, jump to error handler

// === Step 2: Record signs ===
// Save sign of R0 (dividend) in R7
@R0
D=M
@DIVIDEND_POS
D;JGE
@R7
M=-1       // Negative dividend
@AFTER_SIGN0
0;JMP
(DIVIDEND_POS)
@R7
M=1        // Positive or zero dividend
(AFTER_SIGN0)

// Save sign of R1 (divisor) in R8
@R1
D=M
@DIVISOR_POS
D;JGE
@R8
M=-1       // Negative divisor
@AFTER_SIGN1
0;JMP
(DIVISOR_POS)
@R8
M=1        // Positive or zero divisor
(AFTER_SIGN1)

// === Step 3: Get absolute values ===
// |dividend| -> R5
@R0
D=M
@DIV_ABS
D;JGE
D=-D
(DIV_ABS)
@R5
M=D

// |divisor| -> R6
@R1
D=M
@DIVISOR_ABS
D;JGE
D=-D
(DIVISOR_ABS)
@R6
M=D

// === Step 4: Initialize result registers ===
@R2
M=0        // Quotient
@R3
M=0        // Remainder
@R4
M=0        // Error flag = 0 (assume no error)

// === Step 5: Set initial remainder to dividend ===
@R5
D=M
@R3
M=D        // R3 = absolute dividend

// === Step 6: Perform repeated subtraction (dividend / divisor) ===
(DIV_LOOP)
@R3
D=M
@R6
D=D-M      // remainder - divisor
@AFTER_DIV
D;JLT      // If result < 0, we're done

// Update remainder and increment quotient
@R3
M=D
@R2
M=M+1
@DIV_LOOP
0;JMP

(AFTER_DIV)
// === Step 7: Adjust quotient sign ===
// If R7 (dividend sign) != R8 (divisor sign), negate the quotient
@R7
D=M
@R8
D=D-M
@SKIP_NEG_QUO
D;JEQ
@R2
D=M
D=-D
@R2
M=D
(SKIP_NEG_QUO)

// === Step 8: Adjust remainder sign ===
// The remainder takes the same sign as the dividend
@R7
D=M
@REM_POS
D;JGT
@R3
D=M
D=-D
@R3
M=D
(REM_POS)

// === Step 9: Jump to END ===
@END
0;JMP

// === Error handler for division by zero ===
(DIV_BY_ZERO)
@R4
M=1        // Set error flag
@END
0;JMP

// === Final infinite loop ===
(END)
@END
0;JMP
