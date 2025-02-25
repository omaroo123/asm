// SumEvenIntegers.asm
// Input:  R0 = N
// Output: R1 = sum of all even integers from 0 up to N (inclusive)
// R0 must not be modified.

@R0
D=M
@NEG_CHECK
D;JLT      // if N < 0, jump to NEG_CHECK

// N is nonnegative: copy N into R2
@R0
D=M
@R2
M=D

// Initialize sum in R1 to 0 and loop index in R3 to 0
@R1
M=0
@R3
M=0

(SUM_LOOP)
  // If index (R3) is greater than N (in R2), exit loop.
  @R3
  D=M
  @R2
  D=M-D    // D = N - index
  @SUM_END
  D;JLT    // if N - index < 0, then index > N
  // Add current even number (R3) to sum (R1)
  @R1
  D=M
  @R3
  D=D+M
  @R1
  M=D
  // Increment index by 2
  @2
  D=A
  @R3
  M=M+D
  @SUM_LOOP
  0;JMP
(SUM_END)
@END_SUM
0;JMP

(NEG_CHECK)
  // For negative N, set sum to 0.
  @R1
  M=0
@END_SUM
0;JMP

(END_SUM)
@END_SUM
0;JMP
