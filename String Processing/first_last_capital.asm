.MODEL SMALL
.STACK 100H
.DATA
    NEWLINE DB 10,13,'$'
    INMSG DB "Enter the String : $"
    MSG1 DB "The First Capital is $"
    MSG2 DB "The Last Capital is $"
    MSG3 DB "No Capital Letter$"
    
    FLAG DB 0
    SMALL DB 'A'
    BIG DB 'Z'
    STR DB 100 DUP('$')
    
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        ;;Input Message
        LEA DX,INMSG
        MOV AH,9
        INT 21H
        
        MOV SI,0
        
        ;;Taking Input
        INPUT:
            MOV AH,1
            INT 21H
            
            ;;Untill Enter key
            CMP AL,13
            JZ END_INPUT
            
            MOV STR+SI,AL
            INC SI
            
            JMP INPUT
        
        END_INPUT:
            LEA DX,NEWLINE
            MOV AH,9
            INT 21H
            
            MOV SI,0
            
        CHECK:
            CMP STR+SI,'$'
            JZ RESULT
            
            CMP STR+SI,'A'
            JGE LESS_Z
            
            INC SI
            
            JMP CHECK 
        
        LESS_Z:
            CMP STR+SI,'Z'
            JLE F_CHECK
            
            INC SI
            
            JMP CHECK    
        
        F_CHECK:
            MOV BL,STR+SI
            INC SI
            
            CMP BL,SMALL
            JGE UPDATE_FIRST
        
        L_CHECK:    
            CMP BL,BIG
            JLE UPDATE_LAST
            
            JMP CHECK
        
        UPDATE_FIRST:
            MOV SMALL,BL
            MOV FLAG,1
            JMP L_CHECK    
        
        UPDATE_LAST:
            MOV BIG,BL
            MOV FLAG,1
            JMP CHECK
        
        RESULT:
            ;;flg=0 means no capital is found
            CMP FLAG,0
            JZ NO_CAPITAL
            
            LEA DX,MSG1
            MOV AH,9
            INT 21H
            
            ;;First Capital
            MOV DL,BIG
            MOV AH,2
            INT 21H
            
            LEA DX,NEWLINE
            MOV AH,9
            INT 21H
            
            LEA DX,MSG2
            INT 21H
            
            ;;Last Capital
            MOV DL,SMALL
            MOV AH,2
            INT 21H
            
            JMP EXIT
        
        NO_CAPITAL:
            LEA DX,MSG3
            MOV AH,9
            INT 21H
            
            JMP EXIT
            
        EXIT:
            MOV AH,4CH
            INT 21H    
        
        MAIN ENDP    