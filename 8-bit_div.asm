.model small
.stack 100h

.data
    dividend dw 1000h     ; 16-bit dividend
    divisor db 20h        ; 8-bit divisor
    quotient db ?         ; 8-bit quotient
    remainder db ?        ; 8-bit remainder
    msgQuot db 'Quotient: $'
    msgRem db 'Remainder: $'
    result db '00h$'      ; Placeholder for outputting hexadecimal result

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ax, dividend      ; Load dividend into AX
    mov bl, divisor       ; Load divisor into BL
    div bl                ; Divide AX by BL
                          ; Result: AL = quotient, AH = remainder

    mov quotient, al      ; Store quotient in memory
    mov remainder, ah     ; Store remainder in memory

    ; Display quotient
    mov dx, offset msgQuot
    mov ah, 09h           ; DOS interrupt to display string
    int 21h

    mov al, quotient      ; Load quotient to AL
    call PrintHex         ; Call function to print as hex

    ; Display remainder
    mov dx, offset msgRem
    mov ah, 09h           ; DOS interrupt to display string
    int 21h

    mov al, remainder     ; Load remainder to AL
    call PrintHex         ; Call function to print as hex

    mov ax, 4c00h         ; Exit program
    int 21h

main endp

;--------------------------------------------------
; Procedure to convert a byte in AL to hex and print
;--------------------------------------------------
PrintHex proc
    mov ah, al
    shr al, 4             ; Get high nibble
    call ConvertToHex     ; Convert high nibble to ASCII
    mov result[0], al     ; Store high nibble

    mov al, ah            ; Restore original AL value
    and al, 0Fh           ; Get low nibble
    call ConvertToHex     ; Convert low nibble to ASCII
    mov result[1], al     ; Store low nibble

    mov dx, offset result ; Point to the result string
    mov ah, 09h           ; DOS interrupt to display string
    int 21h
    ret
PrintHex endp

;--------------------------------------------------
; Procedure to convert a nibble in AL to hex ASCII
;--------------------------------------------------
ConvertToHex proc
    cmp al, 9
    jbe Digit             ; If 0-9, go to Digit
    add al, 7             ; Adjust for A-F
Digit:
    add al, 30h           ; Convert to ASCII
    ret
ConvertToHex endp

end main
