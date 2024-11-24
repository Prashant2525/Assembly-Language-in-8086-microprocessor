.MODEL SMALL
.STACK 100h

.DATA
    inputStr DB 'ABCD$', 0      ; Define a string with uppercase letters, ending with '$'
    outputStr DB 5 DUP('?')      ; Define an output buffer for the lowercase result

.CODE
MAIN PROC
    MOV AX, @DATA               ; Load the data segment address
    MOV DS, AX                  ; into DS register
    MOV ES, AX                  ; Also set ES register for output

    ; Initialize pointers
    LEA SI, inputStr            ; Load address of inputStr into SI
    LEA DI, outputStr           ; Load address of outputStr into DI

CONVERT_LOOP:
    MOV AL, [SI]                ; Load the next character from inputStr
    CMP AL, '$'                 ; Check for the end of the string
    JE DISPLAY_OUTPUT           ; If '$' is found, end the loop

    ; Check if AL is an uppercase letter
    CMP AL, 'A'                 ; Compare AL with 'A'
    JL NEXT_CHAR                ; If AL < 'A', skip conversion
    CMP AL, 'Z'                 ; Compare AL with 'Z'
    JG NEXT_CHAR                ; If AL > 'Z', skip conversion

    ; Convert to lowercase by adding 32
    ADD AL, 20h                 ; 20h (hex) is equivalent to 32 in decimal

NEXT_CHAR:
    MOV [DI], AL                ; Store the converted character in outputStr
    INC SI                      ; Move to the next character in inputStr
    INC DI                      ; Move to the next position in outputStr
    JMP CONVERT_LOOP            ; Repeat the loop

DISPLAY_OUTPUT:
    MOV BYTE PTR [DI], '$'      ; Add string terminator at the end of outputStr

    ; Display the lowercase string
    LEA DX, outputStr           ; Load address of outputStr into DX
    MOV AH, 09h                 ; DOS function to display a string
    INT 21h                     ; Call DOS interrupt to print the string

    ; End program
    MOV AH, 4Ch                 ; DOS terminate program function
    INT 21h                     ; Call DOS interrupt to exit

MAIN ENDP
END MAIN
