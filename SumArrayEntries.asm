// SumArrayEntries.asm

    // Check if the number of entries is positive
    @R1
    D=M           // D = number of entries
    @END_CHECK
    D;JLE         // Jump to END_CHECK if R1 <= 0 (invalid array size)

    // Initialize the sum (R2) to 0
    @R2
    M=0           // Set sum to 0

    // Initialize the loop counter (R3) to 0 (it will count the number of iterations)
    @R3
    M=0           // Loop counter

LOOP_START:     
    @R3
    D=M           // D = current counter value
    @R1
    D=D-A         // D = R3 - R1
    @LOOP_END
    D;JGE         // If D >= 0, exit the loop (counter >= number of elements)

    // Access the current array entry (R0 + R3)
    @R0
    D=M           // D = base address (start of array)
    @R3
    A=D+A         // A = address of the current element (R0 + R3)
    D=M           // D = current array entry value

    // Add the current entry to the sum (R2)
    @R2
    M=M+D         // R2 = R2 + D (add current entry value to sum)

    // Increment the counter (R3) to process the next element
    @R3
    M=M+1         // Increment counter

    @LOOP_START    // Go back to the start of the loop

LOOP_END:
    // If we exit the loop, store the sum in R2 (it's already done above)
    
END_CHECK:
    // If R1 <= 0, the sum should already be 0 in R2, no further action needed
    // End of program
