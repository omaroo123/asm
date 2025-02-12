
    @R1         
    D=M          
    @DIV_BY_ZERO  
    D;JEQ         

    
    @R0          
    D=M          
    @R1          
    MD=D/M        

    
    @R2
    M=D           
    @R3
    M=M           

    
    @R4
    M=0           
    @END
    0;JMP

DIV_BY_ZERO:  
    @R4
    M=1           
    
END:
    
