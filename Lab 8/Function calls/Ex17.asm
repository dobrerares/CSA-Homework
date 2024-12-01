bits 32 ;assembling for the 32 bits architecture
global start

; we ask the assembler to give global visibility to the symbol called start
;(the start label will be the entry point in the program)
extern exit, scanf, printf ; we inform the assembler that the exit symbol is foreign; it exists even if we won't be defining it
import exit msvcrt.dll  ; we specify the external library that defines the symbol
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
import printf msvcrt.dll
import scanf msvcrt.dll

; our variables are declared here (the segment is called data)
segment data use32 class=data
; ...
a dd 0
format db "%d", 0
message db "result=%x", 0
; the program code will be part of a segment called code
segment code use32 class=code
start:
; ...
; Read a number in base 10 from the keyboard and display the value of that number in base 16
push dword a ; saves on stack the address of the variable a
push dword format ; saves on stack the address of the format string
call [scanf] ; function scanf is called in order to read a number from the keyboard
add esp, 4*2 ; cleans the stack

; Display the value of the number in base 16
push dword [a] ; saves on stack the value of the variable a
push dword message ; saves on stack the address of the message string
call [printf] ; function printf is called in order to display the value of the number in base 16
add esp, 4*2 ; cleans the stack



    ; call exit(0) ), 0 represents status code: SUCCESS
    push dword 0 ; saves on stack the parameter of the function exit
    call [exit] ; function exit is called in order to end the execution of the program