.MODEL SMALL
.STACK 100h
.DATA
    MSG1 DB 10,13,'OLA, USUARIO DIGITE UM NUMERO DE 1 ATE 9=> $'
    MSG2 DB 10,13,'O NUMERO DIGITADO NAO EH VALIDO $'
    MSG3 DB 10,13,'O VALOR DELA EM LETRA DE A ATE I6 EH =>  $'
    MSG4 DB 10,13,'DESEJA CONTINUAR S OU N =>  $'
    MSG5 DB 10,13,'OBRIGADO, AGORA RALA !!!$'
    
.CODE

    MAIN PROC 

        MOV AX, @DATA
        MOV DS, AX

        INICIO:
            MOV AH,9
            LEA DX, MSG1
            INT 21h

            MOV AH, 1
            INT 21h

            MOV BL,AL

            CMP BL, 48
            JB ÑNUMERO
            
            CMP BL, 57
            JA ÑNUMERO

            MOV AH, 9
            LEA DX, MSG3
            INT 21H

            MOV AH, 2
            ADD BL, 30H
            MOV DL, BL
            INT 21h

            MOV AH, 9
            LEA DX, MSG4
            INT 21h

            MOV AH, 1
            INT 21H

            MOV BL, AL

            CMP BL, 'S'
            JE INICIO
            
            CMP BL, 's'
            JE INICIO
            
            CMP BL, 'N'
            JE FIM
            
            CMP BL, 'n'
            JE FIM

            JMP FIM

        ÑNUMERO:
            MOV AH, 9
            LEA DX, MSG2
            INT 21h

            MOV AH, 9
            LEA DX, MSG4
            INT 21h

            MOV AH, 1
            INT 21h

            MOV BL, AL

            CMP BL, 'S'
            JE INICIO
            
            CMP BL, 's'
            JE INICIO
            
            CMP BL, 'N'
            JE FIM
            
            CMP BL, 'n'
            JE FIM
            

            MAIN ENDP
            
        FIM:
            MOV AH, 9
            LEA DX, MSG5
            INT 21h

            MOV AH, 4CH
            INT 21h
        
        END MAIN    



