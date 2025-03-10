/ ----- First: Check for division by zero ----- 
   @R1           // Load divisor
   D=M
   @INVALID_DIV // If R1==0, jump to error routine
   D;JEQ

// ----- Save sign flags for R1 and R0 ----- 
// For divisor: store +1 if positive, -1 if negative in R8.
   @R1
   D=M
   @DIV1_POS
   D;JGE       // If R1>=0, jump to DIV1_POS
   @R8
   M=-1       // R1 was negative; flag = -1
   @SKIP_DIV_SIGN1
   0;JMP
(DIV1_POS)
   @R8
   M=1        // R1 was nonnegative; flag = +1
(SKIP_DIV_SIGN1)

// For dividend: store +1 if positive, -1 if negative in R7.
   @R0
   D=M
   @DIV0_POS
   D;JGE       // If R0>=0, jump to DIV0_POS
   @R7
   M=-1      // R0 was negative; flag = -1
   @SKIP_DIV_SIGN0
   0;JMP
(DIV0_POS)
   @R7
   M=1       // R0 was nonnegative; flag = +1
(SKIP_DIV_SIGN0)
// ----- Compute absolute values for R1 and R0 ----- 
// Get |R1| into R6
   @R1
   D=M
   @ABS_R1
   D;JGE      // If R1 is nonnegative, skip negation
   @R1
   D=M
   D=-D      // Otherwise, negate it
(ABS_R1)
   @R6
   M=D      // R6 now holds the absolute value of R1

// Get |R0| into R5
   @R0
   D=M
   @ABS_R0
   D;JGE      // If R0 is nonnegative, skip negation
   @R0
   D=M
   D=-D      // Otherwise, negate it
(ABS_R0)
   @R5
   M=D      // R5 now holds the absolute value of R0

// ----- Initialize quotient and error flag ----- 
   @R4
   M=0      // R4 = 0 (no error)
   @R2
   M=0      // R2 will hold the quotient

// Copy the absolute dividend from R5 into R3 (the running remainder)
   @R5
   D=M
   @R3
   M=D
// ----- Compute absolute values for R1 and R0 ----- 
// Get |R1| into R6
   @R1
   D=M
   @ABS_R1
   D;JGE      // If R1 is nonnegative, skip negation
   @R1
   D=M
   D=-D      // Otherwise, negate it
(ABS_R1)
   @R6
   M=D      // R6 now holds the absolute value of R1

// Get |R0| into R5
   @R0
   D=M
   @ABS_R0
   D;JGE      // If R0 is nonnegative, skip negation
   @R0
   D=M
   D=-D      // Otherwise, negate it
(ABS_R0)
   @R5
   M=D      // R5 now holds the absolute value of R0

// ----- Initialize quotient and error flag ----- 
   @R4
   M=0      // R4 = 0 (no error)
   @R2
   M=0      // R2 will hold the quotient

// Copy the absolute dividend from R5 into R3 (the running remainder)
   @R5
   D=M
   @R3
   M=D
@R3
   M=D
(REMAINDER_POS)
   @END
   0;JMP

// ----- Error Routine: Division by zero ----- 
(INVALID_DIV)
   @R4
   M=1      // Set error flag to 1 to indicate invalid division
   @END
   0;JMP

// ----- End: Infinite loop ----- 
(END)
   @END
   0;JMP
