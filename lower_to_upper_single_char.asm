.MODEL SMALL
.STACK 100h

.DATA
    lower_case DB 'b'       ; Define a lowercase letter (for example, 'b')
    upper_case DB '?'       ; Placeholder for the resulting uppercase letter
    errMsg DB 'Input is not a lowercase letter.$'

.CODE
MAIN PROC
    MOV AX, @DATA           ; Load the data segment address
    MOV DS, AX              ; into DS register

    ; Load lowercase character to register AL
    MOV AL, lower_case      

    ; Check if AL is within the lowercase range (a-z)
    CMP AL, 'a'             ; Compare AL with 'a'
    JL NOT_LOWER            ; If AL < 'a', jump to NOT_LOWER
    CMP AL, 'z'             ; Compare AL with 'z'
    JG NOT_LOWER            ; If AL > 'z', jump to NOT_LOWER

    ; Convert to uppercase by subtracting 32
    SUB AL, 20h             ; 20h (hex) is equivalent to 32 in decimal

    ; Store the uppercase character
    MOV upper_case, AL      

    ; Display the uppercase character
    MOV DL, upper_case      ; Load the uppercase character into DL
    MOV AH, 02h             ; Function to display a character (INT 21h, AH=02h)
    INT 21h                 ; Call DOS interrupt to print character

    JMP END_PROGRAM         ; Jump to end the program

NOT_LOWER:
    ; Display an error message if input is not lowercase
    MOV DX, OFFSET errMsg   ; Load the address of the error message
    MOV AH, 09h             ; Function to display a string (INT 21h, AH=09h)
    INT 21h                 ; Call DOS interrupt to print the message

END_PROGRAM:
    MOV AH, 4Ch             ; DOS terminate program function
    INT 21h                 ; Call DOS interrupt to exit

MAIN ENDP

END MAIN
