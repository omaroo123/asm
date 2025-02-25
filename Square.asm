// Square.asm
// Input: R0 (signed integer)
// Output: R1 = (R0)²
// R0 must not be modified.
// Temporaries: R2 (loop counter), R3 (absolute value of R0)

// -- Compute absolute value of R0 and store in R3 --
    @R0
    D=M
    @POSITIVE
    D;JGE      // if R0 >= 0, jump to POSITIVE
    // R0 is negative: compute |R0| = 0 - R0
    @R0
    D=M
    D=0-D
    @R3
    M=D
    @AFTER_ABS
    0;JMP
(POSITIVE)
    @R0
    D=M
    @R3
    M=D
(AFTER_ABS)

// -- Copy absolute value into loop counter R2 --
    @R3
    D=M
    @R2
    M=D

// -- Initialize result in R1 to 0 --
    @R1
    M=0

// -- Loop: add R3 (|R0|) to R1, decrement counter R2 --
(LOOP_SQUARE)
    @R2
    D=M
    @END_SQUARE
    D;JEQ      // if counter == 0, done
    // Add |R0| (in R3) to current sum in R1:
    @R1
    D=M
    @R3
    D=D+M
    @R1
    M=D
    // Decrement loop counter (R2 = R2 - 1)
    @R2
    M=M-1
    @LOOP_SQUARE
    0;JMP
(END_SQUARE)
    @END_SQUARE
    0;JMP
