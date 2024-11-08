title ?
.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 10,13,'OLA USUARIO DIGITE UMA LETRA MAIUSCULA $'
    MSG2 DB 10,13,'AS LETRAS DIGITADAS NA ORDEM ALFABETICAS EH =>  $'
.CODE

    MAIN PROC

        MOV AX, @data
        MOV DS, AX

        MOV CX, 2

        MOV AH, 2
        LEA DX, MSG1
        INT 21h

        PRINT:

            MOV AH, 1
            INT 21h
            
            MOV BL, AL

            LOOP PRINT

            MOV AH, 9
            LEA DX, MSG2
            INT 21h

            MOV AH, 2
            CMP AL, BL
            JA MAIOR

            MOV DL, BL
            MOV DL,AL
        
            INT 21h
            JMP FIM

        MAIOR:
            INT 21h
            MOV AH, 2
            
            MOV DL, AL
            MOV DL, BL

        FIM:
            MOV AH, 4CH
            INT 21h

        MAIN ENDP 
        END MAIN

