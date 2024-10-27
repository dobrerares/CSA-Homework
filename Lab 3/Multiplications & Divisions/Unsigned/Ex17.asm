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
b dd 11
c db 12
x dq 1000
; the program code will be part of a segment called code
segment code use32 class=code
start:
; ...
; x-(a*a+b)/(a+c/a); a,c-byte; b-doubleword; x-qword
mov AX, 0
mov AL, [c]
div byte [a]
mov BX, [a]
add BL, AL ; (a+c/a) in BL
mov EAX, 0
mov AL, [a]
mul byte [a]
add AX, [b]
div BL
mov ECX, 0
mov CL, AL
mov EAX, [x+0]
mov EDX, [x+4]
clc
sub EAX, ECX
sbb EDX, 0
; result in EDX:EAX

    ; call exit(0) ), 0 represents status code: SUCCESS
    push dword 0 ; saves on stack the parameter of the function exit
    call [exit] ; function exit is called in order to end the execution of the program