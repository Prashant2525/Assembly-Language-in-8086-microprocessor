org 100h

.data
    num1 db 027h
    num2 db 025h
    msg db 'Result: $'
    ovf db 'Borrow Occured $'
.code
    mov ax, @data
    mov ds, ax
           
    ;Print Result message       
    lea dx, msg
    mov ah, 09h
    int 21h
    
    xor ax, ax
    
    mov al, num1
    sub al, num2
    jno no_borrow
    
    ;Print overflow message
    lea dx, ovf
    mov ah, 09h
    int 21h
    jmp exit
    
    no_borrow:
        mov bl, 010h
        div bl
        
        mov bx, ax
        
        add bl, '0' 
        cmp bl, '9'
        jle print_digit10s
        add bl, 7
        
        print_digit10s:
            mov dl, bl
            mov ah, 02h
            int 21h
            
        add bh, '0'
        cmp bh, '9'
        jle print_digit1s
        add bh, 7
        
        print_digit1s:
            mov dl, bh
            mov ah, 02h
            int 21h
     exit:
     
     mov ah, 4ch
     int 21h
ret