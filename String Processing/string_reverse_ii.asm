.MODEL SMALL
.STACK 100H
.DATA
    NEWLINE DB 10,13,'$'
    MSG1 DB "Input String : $"
    MSG2 DB "Output String : $"
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        ;;Input Message 
        MOV AH,9
        LEA DX,MSG1
        INT 21H
        
        MOV CX,0
        
        INPUT:
            MOV AH,1
            INT 21H
            
            CMP AL,13
            JZ END_INPUT
            
            PUSH AX
            INC CX
            
            JMP INPUT
            
            END_INPUT:  
                LEA DX,NEWLINE
                MOV AH,9
                INT 21H
                
                LEA DX,MSG2
                INT 21H
                
                JCXZ EXIT
            
            OUTPUT:
                POP DX
                MOV AH,2
                INT 21H
                
                LOOP OUTPUT
                
                EXIT:
                    MOV AH,4CH
                    INT 21H
                    
      MAIN ENDP
            
            