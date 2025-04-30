// ================================================
// Student-Made Hack Assembly Program
// Array Summation in Memory
// ------------------------------------------------
// Inputs:
//   R0 - Base address of the array (starting point)
//   R1 - Number of elements in the array
//
// Outputs:
//   R2 - Sum of array elements
//
// Temporary Registers:
//   R7 - Remaining elements counter (loop control)
//   R8 - Pointer to current array element
// ================================================

// === Step 1: Initialize registers ===
@R2
M=0            // R2 will store the final sum, start at 0

@R0
D=M
@R8
M=D            // R8 = base address of array (pointer)

@R1
D=M
@R7
M=D            // R7 = number of elements remaining

// === Step 2: Loop through the array ===
(SUM_LOOP)
@R7
D=M
@END_SUM
D;JLE          // If no more elements, exit loop

// Load current value from array
@R8
A=M
D=M            // D = array[R8]

// Add value to sum
@R2
M=M+D

// Move pointer to next array element
@R8
M=M+1

// Decrement counter
@R7
M=M-1

// Repeat loop
@SUM_LOOP
0;JMP

// === Step 3: End (infinite loop) ===
(END_SUM)
@END_SUM
0;JMP
