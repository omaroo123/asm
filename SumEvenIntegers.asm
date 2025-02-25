// SumEvenIntegers.asm
// Computes the sum of the first N positive even integers.
// Input: R0 = N (if N <= 0, sum = 0)
// Output: R1 = sum (R0 is not modified)
// Algorithm: For counter = N, with current even number starting at 2,
//   repeatedly add the current even to the sum, increment the even by 2, and decrement the counter.

    @R0
    D=M
    @NEG_CHECK
    D;JLE         // if R0 <= 0, go to NEG_CHECK

    // Copy N into R2 as the loop counter.
    @R0
    D=M
    @R2
    M=D

    // Initialize sum in R1 to 0.
    @R1
    M=0

    // Initialize current even number in R3 to 2.
    @2
    D=A
    @R3
    M=D

(SUM_LOOP)
    @R2
    D=M
    @SUM_END
    D;JEQ        // if counter is 0, exit loop
    // Add current even (in R3) to sum (R1):
    @R1
    D=M
    @R3
    D=D+M
    @R1
    M=D
    // Increment current even: R3 = R3 + 2
    @R3
    D=M
    @2
    D=D+A
    @R3
    M=D
    // Decrement counter: R2 = R2 - 1
    @R2
    D=M
    D=D-1
    @R2
    M=D
    @SUM_LOOP
    0;JMP
(SUM_END)
    @END
    0;JMP

(NEG_CHECK)
    @R1
    M=0
    @END
    0;JMP

(END)
    @END
    0;JMP
