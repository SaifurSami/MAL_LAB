.MODEL SMALL
.STACK 100H
.DATA
    INMSG DB "Enter a Number between 0 to 9 : $"
    OUTMSG DB "The Number is $"
    MSG1 DB "Even$"
    MSG2 DB "Odd$"
    D DB 2
    
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
        
        ;;Checking Even 
        TEST AL,1
        JZ EVEN
        
        ODD:
           CALL NEW_LINE
           
           ;;Output Message
           LEA DX,OUTMSG
           MOV AH,9
           INT 21H
           LEA DX,MSG2 
           MOV AH,9
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
            
        EXIT:
            MOV AH,4CH
            INT 21H
        
        EVEN:
            CALL NEW_LINE
            
            ;;Output Message
           LEA DX,OUTMSG
           MOV AH,9
           INT 21H
           LEA DX,MSG1
           MOV AH,9
           INT 21H
           
           JMP EXIT
           
       NEW_LINE ENDP
            