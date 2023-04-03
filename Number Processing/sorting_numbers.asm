.MODEL SMALL
.STACK 100H
.DATA
    NEWLINE DB 10,13,'$'
    MSG1 DB "Enter The Numbers : $"
    MSG2 DB "Ascending : $"
    MSG3 DB "Dscending : $"
    STR DB 100 DUP('$')
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        ;MOV BL,1 
        LEA DX,MSG1
        MOV AH,9
        INT 21H
        
        MOV SI,0
        
        INPUT:
            MOV AH,1
            INT 21H
            
            CMP AL,13
            JZ END_INPUT
            
            ;SUB AL,48
            
            MOV STR+SI,AL
            INC SI
            
            JMP INPUT
            
            END_INPUT:
                LEA DX,NEWLINE
                MOV AH,9
                INT 21H
                
                LEA DX,MSG2
                INT 21H
                
                MOV SI,0
                
                OUTTER:
                    CMP STR+SI,'$'
                    JZ BREAK_OUTTER
                    
                    
                    MOV DI,SI
                     
                    INNER:
                        INC DI
                        MOV BL,STR+SI
                        MOV CL,STR+DI
                        
                        CMP STR+DI,'$'
                        JZ BREAK_INNER
                        
                        CMP BL,STR+DI
                        JG SWAP
                        
                        JMP INNER
                        
                            SWAP:
                                XCHG BL,STR+DI
                                MOV STR+SI,CL
                                
                                JMP INNER
                                
                                BREAK_INNER:
                                    INC SI
                                    ;MOV DI,0
                                    
                                    JMP OUTTER
                                    
                                    BREAK_OUTTER:
                                        MOV SI,0
                                        
                                        OUTPUT1:
                                            CMP STR+SI,'$'
                                            JZ NEXT
                                            
                                            ;;Escaping the First occured spaces
                                            CMP STR+SI,' '
                                            JZ SKIP
                                            
                                            MOV DL,STR+SI
                                            ;ADD DL,48
                                            MOV AH,2
                                            INT 21H
                                            MOV DL,20H
                                            INT 21H 
                                            
                                            INC SI
                                            
                                            JMP OUTPUT1
                                                
                                                SKIP:
                                                    INC SI
                                                    
                                                    JMP OUTPUT1
                                                    
                                                    NEXT:
                                                        DEC SI
                                                        
                                                        LEA DX,NEWLINE
                                                        MOV AH,9
                                                        INT 21H
                                                        LEA DX,MSG3
                                                        INT 21H 
                                                        
                                                        CMP SI,0
                                                        JL EXIT
                                                        
                                                        OUTPUT2:
                                                            CMP STR+SI,' '
                                                            JZ EXIT
                                                            
                                                            MOV DL,STR+SI
                                                            MOV AH,2
                                                            INT 21H
                                                            MOV DL,' '
                                                            INT 21H
                                                            
                                                            DEC SI
                                                            
                                                            JMP OUTPUT2
                                                            
                                                            EXIT:
                                                                MOV AH,4CH
                                                                INT 21H
                                                    
                                                    MAIN ENDP
                            
                          