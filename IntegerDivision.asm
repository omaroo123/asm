// Check if y == 0 (division by zero scenario)
@R1
D=M
@DIVISION_BY_ZERO
D;JEQ  // Jump if y == 0

// Compute quotient (m) and remainder (q)
@R0
D=M   // Store x in D
@R1
D=D/M // D now holds the quotient
@R2
M=D   // Store quotient in R2

@R0
D=M   // Reload x
@R1
D=D%M // D now holds the remainder
@R3
M=D   // Store remainder in R3

@END
0;JMP // Jump to end

// Division by zero flag handling
(DIVISION_BY_ZERO)
@R4
M=1  // Set the invalid division flag
@R2
M=0  // Set quotient to 0
@R3
M=0  // Set remainder to 0

(END)
@R4
M=0  // Set the flag to valid division


