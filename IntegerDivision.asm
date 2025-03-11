// ----- First: Check for division by zero ----- 
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

// ----- Division Loop: Repeated subtraction ----- 
(LOOP)
   @R3
   D=M        // Load current remainder
   @R6
   D=D-M      // Compute (remainder - divisor)
   @END_LOOP
   D;JLT      // If (remainder - divisor) is negative, exit loop
   @R3
   M=D        // Update remainder with new value
   @R2
   M=M+1      // Increment quotient
   @LOOP
   0;JMP

(END_LOOP)
// ----- Adjust result signs ----- 
// The true quotient should be negative if the dividend and divisor have opposite signs.
// (Since both R2 and R3 are currently absolute values, we check the sign flags in R7 and R8.)
   @R7
   D=M        // D = dividend sign (+1 or -1)
   @R8
   D=D-M     // D = (dividend sign - divisor sign); if zero, they are the same.
   @SIGN_CORRECT
   D;JEQ      // If D==0 then the signs were the same; no change needed.
   // Otherwise, the signs differ so negate the quotient.
   @R2
   D=M
   D=-D
   @R2
   M=D
(SIGN_CORRECT)
// Also, the remainder should have the same sign as the dividend.
   @R7
   D=M
   @REMAINDER_POS
   D;JGT     // If dividend was positive, leave remainder as is.
   // Else (dividend negative), negate the remainder.
   @R3
   D=M
   D=-D
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