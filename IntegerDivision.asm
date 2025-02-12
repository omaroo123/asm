// IntegerDivision.asm
// Compute integer division: R0 / R1
// R0 = Dividend (x)
// R1 = Divisor (y)
// R2 = Quotient (m)
// R3 = Remainder (q)
// R4 = Flag (1 if invalid, 0 otherwise)

@R1
D=M
@DIV_BY_ZERO
D;JEQ   // If divisor (y) is 0, handle error

// Initialize quotient and remainder
@R2
M=0
@R3
M=0

// Store sign of result
@R0
D=M
@NEGATIVE_X
D;JLT   // If dividend (x) < 0, jump to NEGATIVE_X

@R1
D=M
@NEGATIVE_Y
D;JLT   // If divisor (y) < 0, jump to NEGATIVE_Y

// Copy dividend into remainder
@R0
D=M
@R3
M=D

(LOOP)
@R3
D=M
@R1
D=D-M
@DONE
D;LT   // Stop if remainder < divisor

@R3
M=D   // Store new remainder

@R2
M=M+1  // Increment quotient

@LOOP
0;JMP

(DONE)
@R4
M=0  // Set valid division flag

// Restore sign for quotient if needed
@R5
D=M
@NEGATE_QUOTIENT
D;JEQ   // If sign flag was set, negate quotient

@END
0;JMP

(NEGATE_QUOTIENT)
@R2
M=-M
@END
0;JMP

// Handle division by zero
(DIV_BY_ZERO)
@R4
M=1   // Set invalid flag
@END
0;JMP

// Handle negative x (dividend)
(NEGATIVE_X)
@R0
D=M
D=-D
@R3
M=D  // Make remainder positive
@R5
M=1  // Set sign flag
@LOOP
0;JMP

// Handle negative y (divisor)
(NEGATIVE_Y)
@R1
D=M
D=-D
@R1
M=D  // Make divisor positive
@R5
M=1  // Set sign flag
@LOOP
0;JMP

(END)
@END
0;JMP  // Infinite loop

