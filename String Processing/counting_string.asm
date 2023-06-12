.MODEL SMALL
.STACK 100H
.DATA
    NEWLINE DB 10,13,'$'
    MSG DB "Enter The String : $"
    NVOWELS DB "Number of Vowels : $"
    NCONSONANTS DB "Number of Consonents : $"
    NDIGITS DB "Number of Digits : $"
    NSPACES DB "Number of Spaces : $"
    NPUNCTUATIONS DB "Number of Punctuations : $"
    STR DB 100 DUP('$')
    V DB 0
    C DB 0
    D DB 0
    S DB 0
    P DB 0
    SZ DB 0
    CNT DB 0
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        LEA DX,MSG
        MOV AH,9
        INT 21H
        
        MOV SI,0
        MOV DI,0
        
        INPUT:
            MOV AH,1
            INT 21H
            MOV BL,AL
            
            CMP AL,13
            JZ ENDINPUT
            
            MOV STR+SI,BL
            INC SI
            INC SZ
            
            JMP INPUT
        
        ENDINPUT:
            MOV SI,0
            MOV DI,0
            
        CHECK:
            MOV BL,STR+SI
            
            CMP STR+SI,'$'
            JZ RESULT
            
            CMP BL,'A'
            JZ VOWEL
            
            CMP BL,'a'
            JZ VOWEL
            
            CMP BL,'E'
            JZ VOWEL
            
            CMP BL,'e'
            JZ VOWEL
            
            CMP BL,'I'
            JZ VOWEL
            
            CMP BL,'i'
            JZ VOWEL 
            
            CMP BL,'O'
            JZ VOWEL
            
            CMP BL,'o'
            JZ VOWEL 
            
            CMP BL,'U'
            JZ VOWEL
            
            CMP BL,'u'
            JZ VOWEL
            
            CMP BL,' '
            JZ SPACE
            
            CALL ISDIGIT
            CALL ISCONSONANT
            
            INC SI
            ;INC CNT
            
            JMP CHECK
      
        RESULT:
            LEA DX,NEWLINE
            MOV AH,9
            INT 21H
            
            LEA DX,NVOWELS
            INT 21H
            
            MOV DL,V
            ;SUB DL,48
            ADD DL,48
            MOV AH,2 
            INT 21H
            
            LEA DX,NEWLINE
            MOV AH,9
            INT 21H
            
            LEA DX,NCONSONANTS
            MOV AH,9
            INT 21H
            
            MOV DL,C
            ;SUB DL,48
            ADD DL,48
            MOV AH,2
            INT 21H
            
            LEA DX,NEWLINE
            MOV AH,9
            INT 21H
            
            LEA DX,NDIGITS
            MOV AH,9
            INT 21H
            
            MOV DL,D
            ;SUB DL,48
            ADD DL,48
            MOV AH,2
            INT 21H
            
            LEA DX,NEWLINE
            MOV AH,9
            INT 21H
            
            LEA DX,NSPACES
            MOV AH,9
            INT 21H
            
            MOV DL,S
            ;SUB DL,48
            ADD DL,48
            MOV AH,2
            INT 21H
            
            LEA DX,NEWLINE
            MOV AH,9
            INT 21H
            
            LEA DX,NPUNCTUATIONS
            MOV AH,9
            INT 21H
            
            MOV DL,SZ
            SUB DL,CNT
            ADD DL,48
            MOV AH,2
            INT 21H
            
            JMP EXIT
        
        VOWEL:
            INC V
            INC SI
            INC CNT
            
            JMP CHECK                  
        
        SPACE:
            INC S
            INC SI
            INC CNT
            
            JMP CHECK
        
        EXIT:
            MOV AH,4CH
            INT 21H
            
        ENDP MAIN
        
        ISDIGIT PROC
            MOV DL,0
            ADD DL,48
            CMP BL,DL
            JGE LOOK
            
            RET
        
        LOOK:
            MOV DL,9
            ADD DL,48
            CMP BL,DL
            JLE POSITIVE
            
            RET
        
        POSITIVE:
            INC D
            INC CNT
            
            RET
        
        ENDP ISDIGIT                        
        
        ISCONSONANT PROC
            CMP BL,'A'
            JGE GO1
            
            RET
            
        GO1:
            CMP BL,'Z'
            JLE YES
            
            CMP BL,'a'
            JGE GO2
            
            RET
        
        GO2:
            CMP BL,'z'
            JLE YES
            
            RET
            
        YES:
            INC C
            INC CNT
            
            RET
            
        ENDP ISCONSONANT    
        