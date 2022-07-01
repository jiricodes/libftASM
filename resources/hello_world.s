; nasm -felf64 hello_world.s && ld -m elf_x86_64 -o hello hello_world.o && ./hello
global _start

section .data
    msg db "Hello world", 0 ;msg is an address poiting to 'H'
    len equ $ - msg ; $ is current location,

section .text
_start:
    mov rdx, len
    mov rcx, msg
    mov rbx, 1
    mov rax, 4
    int 0x80
    mov rax, 1
    int 0x80