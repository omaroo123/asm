// Initialization
@R0
D=M
@X
M=D  // Store x in X
@R1
D=M
@Y
M=D  // Store y in Y
@R4
M=0  // Initialize division valid flag

// Check if y == 0 to handle division by zero
@Y
D=M
@INVALID_DIVISION
D;JEQ  // If Y is zero, set division as invalid

// Initialize quotient (m) and remainder (q)
@Q
M=0  // Quotient initialized to 0
@X
D=M
@R1
@Y
D=D-M // D now holds x - y initially

// Main division loop
(DIV_LOOP)
@X
D=M
@Y
M=D
D=D-M // Check if x >= y
@CONTINUE
D;JGE  // If x >= y, continue subtracting
@BREAK
0;JMP  // Else, stop the loop

// Subtract y from x, increment quotient
(CONTINUE)
@X
M=M-D
@Q
M=M+1  // Increment quotient
@DIV_LOOP
0;JMP  // Repeat the loop

// Finalize and store results
(BREAK)
@X
D=M
@R3
M=D  // Store remainder in R3
@Q
D=M
@R2
M=D  // Store quotient in R2
@END
0;JMP  // Jump to end

// Handle invalid division
(INVALID_DIVISION)
@R4
M=1  // Set invalid flag to 1
@R2
M=0  // Set quotient to 0
@R3
M=0  // Set remainder to 0

(END)
// No further action required


