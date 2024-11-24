.MODEL SMALL
.STACK 100h

.DATA
    prompt1 DB 'Enter first single-digit integer: $'  ; Prompt for the first integer
    prompt2 DB 'Enter second single-digit integer: $' ; Prompt for the second integer
    resultMsg DB 'Result of subtraction: $'           ; Message to display before result
    result DB '?'                                     ; Placeholder for the result

.CODE
MAIN PROC
    MOV AX, @DATA                  ; Load the data segment address
    MOV DS, AX                     ; into DS register

    ; Display prompt for the first integer
    MOV DX, OFFSET prompt1         ; Load address of the first prompt
    MOV AH, 09h                    ; DOS function to display a string
    INT 21h                        ; Call DOS interrupt

    ; Read first single-digit integer from the user
    MOV AH, 01h                    ; DOS function to read a character
    INT 21h                        ; Call DOS interrupt
    SUB AL, '0'                    ; Convert ASCII to integer
    MOV BL, AL                     ; Store the first integer in BL

    ; Display prompt for the second integer
    MOV DX, OFFSET prompt2         ; Load address of the second prompt
    MOV AH, 09h                    ; DOS function to display a string
    INT 21h                        ; Call DOS interrupt

    ; Read second single-digit integer from the user
    MOV AH, 01h                    ; DOS function to read a character
    INT 21h                        ; Call DOS interrupt
    SUB AL, '0'                    ; Convert ASCII to integer
    MOV BH, AL                     ; Store the second integer in BH

    ; Perform subtraction (first - second) and store result in AL
    MOV AL, BL                     ; Load the first integer into AL
    SUB AL, BH                     ; Subtract the second integer

    ; Convert result to ASCII for display
    ADD AL, '0'
    MOV result, AL                 ; Store result for printing

    ; Display result message
    MOV DX, OFFSET resultMsg       ; Load address of result message
    MOV AH, 09h                    ; DOS function to display a string
    INT 21h                        ; Call DOS interrupt

    ; Display the result
    MOV DL, result                 ; Load the result character into DL
    MOV AH, 02h                    ; DOS function to display a character
    INT 21h                        ; Call DOS interrupt to print the character

    ; End program
    MOV AH, 4Ch                    ; DOS terminate program function
    INT 21h                        ; Call DOS interrupt to exit

MAIN ENDP
END MAIN
