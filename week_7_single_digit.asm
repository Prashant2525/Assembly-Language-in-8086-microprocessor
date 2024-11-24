.MODEL SMALL
.STACK 100h

.DATA
    promptMsg DB 'Enter a single-digit integer: $' ; Prompt message
    outputMsg DB 'You entered: $'                  ; Output message

.CODE
MAIN PROC
    MOV AX, @DATA                  ; Load the data segment address
    MOV DS, AX                     ; into DS register

    ; Display the prompt message
    MOV DX, OFFSET promptMsg       ; Load address of promptMsg
    MOV AH, 09h                    ; DOS function to display a string
    INT 21h                        ; Call DOS interrupt to print the prompt

    ; Read single-digit integer from user
    MOV AH, 01h                    ; DOS function to read a character
    INT 21h                        ; Call DOS interrupt
    MOV BL, AL                     ; Store the input character in BL

    ; Display output message
    MOV DX, OFFSET outputMsg       ; Load address of outputMsg
    MOV AH, 09h                    ; DOS function to display a string
    INT 21h                        ; Call DOS interrupt to print the message

    ; Display the entered single-digit integer
    MOV DL, BL                     ; Move the stored character from BL to DL
    MOV AH, 02h                    ; DOS function to display a single character
    INT 21h                        ; Call DOS interrupt to print the character in DL

    ; End program
    MOV AH, 4Ch                    ; DOS terminate program function
    INT 21h                        ; Call DOS interrupt to exit

MAIN ENDP
END MAIN
