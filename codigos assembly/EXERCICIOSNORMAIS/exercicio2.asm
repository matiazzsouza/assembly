.MODEL SMALL
.STACK 100H
.DATA
    MSG DB 10,13,'CARACTERES ASCII: $'

.CODE
    MAIN PROC

        MOV AX, @data
        MOV DS, AX

        MOV AH, 9
        LEA DX, MSG
        INT 21h

        MOV CX, 97 
        MOV BX, 16
        

        LOOP_PRINT:
            MOV AH, 2
            MOV DL, CL
            INT 21h

            MOV DL, 32
            INT 21h

            INC BX 
            CMP BX, 16 
            JE NEW_LINE 
            LOOP LOOP_PRINT

        NEW_LINE:
            
            MOV DL, 10
            INT 21h
            MOV DL, 13
            INT 21h

            MOV BX, 0 
            JMP LOOP_PRINT

        MOV AH, 4CH
        INT 21h

        MAIN ENDP
        END MAIN