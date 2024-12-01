bits 32 ; assembling for the 32 bits architecture
global start

; we ask the assembler to give global visibility to the symbol called start
; (the start label will be the entry point in the program)
extern exit, scanf, printf ; we inform the assembler that the exit symbol is foreign; it exists even if we won't be defining it
import exit msvcrt.dll  ; we specify the external library that defines the symbol
        ; msvcrt.dll contains exit, printf and all the other important C-runtime functions
import scanf msvcrt.dll
import printf msvcrt.dll

; our variables are declared here (the segment is called data)
segment data use32 class=data
    a dd 0
    b dd 0
    format db "%d %d", 0
    result dd 0
    message db "result=%d", 0

; the program code will be part of a segment called code
segment code use32 class=code
start:
    ; Read two integers
    push dword b
    push dword a
    push dword format
    call [scanf]
    add esp, 4*3

    ; Perform integer division
    mov eax, [a]
    cdq
    mov ecx, [b]
    idiv ecx
    mov [result], eax

    ; Print the result
    push dword [result]
    push dword message
    call [printf]
    add esp, 4*2

    ; Call exit(0)
    push dword 0
    call [exit]