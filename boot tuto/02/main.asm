[org 0x7c00]

mov si, STR
call print_phrase

jmp $

print_phrase:
  pusha
  phrase_loop:
    mov al, [si]
    cmp al, 0
    jne print_char
    popa
    ret

  print_char:
    mov ah, 0x0e
    int 0x10
    add si, 1
    jmp phrase_loop

STR: db "Welcome to your OS", 0

; padding and magic number
times 510-($-$$) db 0
db 0x55
db 0xAA
