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
b dw 11
c dd 12
d dq 13
; the program code will be part of a segment called code
segment code use32 class=code
start:
; ...
; (c+d-a)-(d-c)-b

mov EAX, [c]
mov EDX, 0
sub EAX, [d+0]
sbb EDX, [d+4]
clc
mov ECX, 0
mov CL, [a]
sub EAX, ECX
sbb EDX, 0 ; (c+d-a) in EDX:EAX
mov EBX, [d+0]
mov ECX, [d+4]
clc
sub EBX, [c]
sbb ECX, 0
clc
sub EAX, EBX
sbb EDX, ECX ; (c+d-a)-(d-c) in EDX:EAX
mov EBX, 0
clc
mov BX, [b]
sub EAX, EBX
sbb EDX, 0
; final result in EDX:EAX
    ; call exit(0) ), 0 represents status code: SUCCESS
    push dword 0 ; saves on stack the parameter of the function exit
    call [exit] ; function exit is called in order to end the execution of the program