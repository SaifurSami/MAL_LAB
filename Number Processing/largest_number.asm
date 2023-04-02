.MODEL SMALL
.STACK 100H
.DATA
    INMSG DB "Enter the Array of Integers : $"
    OUTMSG DB "The Largest Number is $"
    ARR DB 100 DUP('$')
    T DB 0
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        ;;Input Message
        LEA DX,INMSG
        MOV AH,9
        INT 21H
        
        MOV SI,0
        MOV BL,0
        ;;Taking the Array
        INPUT:
           MOV AH,1
           INT 21H
           
           CMP AL,13
           JZ OUTPUT
           
           SUB AL,48
           MOV ARR[SI],AL
           INC SI
           
           JMP INPUT
        
        ;;Comparing & Updating 
        OUTPUT:
           DEC SI
           CMP SI,0
           JL LARGEST
           
           CMP ARR[SI],BL
           JG UPDATE_LARGEST
           
           JMP OUTPUT
        
        UPDATE_LARGEST:
            MOV BL,ARR[SI]
            JMP OUTPUT
        ;;Printing The Largest
        LARGEST:
            CALL NEW_LINE
            
            LEA DX,OUTMSG
            MOV AH,9
            INT 21H
            
            MOV DL,BL
            ADD DL,48
            MOV AH,2
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