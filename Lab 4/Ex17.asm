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
a dw 1010110111010011b
b db 00100101b
c dd 0
; the program code will be part of a segment called code
segment code use32 class=code
start:
; ...
mov ECX, 0
mov AL, 00001111b
or CL, AL
;the bits 0-3 of C have the value 1

mov AX, [a]
mov DL, 00001111b
and DL, AL
shl DL, 4
or CL, DL
;the bits 4-7 of C are the same as the bits 0-3 of A

mov CH, 0
; the bits 8-13 of C have the value 0
; The bits 14 and 15 also have the value 0 now but they will be overwritten

mov EDX, 0
mov DX, 0011111111110000b
and DX, AX
shl EDX, 10
or EDX, ECX
; the bits 14-23 of C are the same as the bits 4-13 of A

mov EDX, 0
mov DL, 11111100b
shl EDX, 22
or ECX, EDX
; the bits 24-29 of C are the same as the bits 2-7 of B

mov EDX, 00000011b
shl EDX, 30
or ECX, EDX
; the bits 30-31 have the value 1

mov [c], ECX
    ; call exit(0) ), 0 represents status code: SUCCESS
    push dword 0 ; saves on stack the parameter of the function exit
    call [exit] ; function exit is called in order to end the execution of the program