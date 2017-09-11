[org 0x7c00]

section .text

mov si, STR
call print_phrase

jmp $

;                org     0
;Entry:          jmp     real_start

%include "printf.asm"

STR: db "Welcome to ReactOS", 0

TIMES 510-($-$$) DB 0
sign            dw      0aa55h
