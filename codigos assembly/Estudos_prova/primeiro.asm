.MODEL SMALL
.STACK 100h
.DATA
    MSG DB 'DIGITE UMA PALAVRA: $'
    MSG2 DB 13, 10, 'A LETRA "A" APARECEU -> $'
    NL DB 13, 10, '$'  ; Nova linha
    VETOR DB 20, ?     ; Primeiro byte: tamanho máximo (20), segundo byte: número de caracteres lidos
    BUFFER DB 20 DUP('$')  ; Buffer para armazenar os caracteres lidos

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    ; Exibe a mensagem inicial
    MOV AH, 9
    LEA DX, MSG
    INT 21H

    ; Lê a string digitada pelo usuário
    MOV AH, 0Ah
    LEA DX, VETOR
    INT 21H

    ; Chama a função para contar quantas vezes a letra 'A' ou 'a' aparece
    CALL CONTADOR

    ; Exibe a quantidade de ocorrências
    MOV AH, 9
    LEA DX, MSG2
    INT 21H

    ; Exibe o valor da contagem (em BX)
    MOV AX, BX  ; A contagem está em BX
    CALL PRINT_NUM

    ; Exibe uma nova linha
    MOV AH, 9
    LEA DX, NL
    INT 21H

    ; Finaliza o programa
    MOV AH, 4CH
    INT 21H
MAIN ENDP

; Função para contar quantas vezes a letra 'A' ou 'a' aparece no vetor
CONTADOR PROC 
    MOV BX, 0          ; Zera o contador
    MOV CL, [VETOR+1]  ; Número de caracteres lidos (segundo byte do VETOR)
    LEA SI, [VETOR+2]  ; Aponta para o primeiro caractere

COMP:
    CMP CL, 0          ; Verifica se chegamos ao final
    JE FIM_CONT

    MOV AL, [SI]       ; Pega o caractere atual
    CMP AL, 'A'        ; Compara com 'A'
    JE INC_CONT
    CMP AL, 'a'        ; Compara com 'a'
    JE INC_CONT

    JMP NAO_IGUAL

INC_CONT:
    INC BX             ; Incrementa o contador

NAO_IGUAL:
    INC SI             ; Move para o próximo caractere
    DEC CL             ; Decrementa o número de caracteres restantes
    JMP COMP

FIM_CONT:
    RET
CONTADOR ENDP

; Função para exibir um número armazenado em AX
PRINT_NUM PROC
    ; Coloca o valor 10 no BX para a divisão
    MOV BX, 10

    ; Converte o número em AX para uma string de dígitos
    PUSH AX
    XOR CX, CX          ; Zera o contador de dígitos

CONVERT_LOOP:
    XOR DX, DX          ; Zera DX antes da divisão
    DIV BX              ; Divide AX por 10, quociente em AX, resto em DX
    ADD DL, '0'         ; Converte o resto (dígito) para ASCII
    PUSH DX             ; Armazena o dígito na pilha
    INC CX              ; Conta os dígitos
    TEST AX, AX         ; Testa se ainda há valor em AX
    JNZ CONVERT_LOOP

    ; Exibe os dígitos
DISPLAY_LOOP:
    POP DX
    MOV AH, 2
    INT 21H
    LOOP DISPLAY_LOOP

    POP AX
    RET
PRINT_NUM ENDP

END MAIN


;
;primeiro pede para o usuario digitar um string
;segundo armazena os digitos na matriz pelos registradors [si, di ,bx] usando o sub 30h para transformar em caractere comparando com o valor na tabela asc da letra 'a' ou 'A' a cada caractere digitado usando um contador para no final dizer quantas letras A existem na string 

