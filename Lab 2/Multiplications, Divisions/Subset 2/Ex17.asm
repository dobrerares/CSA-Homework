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
d db 13
f dw 15
g dw 16
h dw 17
; the program code will be part of a segment called code
segment code use32 class=code
start:
; ...
; h/a + (2 + b) + f/d – g/c
mov AX, [h]
mov BL, [a] 
div BL ; h/a in AL
mov DL, AL

mov BL, 2
add BL, [b] ; 2+b in BL
add DL, BL ; h/a + (2+b) in DL

mov AX, [f]
mov BL, [d]
div BL ; f/d in AL
add DL, AL; h/a + (2+b) + f/d in DL

mov AX, [g]
mov BL, [c]
div BL ; g/c in AL
sub DL, AL ; h/a + (2 + b) + f/d – g/c in DL
    ; call exit(0) ), 0 represents status code: SUCCESS
    push dword 0 ; saves on stack the parameter of the function exit
    call [exit] ; function exit is called in order to end the execution of the program