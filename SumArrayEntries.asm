// Initialize sum to 0
@R2
M=0

// Check if R1 (number of entries) is positive
@R1
D=M
@ARRAY_SUM_END
D;JLE  // If number of entries <= 0, jump to end

// Initialize index i to 0
@I
M=0   // Use R3 as I

// Sum loop
(SUM_LOOP)
@I
D=M
@R1
D=D-A // Compare index with number of elements
@ARRAY_SUM_END
D;JGE // If index >= number of entries, jump to end

// Add array element to sum
@R0
D=M
@I
A=D+A // Address of the current element
D=M   // Load current element
@R2
M=D+M // Add to sum

// Increment index
@I
M=M+1
@SUM_LOOP
0;JMP // Jump back to start of loop

(ARRAY_SUM_END)

