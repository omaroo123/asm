// IntegerDivision.asm
// Computes integer division: R0 / R1
// R0 = Dividend (x)
// R1 = Divisor (y)
// R2 = Quotient (m)
// R3 = Remainder (q)
// R4 = Flag (1 if division invalid, 0 otherwise)

@R1
D=M
@DIV_BY_ZERO
D;JEQ   // If divisor (y) is 0, go to error handling

// Initialize quotient and remainder
@R2
M=0
@R3
M=0

// Store dividend in remainder (for subtraction)
@R0
D=M
@R3
M=D

// Track sign flag for quotient correction at the end
@R5
M=0    // Default: positive quotient

// Handle negative dividend
@R0
D=M
@MAKE_POSITIVE_X
D;JLT   // If x < 0, make it positive

// Handle negative divisor
@R1
D=M
@MAKE_POSITIVE_Y
D;JLT   // If y < 0, make it positive

// Perform division using subtraction
(DIV_LOOP)
@R3
D=M
@R1
D=D-M
@CHECK_DONE
D;LT   // Stop if remainder < divisor

@R3
M=D   // Store new remainder

@R2
M=M+1  // Increment quotient

@DIV_LOOP
0;JMP  // Repeat division loop

(CHECK_DONE)
@R4
M=0   // Valid division flag

// Restore sign for quotient if necessary
@R5
D=M
@NEGATE_QUOTIENT
D;JEQ  // If sign flag was set, negate quotient

@END
0;JMP

(NEGATE_QUOTIENT)
@R2
M=-M
@END
0;JMP

// Make x (dividend) positive
(MAKE_POSITIVE_X)
@R0
D=M
D=-D
@R3
M=D   // Store positive remainder
@R5
M=1   // Track that we need to negate quotient later
@DIV_LOOP
0;JMP

// Make y (divisor) positive
(MAKE_POSITIVE_Y)
@R1
D=M
D=-D
@R1
M=D   // Store positive divisor
@R5
M=1   // Track that we need to negate quotient later
@DIV_LOOP
0;JMP

// Handle division by zero case
(DIV_BY_ZERO)
@R4
M=1   // Set invalid division flag
@END
0;JMP

(END)
@END
0;JMP  // Infinite loop to halt execution


