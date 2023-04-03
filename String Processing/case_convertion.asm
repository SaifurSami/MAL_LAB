.MODEL SMALL
.STACK 100H
.DATA 
    NEWLINE DB 10,13,'$'
    MSG1 DB "Input String : $"
    MSG2 DB "Output String : $"
    STR DB 100 DUP('$')
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        ;;Input Message
        LEA DX,MSG1
        MOV AH,9
        INT 21H
        
        MOV SI,0
        MOV DI,0
        INPUT:
            CMP AL,13
            JZ CHECK
            
            MOV AH,1
            INT 21H
            
            MOV STR+SI,AL
            INC SI
            
            JMP INPUT
        
        ;END_INPUT:
            
        CHECK:
            CMP STR+DI,'$'
            JZ OUTPUT
            
            CMP STR+DI,'A'
            JGE Z1_CHECK
            
            CMP STR+DI,'a'
            JGE z2_CHECK
            
            INC DI
            
            JMP CHECK
            
        Z1_CHECK:
            CMP STR+DI,'Z'
            JLE DO_SMALL
            
            CMP STR+DI,'a'
            JGE z2_CHECK
            
            INC DI
            
            JMP CHECK
            
        z2_CHECK:
            CMP STR+DI,'z'
            JLE DO_CAPITAL
            
            INC DI
            
            JMP CHECK
        
        DO_SMALL:
            ADD STR+DI,32
            
            INC DI
            
            JMP CHECK
                
        DO_CAPITAL:
            SUB STR+DI,32
            
            INC DI
            
            JMP CHECK
            
        OUTPUT:
            MOV SI,0
            
            ;;New Line
            LEA DX,NEWLINE
            MOV AH,9
            INT 21H 
            
            LEA DX,MSG2
            MOV AH,9
            INT 21H
                   
        STRING:
            CMP STR+SI,'$'
            JZ EXIT
            
            MOV DL,STR+SI
            MOV AH,2
            INT 21H
            
            INC SI
            
            JMP STRING
                
        EXIT:
            MOV AH,4CH
            INT 21H
        