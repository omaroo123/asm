// Square.asm
// Computes the square of the integer in R0 and stores it in R1.
// R0 remains unchanged.
// The square is computed by adding |R0| to itself |R0| times.
// Temporaries used:
//   R2: loop counter, R3: holds |R0|

    // --- Compute absolute value of R0 into R3 ---
    @R0
    D=M
    @POS_SQUARE
    D;JGE      // if R0 >= 0, jump to POS_SQUARE
    // R0 is negative: |R0| = 0 - R0
    @R0
    D=M
    D=0-D
    @R3
    M=D
    @AFTER_ABS_SQUARE
    0;JMP
(POS_SQUARE)
    @R0
    D=M
    @R3
    M=D
(AFTER_ABS_SQUARE)

    // --- Set loop counter R2 = |R0| ---
    @R3
    D=M
    @R2
    M=D

    // --- Initialize result in R1 to 0 ---
    @R1
    M=0

    // --- Loop: add R3 (|R0|) to R1, decrement counter in R2 ---
(LOOP_SQUARE)
    @R2
    D=M
    @END_SQUARE
    D;JEQ      // if counter == 0, we are done
    @R1
    D=M
    @R3
    D=D+M    // add |R0|
    @R1
    M=D
    @R2
    M=M-1    // decrement loop counter
    @LOOP_SQUARE
    0;JMP
(END_SQUARE)
    @END_SQUARE
    0;JMP
