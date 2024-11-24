.MODEL SMALL
.STACK 100h

.DATA
    upper_case DB 'P'      ; Define an uppercase letter (for example, 'A')
    lower_case DB '?'      ; Placeholder for the resulting lowercase letter  
    errMsg DB 'Input is not an uppercase letter.$'

.CODE
MAIN PROC
    MOV AX, @DATA          ; Load the data segment address
    MOV DS, AX             ; into DS register

    ; Load uppercase character to register AL
    MOV AL, upper_case     

    ; Check if AL is within the uppercase range (A-Z)
    CMP AL, 'A'            ; Compare AL with 'A'
    JL NOT_UPPER           ; If AL < 'A', jump to NOT_UPPER
    CMP AL, 'Z'            ; Compare AL with 'Z'
    JG NOT_UPPER           ; If AL > 'Z', jump to NOT_UPPER

    ; Convert to lowercase by adding 32
    ADD AL, 20h            ; 20h (hex) is equivalent to 32 in decimal

    ; Store the lowercase character
    MOV lower_case, AL     

    ; Display the lowercase character
    MOV DL, lower_case     ; Load the lowercase character into DL
    MOV AH, 02h            ; Function to display a character (INT 21h, AH=02h)
    INT 21h                ; Call DOS interrupt to print character

    JMP END_PROGRAM        ; Jump to end the program

NOT_UPPER:
    ; Display an error message if input is not uppercase
    MOV DX, OFFSET errMsg  ; Load the address of the error message
    MOV AH, 09h            ; Function to display a string (INT 21h, AH=09h)
    INT 21h                ; Call DOS interrupt to print the message

END_PROGRAM:
    MOV AH, 4Ch            ; DOS terminate program function
    INT 21h                ; Call DOS interrupt to exit

MAIN ENDP

END MAIN
