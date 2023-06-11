.MODEL SMALL
.STACK 100H
.DATA 
    NEWLINE DB 10,13,'$'
    MSG1 DB "ENTER THE FIRST STRING : $"
    MSG2 DB "ENTER THE SECOND STRING : $"
    SUBSEQUENT DB "A SUBSEQUENT $"
    NOTSUBSEQUENT DB "NOT A SUBSEQUENT $"
    STR1 DB 100 DUP('$'}
    STR2 DB 100 DUP('$')
    TEMP DW 0
    FLG DB 0
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        MOV SI,0
        MOV DI,0
        
        LEA DX,MSG1
        MOV AH,9
        INT 21H
         
        INPUT1:
            MOV AH,1
            INT 21H
            MOV BL,AL
            
            CMP AL,13
            JZ SECOND
            
            MOV STR1+SI,BL
            INC SI
            JMP INPUT1
            
        SECOND:    
            CALL NEW
        
            LEA DX,MSG2
            INT 21H
            
            MOV SI,0
            MOV DI,0
            MOV AL,0
            
            INPUT2:
                MOV AH,1
                INT 21H
                MOV BL,AL
                
                CMP AL,13
                JZ GO
                
                MOV STR2+SI,BL
                INC SI
                JMP INPUT2
        GO:
            MOV SI,0
            MOV DI,0    
            MOV BL,STR2
                
        CHECK:
            CMP STR1+SI,'$'
            JZ RESULT
            
            CMP STR1+SI,BL
            CALL SEARCH
            
            INC SI
            JMP CHECK
                
        SEARCH PROC
            MOV DI,0
            MOV TEMP,SI
            
            LOOK:
                CMP STR2+DI,'$'
                JZ DONE
                
                MOV AL,STR2+DI
                CMP AL,STR1+SI
                JNE SKIP
                
                INC DI
                INC SI
                JMP LOOK
                
                SKIP:
                    MOV SI,TEMP
                    MOV FLG,0
                    
                    RET
                    
                DONE:
                    MOV FLG,1
                    JMP RESULT
                
                RESULT:
                    CMP FLG,1
                    JZ YES
                    
                    LEA DX,NEWLINE
                    MOV AH,9
                    INT 21H
                    
                    LEA DX,NOTSUBSEQUENT
                    INT 21H
                    
                    JMP EXIT
                    
                YES:
                    LEA DX,NEWLINE
                    MOV AH,9
                    INT 21H
                    
                    LEA DX,SUBSEQUENT
                    MOV AH,9
                    INT 21H
                    
                EXIT:
                    MOV AH,4CH
                    INT 21H 
          NEW PROC
              LEA DX,NEWLINE
              MOV AH,9
              INT 21H 
              RET           
                    