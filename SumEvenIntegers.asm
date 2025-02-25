// SumEvenIntegers.asm
// Computes the sum of all even integers from 0 up to N (inclusive),
// where N is stored in R0.
// R0 is not modified and the final sum is stored in R1.
// If N is negative, the sum is set to 0.

    @R0
    D=M
    @NEGATIVE
    D;JLT         // if N < 0, jump to NEGATIVE

    // N is nonnegative; copy N into R2
    @R0
    D=M
    @R2
    M=D

    // Initialize sum in R1 to 0 and index (current even number) in R3 to 0
    @R1
    M=0
    @R3
    M=0

(LOOP_EVEN)
    // Check if current even number (in R3) is greater than N (in R2)
    @R3
    D=M       // D = i
    @R2
    D=D-M     // D = i - N
    @END_EVEN
    D;JGT     // if i > N, exit loop

    // Add current even number (R3) to sum (R1)
    @R1
    D=M
    @R3
    D=D+M
    @R1
    M=D

    // Increment index by 2: R3 = R3 + 2
    @R3
    D=M
    @CONST2
    D=D+A   // A currently holds constant 2 from the next instruction
    @R3
    M=D

    @LOOP_EVEN
    0;JMP

(END_EVEN)
    @FINAL
    0;JMP

(NEGATIVE)
    // For negative N, set sum to 0.
    @R1
    M=0
    @FINAL
    0;JMP

(FINAL)
    @FINAL
    0;JMP

(CONST2)
    @2
    D=A
