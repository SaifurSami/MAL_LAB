.MODEL SMALL
.STACK 100H
.DATA
    INMSG DB "Enter the Number (0-9) = $"
    OUTMSG1 DB "The Number is Prime$"
    OUTMSG2 DB "The Number is Not Prime$"
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        ;;Input Message
        LEA DX,INMSG
        MOV AH,9
        INT 21H
        
        ;;Taking Input
        MOV AH,1
        INT 21H
        
        SUB AL,48
        
        CMP AL,0
        JZ  NOT_PRIME
         
        CMP AL,1
        JZ  NOT_PRIME
        
        CMP AL,2
        JZ  PRIME
        
        MOV BL,AL
        MOV CL,AL 
        DEC CL
        
        CHECK:
          MOV AH,0
          DIV CL
          MOV AL,BL
          
          CMP AH,0
          JZ NOT_PRIME
          
          CMP CL,2
          JZ  PRIME
          
          LOOP CHECK
          
        NOT_PRIME:
            CALL NEW_LINE
            
            LEA DX,OUTMSG2
            MOV AH,9
            INT 21H
            
            JMP EXIT
        
        PRIME:
            CALL NEW_LINE
            
            LEA DX,OUTMSG1
            MOV AH,9
            INT 21H
            
            JMP EXIT
            
       EXIT:
         MOV AH,4CH
         INT 21H
         
   MAIN ENDP
    
       NEW_LINE PROC
            MOV DL,10
            MOV AH,2
            INT 21H
            
            MOV DL,13
            INT 21H
            RET
            
   NEW_LINE ENDP     