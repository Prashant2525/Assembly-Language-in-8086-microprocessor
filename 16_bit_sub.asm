.model small
.stack 100h

.data
    a dw 1234h
    b dw 0100h
    msg db 'Result: $'   ; Message to print before the result
    ovf db 'ARITHMETIC OVERFLOW! $' ; Overflow message

.code
start:
    mov ax, @data   ; Initialize data section
    mov ds, ax

    ; Print Message
    lea dx, msg
    mov ah, 09h
    int 21h

    mov ax, a       ; Load number1 in ax
    mov bx, b       ; Load number2 in bx
    sub ax, bx      ; Subtract numbers. Result in ax

    ; Check for overflow (borrow)
    jno noover      ; If no overflow, jump to noover

    ; Print overflow message
    lea dx, ovf
    mov ah, 09h
    int 21h
    jmp exit

noover:
    ; Convert result to hexadecimal
    mov ch, 04h     ; Count of digits to be displayed
    mov cl, 04h     ; Count to roll by 4 bits
    mov bx, ax      ; Result in reg bh

display:
    rol bx, cl      ; Roll bl so that MSB comes to LSB
    mov dl, bl      ; Load dl with data to be displayed
    and dl, 0fh     ; Get only LSB
    cmp dl, 09      ; Check if digit is 0-9 or letter A-F
    jbe print_digit
    add dl, 07      ; If letter, add 37H else only add 30H

print_digit:
    add dl, 30h     ; Convert to ASCII
    mov ah, 02h     ; Function 2 under INT 21H (Display character)
    int 21h
    dec ch          ; Decrement count
    jnz display     ; Repeat until all digits are displayed

exit:
    mov ah, 4ch     ; Terminate program
    int 21h

end start
