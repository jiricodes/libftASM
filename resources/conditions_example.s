; nasm -felf64 conditions_example.s && ld -m elf_x86_64 -o ex00 conditions_example.o && ./ex00

; from the crash course, augmented
; pseudocode:
; int x;
; int a = 4
; int b = 5
; int c = 0
;
; if x == a:
;       c = a
; else if x == b
;       c = b
; else
;       c = 1

global _start

section .data
    a equ 4
    b equ 5
    x equ 5

section .text
_start:
    mov rax, 0 ; c
    mov rbx, x
    mov rcx, a
    mov rdx, b
    cmp rbx, rcx
    je if   ; x == a
    cmp rbx, rdx
    je elif ; x == b

else:
    mov rax, 1

return:
    mov rbx, rax ; hack to set the result as exit code, we can then do echo $? to extract it on cmd line
    mov rax, 1
    int 0x80

if:
    mov rax, a
    jmp return

elif:
    mov rax, b
    jmp return

