@R2   // THIS WILL STORE THE SUM 
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