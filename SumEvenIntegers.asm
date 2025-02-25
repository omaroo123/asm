// SumEvenIntegers.asm
// Computes the sum of all even integers from 0 up to N (inclusive),
// where N is stored in R0. The result is stored in R1.
// R0 must not be modified.
// Temporaries used:
//   R2: copy of N, R3: loop index (current even number)

// --- If N (R0) is negative, set sum to 0 and exit ---
    @R0
    D=M
    @NON_NEGATIVE
    D;JGE    // if R0 >= 0, continue
    @R1
    M=0
    @END_SUM
    0;JMP
(NON_NEGATIVE)

    // --- Copy N from R0 into R2 ---
    @R0
    D=M
    @R2
    M=D

    // --- Initialize result in R1 to 0 ---
    @R1
    M=0

    // --- Initialize loop index in R3 to 0 ---
    @R3
    M=0

(LOOP_SUM)
    // Check if current even number (R3) is greater than N (in R2)
    @R3
    D=M         // D = current even number
    @R2
    D=M-D       // D = N - (current even)
    @END_SUM
    D;JLT       // if (N - current even) < 0, then R3 > N → exit loop

    // Add current even number (R3) to sum (R1)
    @R1
    D=M
    @R3
    D=D+M
    @R1
    M=D

    // Increment R3 by 2 (to get the next even number)
    @2
    D=A
    @R3
    M=M+D

    @LOOP_SUM
    0;JMP
(END_SUM)
    @END_SUM
    0;JMP
