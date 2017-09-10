[org 0x7c00]

mov si, STR
call print_phrase

call read_disk
jmp test

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

read_disk:
  pusha
  mov ah, 0x02
  mov dl, 0x80
  mov ch, 0
  mov dh, 0
  mov al, 1
  mov cl, 2

  push bx
  mov bx, 0
  mov es, bx
  pop bx
  mov bx, 0x7c00 + 512

  int 0x13

  jc disk_error
  popa
  ret

  disk_error:
  mov si, DISK_ERR_MSG
  call print_phrase
  jmp $

STR: db "Welcome to your OS", 0x0a, 0x0d, 0

DISK_ERR_MSG: db "Error Loading Disk", 0
TEST_STR: db "You are in the second sector", 0

; padding and magic number
times 510-($-$$) db 0
db 0x55
db 0xAA

test:
mov si, TEST_STR
call print_phrase

times 512 db 0
