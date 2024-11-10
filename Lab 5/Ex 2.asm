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
s db '+', '4', '2', 'a', '@', '3', '$', '*'
l equ $-s
special db '!', '@', '#', '$', '%', '^', '&', '*'
ls equ $-special
d times l db 0
; the program code will be part of a segment called code
segment code use32 class=code
start:
; Given a character string S, obtain the string D containing all special characters (!@#$%^&*) of the string S.
mov ECX, l
mov ESI, 0
mov EDI, 0
jecxz programend

stringloop:
    mov BL, [s+ESI]
    jmp special_check
    string_loop_cont:
    inc esi
loop stringloop

jmp programend

special_check:

mov EDX, ECX
mov ECX, ls

special_loop:
    mov AL, [special+ECX]
    cmp BL, AL
    JNE skip_concat
    mov [d+EDI], al
    inc EDI
    skip_concat:
loop special_loop
mov ECX, EDX
jmp string_loop_cont

programend:
    ; call exit(0) ), 0 represents status code: SUCCESS
    push dword 0 ; saves on stack the parameter of the function exit
    call [exit] ; function exit is called in order to end the execution of the program