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
s1 db 1, 3, 6, 2, 3, 7
l equ $-s1
s2 db 6, 3, 8, 1, 2, 5
d times l db 0
; the program code will be part of a segment called code
segment code use32 class=code
start:
; Two byte strings S1 and S2 are given, having the same length. Obtain the string D so that each element of D represents the maximum of the corresponding elements from S1 and S2.

mov ESI, 0
mov EDI, 0
mov ECX, l

max_check_loop:
    mov AL, [s1+ESI]
    mov BL, [s2+ESI]
    cmp AL, BL
    JL s1_max
    mov [d+EDI], AL
    jmp loop_rep
    s1_max:
    mov [d+EDI], BL
    loop_rep:
    inc ESI
    inc EDI
loop max_check_loop
    ; call exit(0) ), 0 represents status code: SUCCESS
    push dword 0 ; saves on stack the parameter of the function exit
    call [exit] ; function exit is called in order to end the execution of the program