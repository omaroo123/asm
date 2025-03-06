// Check for division by zero and set flag
@R1
D=M
@INVALID_DIVISION
D;JEQ

// Initialize divisor and dividend
@R0
D=M
@X
M=D  // Store x in temporary variable X
@R1
D=M
@Y
M=D  // Store y in temporary variable Y

// Initialize quotient and remainder
@Q
M=0  // Quotient starts at 0
@R
M=D  // Remainder starts as x

// Division loop
(WHILE)
@R
D=M
@Y
D=D-M  // Calculate R - Y
@IF
D;JGE  // If remainder >= divisor, continue

// Set quotient and remainder
@Q
M=M+1  // Increment quotient
@R
M=D    // Update remainder with new value
@WHILE
0;JMP  // Loop back

(IF)
@Q
D=M
@R2
M=D  // Store quotient
@R
D=M
@R3
M=D  // Store remainder
@R4
M=0  // Set valid division flag
@END
0;JMP  // End program

// Handle invalid division case
(INVALID_DIVISION)
@R4
M=1  // Set error flag
@R2
M=0  // Zero quotient
@R3
M=0  // Zero remainder

(END)

