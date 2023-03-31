.MODEL SMALL         
.STACK 100H
.DATA 
    INMSG DB "Enter a number between 0 to 3 : $"
    OUTMSG DB "The Series Summation = $"
    N DB ?
    D DB 2

.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        ;;Input Message
        LEA DX,INMSG 
        MOV AH,9
        INT 21H
        
        ;;Taking the input
        MOV AH,1
        INT 21H
        
        ;;Manipulation
        SUB AL,48
        MOV N,AL
        INC N
        MUL N
        DIV D
        MOV N,AL
        
        OUTPUT:
            CALL NEW_LINE
            
            ;;Output Message
            LEA DX,OUTMSG
            MOV AH,9
            INT 21H
            
            ;;Summation Printing
            MOV DL,N
            ADD DL,48 
            MOV AH,2
            INT 21H
            
            JMP EXIT
            
            
            
   MAIN ENDP
            
   NEW_LINE PROC
            
           MOV DL,10
           MOV AH,2
           INT 21H
           MOV DL,13
           INT 21H 
           RET
           
        Exit:
           MOV AH,4CH
           INT 21H 
           
            
             
            
            
            
            
            
        
        
        
        