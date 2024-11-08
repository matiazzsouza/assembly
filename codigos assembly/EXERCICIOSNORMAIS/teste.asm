.MODEL SMALL
.STACK 100h

.DATA
    ; Buffer para entrada do usuário
    vetor db 6              ; Primeiro byte: tamanho máximo de caracteres (5 + 1 para Enter)
    db 0                    ; Segundo byte: será preenchido com o número de caracteres lidos
    db 5 DUP(?)             ; Área para armazenar até 5 caracteres lidos

    msg_prompt db 'Insira ate 5 caracteres: $'  ; Mensagem para o usuário

.CODE
main PROC
    mov ax, @data
    mov ds, ax             

    mov ah, 09h            
    lea dx, msg_prompt      
    int 21h                 

    mov ah, 0Ah            
    lea dx, vetor           
    int 21h                 

    mov ah, 09h             
    lea dx, vetor + 2        
    int 21h                 
    mov ah, 4Ch           
    int 21h                 
    
main ENDP
END main
