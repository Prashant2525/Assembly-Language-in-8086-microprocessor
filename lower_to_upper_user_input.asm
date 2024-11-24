.model small
.data 
     msg1 db 13,10, "Enter a lowercase letter: $"
     msg2 db 13,10, "In uppercase: $"
.code 
main proc
    
    mov ax,@data
    mov ds,ax ; Corrected to load @data segment into DS for .data section

    ; Display the prompt to enter a lowercase letter
    mov dx,offset msg1
    mov ah,9
    int 21h

    ; Read the lowercase letter from the user
    mov ah,1
    int 21h 
    mov bl,al

    ; Convert lowercase to uppercase by subtracting 32
    sub bl,32 

    ; Display the prompt for the converted uppercase letter
    mov dx,offset msg2
    mov ah,9
    int 21h

    ; Output the uppercase letter
    mov dl,bl
    mov ah,2
    int 21h

    ; Exit program
    mov ah,4ch
    int 21h
    
main endp
end main