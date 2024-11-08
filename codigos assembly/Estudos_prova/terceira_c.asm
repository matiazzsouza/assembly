.MODEL SMALL
.STACK 100H

.DATA
    number db 0        ; Variável para armazenar o número decimal
    binario db 8 dup(?) ; Vetor para armazenar os dígitos binários (até 8 bits)
    mensagem db 'Digite um número decimal: $'
    resultado db 13, 10, 'O número em binário é: $'

.CODE
INICIO:
    ; Inicialização do segmento
    MOV AX, @DATA
    MOV DS, AX

    ; Exibe mensagem para o usuário
    MOV AH, 09H
    LEA DX, mensagem
    INT 21H

    ; Lê o número do usuário (apenas números de 0 a 9)
    MOV AH, 01h
    INT 21H
    SUB AL, 30H         ; Converte caractere ASCII para número
    MOV number, AL      ; Armazena número em 'number'

    ; Converte o número decimal para binário
    MOV CX, 8           ; Contador de 8 bits
    LEA DI, binario     ; DI aponta para o início do vetor 'binario'
    
CONVERTE:
    MOV AL, number
    AND AL, 01H         ; Verifica o bit menos significativo
    ADD AL, 30H         ; Converte para caractere ASCII ('0' ou '1')
    MOV [DI], AL        ; Armazena o bit no vetor
    SHR number, 1       ; Desloca o número 1 bit para a direita
    INC DI              ; Próxima posição do vetor
    LOOP CONVERTE       ; Repete até converter todos os 8 bits

    ; Exibe o resultado em binário
    MOV AH, 09H
    LEA DX, resultado
    INT 21H

    ; Exibe os bits binários armazenados no vetor
    MOV CX, 8        ; 8 bits para exibir
    LEA DI, binario + 7 ; DI aponta para o bit mais significativo (último do vetor)
    
MOSTRA_BINARIO:
    MOV AH, 02H         ; Função para exibir um caractere
    MOV DL, [DI]        ; Carrega o bit atual
    INT 21H
    DEC DI              ; Vai para o próximo bit (na ordem inversa)
    LOOP MOSTRA_BINARIO ; Repete até exibir todos os bits

    ; Termina o programa
    MOV AH, 4CH
    INT 21H

END INICIO
