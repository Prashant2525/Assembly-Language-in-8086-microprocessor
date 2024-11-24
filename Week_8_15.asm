.MODEL SMALL
.STACK 100h

.DATA              
    num1 db 10,13, 'enter first: $'
    num2 db 10,13, 'enter second: $'
    result1msg db 10,13, 'you enter first as: $'
    result2msg db 10,13, 'you enter second as: $'   
    result1 db 0
    result2 db 0
    
.CODE      
MAIN PROC
    mov ax, @DATA
    mov ds, ax
    
    mov dx, offset num1
    mov ah, 09h
    int 21h
    
    mov ah, 01h
    int 21h
    mov bl, al
    
    mov result1, bl
    
    mov dx, offset num2
    mov ah, 09h
    int 21h
    
    mov ah, 01h
    int 21h
    mov bh, al
    
    mov result2, bh
    
    mov dx, offset result1msg
    mov ah, 09h
    int 21h
    
    mov dl, result1
    mov ah, 02h
    int 21h
    
    mov dx, offset result2msg
    mov ah, 09h
    int 21h
    
    mov dl, result2
    mov ah, 02h
    int 21h
    
    mov ah, 4ch
    int 21h
    
MAIN ENDP
END MAIN