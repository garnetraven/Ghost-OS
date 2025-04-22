org 0x7C00              ; set memory origin to 0x7C00 (BIOS loads boot code here)
bits 16                 ; Use 16-bit instructions (real mode)

%define ENDL 0x0D, 0x0A

;
;
;
;
puts:
    ; save registers we will modify
    push si 
    push ax
    push bx

.loop:
    lodsb
    or al, al
    jz .done

    mov ah, 0x0E
    mov bh, 0
    int 0x10

    jmp .loop

.done:
    pop bx
    pop ax
    pop si
    ret

main:
    ; setup data segments
    mov ax, 0
    mov ds, ax
    mov es, ax

    mov ss, ax
    mov sp, 0x7C00

    mov si, msg_hello
    call puts

    hlt

.halt:
    jmp .halt

msg_hello: db 'Hello world!', ENDL, 0

times 510-($-$$) db 0   ; pad to 510 bytes with zeros
dw 0AA55h               ; Add boot signature (required by BIOS)
