# Creating the second assembly file (Summation.asm)
summation_code = """@R2   // THIS WILL STORE THE SUM 
M = 0 

@R0     
D = M 

@R8     // changeable value that stores the value at R0 to access the items of our array 
M = D 

@R1 
D = M 

@R7    // changeable value that stores the number of values in our array 
M = D 

(LOOP)
    @R8
    D = M 

    @R2
    M = M + D 

    @R8
    M = M + 1 
    
    @R7
    D=M     
    D=D-1   
    M=D 

    @END_LOOP 
    D;JLE

    @LOOP

(END_LOOP)
@END_LOOP
0;JMP
"""

# Save the files
division_filename = "/mnt/data/Division.asm"
summation_filename = "/mnt/data/Summation.asm"

with open(division_filename, "w") as f:
    f.write(division_code)

with open(summation_filename, "w") as f:
    f.write(summation_code)

# Provide the download links
division_filename, summation_filename
