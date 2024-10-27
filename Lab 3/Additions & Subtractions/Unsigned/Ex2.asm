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
r resq 1
; the program code will be part of a segment called code
segment code use32 class=code
start:
; ...
;(b+b)+(c-a)+d
mov EBX, 0
mov BX, [b]
add BX, [b] ; (b+b) in BX
mov ECX, [c] 
mov EAX, 0
mov AL, [a]
sub ECX, EAX ; (c-a) in ECX
add EBX, ECX ; (b+b)+(c-a) in EBX

mov EAX, EBX
mov EDX, 0
mov EBX, dword [d+0]
mov ECX, dword [d+4]

clc

add EAX, EBX
adc EDX, ECX
mov dword [r+0], EAX
mov dword [r+4], EDX

    ; call exit(0) ), 0 represents status code: SUCCESS
    push dword 0 ; saves on stack the parameter of the function exit
    call [exit] ; function exit is called in order to end the execution of the program