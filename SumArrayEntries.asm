// SumArrayEntries.asm
// Compute sum of all elements in an array
// R0 = Base address of array
// R1 = Number of elements
// R2 = Final sum

@R1
D=M
@NO_ELEMENTS
D;JLE   // If number of elements ≤ 0, sum = 0

@R2
M=0     // Initialize sum to 0

@R3
M=0     // Initialize index counter

(LOOP)
@R3
D=M
@R1
D=D-M
@END
D;JGE   // If index >= R1, exit loop

// Load array value
@R3
D=M
@R0
A=M+D   // Access memory at R0 + index
D=M     // Get array value

// Add value to sum
@R2
M=M+D

// Increment index
@R3
M=M+1

@LOOP
0;JMP   // Repeat loop

(NO_ELEMENTS)
@R2
M=0     // If no elements, sum = 0

(END)
@END
0;JMP   // Infinite loop
