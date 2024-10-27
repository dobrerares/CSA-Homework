bits 32 ;assembling for the 32 bits architecture
global start

; we ask the assembler to give global visibility to the symbol called start
;(the start label will be the entry point in the program)
extern exit ; we inform the assembler that the exit symbol is foreign; it exists even if we won't be defining it
import exit msvcrt.dll  ; we specify the external library that defines the symbol
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions

; our variables are declared here (the segment is called data)
segment data use32 class=data
; ...
a db 10
b db 11
c db 12
d dd 13
e dq 14
; the program code will be part of a segment called code
segment code use32 class=code
start:
; ...
; 2/(a+b*c-9)+e-d; a,b,c-byte; d-doubleword; e-qword
mov EAX, 0
mov AL, [b]
mul byte [c]
mov EBX, 0
mov BL, [a]
add EBX, EAX
sub EBX, 9 ; (a+b*c-9) in EBX
mov EDX, 0
mov EAX, 2
div EBX ; 2/(a+b*c-9) in EAX
mov EDX, 0
clc
add EAX, [e]
adc EDX, 0
clc
sub EAX, [d]
sbb EDX, 0
; result in EDX:EAX
    ; call exit(0) ), 0 represents status code: SUCCESS
    push dword 0 ; saves on stack the parameter of the function exit
    call [exit] ; function exit is called in order to end the execution of the program