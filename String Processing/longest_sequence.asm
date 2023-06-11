.MODEL SMALL
.STACK 100H
.DATA  
    NEWLINE DB 10,13,'$'
    MSG1 DB "Input String : $"
    MSG2 DB "Longest Sequence : $"
    STR DB 100 DUP('$')   
    MAX DB 0
    IND DW 0  
    CNT DB 0
    SEQ DB 0
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        LEA DX,MSG1
        MOV AH,9
        INT 21H  
        
        MOV SI,0
        MOV AL,0
        
        INPUT:
            MOV AH,1
            INT 21H
            MOV BL,AL
            
            CMP AL,13
            JZ GO
            
            
            MOV STR+SI,BL
            INC SI
            
            JMP INPUT 
       
        GO:    
            MOV SI,0 
            MOV DI,0
            
        CHECK:
            MOV MAX,1
            MOV CNT,1
            MOV DI,SI
            
            CMP STR+SI,'$'
            JE  OUTPUT
                
            SEQUENCE:
                MOV BL,STR+DI
                CMP BL,STR+DI+1
                JG UPDATE
                
                INC DI
                INC CNT
                MOV DH,CNT 
                
                JMP SEQUENCE
                
                UPDATE:
                    MOV CL,SEQ
                    CMP CL,CNT
                    JGE NOUPDATE
                    
                    MOV AL,CNT
                    MOV SEQ,AL
                    
                    MOV IND,SI
                    
                    INC SI
                    
                    JMP CHECK
                    
                    NOUPDATE:
                        INC SI
                        
                        JMP CHECK
            
        OUTPUT:
            MOV BL,0
            
            LEA DX,NEWLINE
            MOV AH,9
            INT 21H 
            
            LEA DX,MSG2
            MOV AH,9
            INT 21H 
            
            MOV SI,IND
            
            LONGEST:
                CMP SEQ,0
                JZ EXIT
                
                
                MOV DL,STR+SI
                MOV AH,2
                INT 21H 
                
                DEC SEQ
                INC SI
                
                JMP LONGEST
                
                EXIT:
                    MOV AH,4CH
                    INT 21H
                    
         MAIN ENDP
            
                 
            
            
            
            
            
        
        