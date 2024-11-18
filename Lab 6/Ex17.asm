bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data
    s dd 0x12345678, 0x1256ABCD, 0x12AB4344
    len equ ($ - s) / 4
    d resd len

segment code use32 class=code
start:
    ; Extract low words from s into d
    mov esi, s
    mov edi, d
    mov ecx, len
extract_low_words:
    mov eax, [esi]
    and eax, 0xFFFF
    mov [edi], eax
    add esi, 4
    add edi, 4
    loop extract_low_words

    ; Bubble sort the low words in descending order
    mov ecx, len
bubble_sort:
    dec ecx
    jz sort_done
    mov esi, d
    mov edi, d
    add edi, 4
    mov ebx, ecx
inner_loop:
    mov eax, [esi]
    mov edx, [edi]
    cmp eax, edx
    jge no_swap
    ; Swap the values
    mov [esi], edx
    mov [edi], eax
no_swap:
    add esi, 4
    add edi, 4
    dec ebx
    jnz inner_loop
    jmp bubble_sort
sort_done:

    ; Store the sorted low words back into s
    mov esi, s
    mov edi, d
    mov ecx, len
store_sorted_low_words:
    mov eax, [esi]
    and eax, 0xFFFF0000
    mov edx, [edi]
    or eax, edx
    add esi, 4
    stosd
    loop store_sorted_low_words




    ; Exit the program
    call [exit]

