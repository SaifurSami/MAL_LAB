.MODEL SMALL
.STACK 100H
.DATA
    INMSG DB "Enter a Number between 0 to 3 = $" 
    OUTMSG DB "Factorial = $"
    N DB ?
    A DB ?
    ARR DB 100 DUP("$")
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        ;Input Message
        LEA DX,INMSG
        MOV AH,9
        INT 21H
        
        ;Taking Input
        MOV AH,1
        INT 21H
        
        ;Manipulation
        SUB AL,48
        MOV N,AL
        MOV A,AL
        ;DEC N
        
        OUTPUT:
            ;Printing New Line
            CALL NEW_LINE
            
            ;Output Message
            LEA DX,OUTMSG
            MOV AH,9
            INT 21H
            
            MOV AL,A
            FACTORIAL:
                CMP N,1
                JE  PRINT_FACTORIAL
                CMP N,0
                JE PRINT_FACTORIAL
                DEC N
                MUL N
                MOV A,AL
                
                JMP FACTORIAL
            
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
        
        PRINT_FACTORIAL:
            MOV DL,A
            ADD DL,48
            MOV AH,2
            INT 21H
            
            JMP EXIT
         