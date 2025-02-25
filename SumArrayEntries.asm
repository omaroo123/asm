// SumArrayEntries.asm
// Computes the sum of all entries in an array.
// The starting memory address of the array is in R0 and the number of elements is in R1.
// The sum is stored in R2.
// R0 and R1 must remain unchanged.
// If R1 is not positive, the sum is set to 0.
// Temporary registers used:
//   R3 = pointer to current array element,
//   R4 = copy of the number of entries (loop counter).

    // --- Check if the number of elements (R1) is positive ---
    @R1
    D=M
    @SUM_LOOP
    D;JGT      // if R1 > 0, jump to the summing loop
    // Otherwise, set sum to 0.
    @R2
    M=0
    @END_SUM
    0;JMP

(SUM_LOOP)
    // Copy the starting address from R0 into R3.
    @R0
    D=M
    @R3
    M=D      // R3 <- pointer to array
    // Copy the number of entries from R1 into R4.
    @R1
    D=M
    @R4
    M=D      // R4 <- loop counter
    // Initialize sum in R2 to 0.
    @R2
    M=0

(LOOP_START)
    // If counter (R4) is 0, the loop is finished.
    @R4
    D=M
    @LOOP_END
    D;JEQ

    // Load the current array entry.
    @R3
    A=M      // set A to the address stored in R3
    D=M      // D <- *R3
    // Add the current value to sum (R2).
    @R2
    D=M+D
    @R2
    M=D

    // --- Increment the pointer (R3 = R3 + 1) ---
    @R3
    D=M
    D=D+1
    @R3
    M=D

    // --- Decrement the counter (R4 = R4 - 1) ---
    @R4
    D=M
    D=D-1
    @R4
    M=D

    @LOOP_START
    0;JMP

(LOOP_END)
(END_SUM)
    // Infinite loop to end the program.
    @END_SUM
    0;JMP

