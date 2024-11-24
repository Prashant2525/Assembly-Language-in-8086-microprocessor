.MODEL SMALL
.STACK 100h

.DATA
    char DB 'Prashant$'       ; Define a character to print

.CODE
MAIN PROC
    MOV AX, @DATA     ; Load the data segment address
    MOV DS, AX        ; into DS register

    MOV AH, 02h       ; Function to display a single character (INT 21h, AH=02h)
    MOV DL, char      ; Load the character to be printed into DL
    INT 21h           ; Call DOS interrupt to print character

    MOV AH, 4Ch       ; DOS terminate program function
    INT 21h           ; Call DOS interrupt to exit

MAIN ENDP
END MAIN
