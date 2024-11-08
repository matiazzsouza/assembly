.model small
.stack 100h   ; Define uma pilha de 256 bytes (100h em hexadecimal)

.data
    num1 dw 5            ; Define uma palavra (16 bits) contendo o valor 5
    num2 dw 0            ; Define uma palavra contendo o valor 0
    result dw ?          ; Define uma palavra para armazenar o resultado da soma (inicialmente indefinido)
    msg db 'Resultado: $' ; Define uma string terminada em '$' (marcador de final de string para a função 09h de interrupção 21h)
    newline db 13, 10, '$' ; Define uma nova linha (CR e LF) seguido do marcador de final de string '$'

.code

main proc
    mov ax, @data      ; Carrega o endereço inicial do segmento de dados no registrador AX
    mov ds, ax         ; Carrega o segmento de dados (DS) com o valor em AX, permitindo acesso às variáveis definidas em .data

    mov ax, num1       ; Carrega o valor da variável 'num1' no registrador AX
    add ax, num2       ; Adiciona o valor da variável 'num2' ao registrador AX
    mov result, ax     ; Armazena o resultado da soma na variável 'result'

    lea dx, msg        ; Carrega o endereço da string 'msg' no registrador DX
    mov ah, 09h        ; Define a função 09h (imprimir string) no registrador AH
    int 21h            ; Chama a interrupção 21h do DOS para imprimir a string em 'msg'

    call PrintResult   ; Chama a função 'PrintResult' que imprime o valor de 'result'

    lea dx, newline    ; Carrega o endereço da string 'newline' (que contém CR+LF) no registrador DX
    mov ah, 09h        ; Define a função 09h (imprimir string) no registrador AH
    int 21h            ; Chama a interrupção 21h do DOS para imprimir a nova linha

    mov ax, 4C00h      ; Prepara o AX para terminar o programa com o código de saída 0 (função 4Ch do DOS)
    int 21h            ; Chama a interrupção 21h do DOS para finalizar o programa
main endp

PrintResult proc
    mov ax, result     ; Carrega o valor de 'result' em AX
    mov cx, 0          ; Inicializa o contador CX em 0
    mov bx, 10         ; Define a base decimal (10) no registrador BX

ConvertLoop:
    xor dx, dx         ; Zera o registrador DX para garantir que não haja valores residuais
    div bx             ; Divide AX por 10, o quociente vai para AX e o resto (dígito) para DX
    push dx            ; Armazena o dígito no topo da pilha
    inc cx             ; Incrementa o contador de dígitos
    test ax, ax        ; Testa se AX é zero (fim da divisão)
    jnz ConvertLoop    ; Se AX não for zero, repete o loop para continuar dividindo

PrintLoop:
    pop dx             ; Recupera um dígito da pilha
    add dl, '0'        ; Converte o dígito em seu equivalente ASCII
    mov ah, 02h        ; Define a função 02h (imprimir caractere) no registrador AH
    int 21h            ; Chama a interrupção 21h do DOS para imprimir o caractere em DL
    loop PrintLoop     ; Repete o loop para todos os dígitos

    ret                ; Retorna ao chamador
PrintResult endp       ; Fim da função PrintResult

end main
