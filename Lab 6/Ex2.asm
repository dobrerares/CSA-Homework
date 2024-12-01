bits 32 ; assembling for the 32-bit architecture
global start

extern exit
import exit msvcrt.dll

segment data use32 class=data
s dw 1432h, 8675h, 0ADBCh
len equ ($ - s) / 2
d resd len * 2

segment code use32 class=code
; An array of words is given. Write an asm program in order to obtain an array of doublewords, where each doubleword will contain each nibble unpacked on a byte (each nibble will be preceded by a 0 digit), arranged in an ascending order within the doubleword.
start:
    mov ecx, len
    jecxz programend
    mov esi, s
    mov edi, d
    cld

main:
    mov eax, 0
    lodsw                  ; Load word from [esi] into ax
    mov ebx, eax           ; Copy eax to ebx for manipulation

    ; Unpack nibbles
    mov al, bl             ; al = low byte of bl
    and al, 0x0F           ; al = low nibble of low byte
    mov ah, bl
    shr ah, 4              ; ah = high nibble of low byte
    mov dl, bh             ; dl = high byte of bl
    and dl, 0x0F           ; dl = low nibble of high byte
    mov dh, bh
    shr dh, 4              ; dh = high nibble of high byte

    ; Sort the nibbles: [al, ah, dl, dh]
    cmp al, ah
    jbe no_swap1
    ; Swap al and ah using XOR
    xor al, ah
    xor ah, al
    xor al, ah
no_swap1:
    cmp ah, dl
    jbe no_swap2
    ; Swap ah and dl using XOR
    xor ah, dl
    xor dl, ah
    xor ah, dl
no_swap2:
    cmp dl, dh
    jbe no_swap3
    ; Swap dl and dh using XOR
    xor dl, dh
    xor dh, dl
    xor dl, dh
no_swap3:
    cmp al, ah
    jbe no_swap4
    ; Swap al and ah using XOR
    xor al, ah
    xor ah, al
    xor al, ah
no_swap4:
    cmp ah, dl
    jbe no_swap5
    ; Swap ah and dl using XOR
    xor ah, dl
    xor dl, ah
    xor ah, dl
no_swap5:
    cmp al, ah
    jbe sorted
    ; Swap al and ah using XOR
    xor al, ah
    xor ah, al
    xor al, ah
sorted:
    ; Pack the sorted nibbles into a doubleword
    mov ebx, 0
    mov bl, al
    shl ebx, 8
    mov bl, ah
    shl ebx, 8
    mov bl, dl
    shl ebx, 8
    mov bl, dh

    ; Store the result
    mov eax, ebx
    stosd                  ; Store eax at [edi] and increment edi
    loop main

programend:
    call exit