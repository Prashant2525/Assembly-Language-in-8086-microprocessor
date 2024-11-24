; Program to take two single-digit integers from the user and display their sum
.MODEL SMALL
.STACK 100h

.DATA
    prompt1 DB 'Enter the first single-digit integer: $'
    prompt2 DB 'Enter the second single-digit integer: $'
    resultMsg DB 'The sum of the two numbers is: $'
    sumRes DB 5 DUP('$')  ; Space to store result as a string (max 2 digits + null)

.CODE
MAIN PROC
    MOV AX, @DATA               ; Load the data segment address
    MOV DS, AX                  ; into DS register

    ; Prompt for the first number
    MOV DX, OFFSET prompt1      ; Load address of prompt1
    MOV AH, 09h                 ; DOS function to display a string
    INT 21h                     ; Call DOS interrupt to print the prompt
    MOV AH, 01h                 ; DOS function to read a character
    INT 21h                     ; Call DOS interrupt
    SUB AL, '0'                 ; Convert ASCII to integer
    MOV BL, AL                  ; Store the first number in BL

    ; Prompt for the second number
    MOV DX, OFFSET prompt2      ; Load address of prompt2
    MOV AH, 09h                 ; DOS function to display a string
    INT 21h                     ; Call DOS interrupt to print the prompt
    MOV AH, 01h                 ; DOS function to read a character
    INT 21h                     ; Call DOS interrupt
    SUB AL, '0'                 ; Convert ASCII to integer
    MOV BH, AL                  ; Store the second number in BH

    ; Perform addition
    MOV AL, BL                  ; Load the first number into AL
    ADD AL, BH                  ; Add the second number
    AAM                         ; Adjust for unpacked BCD (separates digits if >9)

    ; Store result as ASCII characters
    ADD AH, '0'                 ; Convert tens place to ASCII
    MOV sumRes, AH              ; Store tens place
    ADD AL, '0'                 ; Convert units place to ASCII
    MOV sumRes+1, AL            ; Store units place
    MOV sumRes+2, '$'           ; Null terminator for the result string

    ; Display the result message
    MOV DX, OFFSET resultMsg    ; Load address of resultMsg
    MOV AH, 09h                 ; DOS function to display a string
    INT 21h                     ; Call DOS interrupt to print the message

    ; Display the sum
    MOV DX, OFFSET sumRes       ; Load address of sumRes
    MOV AH, 09h                 ; DOS function to display a string
    INT 21h                     ; Call DOS interrupt to print the result

    ; End program
    MOV AH, 4Ch                 ; DOS terminate program function
    INT 21h                     ; Call DOS interrupt to exit

MAIN ENDP
END MAIN