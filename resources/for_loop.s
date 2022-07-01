; nasm -felf64 for_loop.s && ld -m elf_x86_64 -o ex01 for_loop.o && ./ex01

; from the crash course, augmented
; pseudocode:
; for (int x  = 0; x < 5; x++)
;   print x

global _start

section .bss
    out_char resb 2
 
section .text

; rax, rbx, rcx, rdx - params for sys_write
; rdi - loop counter
; r8 - digit to print

_start:
    xor rdi, rdi ; zeroing edi to serve as loop counter
    mov byte [out_char+8], 0xa

for_loop:
    mov r8, rdi ; save current loop x to r8
    add r8, 48  ; translate digit to ascii
    mov byte [out_char], r8b
    mov rdx, 2  ; printing two bytes
    mov rcx, [out_char] ; pointer to ascii char
    mov rbx, 1  ; stdout
    mov rax, 4  ; sys_write
    int 0x80
    ; we could add write success check here
    inc rdi
    cmp rdi, 5
    jl  for_loop

exit:
    mov rax, 1
    xor rbx, rbx
    int 0x80