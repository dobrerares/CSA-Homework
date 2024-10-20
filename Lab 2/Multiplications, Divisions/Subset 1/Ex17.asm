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
d dw 26
; the program code will be part of a segment called code
segment code use32 class=code
start:
; ...
;300-[5*(d-2*a)-1]
mov AL, [a]
mov BL, 2
mul BL
sub [d], AX
mov AX, [d]
mov BX, 5
imul BX ; used imul because result is negative
push DX
push AX
pop EBX
sub EBX, 1
mov EAX, 300
sub EAX, EBX
    ; call exit(0) ), 0 represents status code: SUCCESS
    push dword 0 ; saves on stack the parameter of the function exit
    call [exit] ; function exit is called in order to end the execution of the program