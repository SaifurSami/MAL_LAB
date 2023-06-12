.MODEL SMALL
.STACK 100H
.DATA
    NEWLINE DB "Enter The String : $"
.CODE
    MAIN PROC
        MOV AX,@DATA
        MOV DS,AX
        
        