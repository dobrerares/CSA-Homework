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
b dw 1110101100100101b
c dd 0
; the program code will be part of a segment called code
segment code use32 class=code
start:
; ...
mov ECX, 0
mov DX, 00000001_11100000b
and DX, [b]
shr DX, 5
or CX, DX
; the bits 0-3 of C are the same as the bits 5-8 of B

mov DX, 00000000_00011111b
and DX, [a]
shl DX, 4
or CX, DX
; the bits 4-8 of C are the same as the bits 0-4 of A

mov DX, 00011111_11000000b
and DX, [a]
shl DX, 3
or CX, DX
; the bits 9-15 of C are the same as the bits 6-12 of A


mov EBX, 0
mov BX, [b]
shl EBX, 16
or ECX, EBX
; the bits 16-31 of C are the same as the bits of B


mov [c], ECX
    ; call exit(0) ), 0 represents status code: SUCCESS
    push dword 0 ; saves on stack the parameter of the function exit
    call [exit] ; function exit is called in order to end the execution of the program