.MODEL SMALL
.STACK 100h

.DATA
    message DB 'Hello, World!$'    ; Define the string to print with '$' as the end marker

.CODE
MAIN PROC
    MOV AX, @DATA                  ; Load the data segment address
    MOV DS, AX                     ; into DS register

    LEA DX, message                ; Load the address of the string into DX
    MOV AH, 09h                    ; Function to display a string (INT 21h, AH=09h)
    INT 21h                        ; Call DOS interrupt to print the string

    MOV AH, 4Ch                    ; DOS terminate program function
    INT 21h                        ; Call DOS interrupt to exit

MAIN ENDP
END MAIN
