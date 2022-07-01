section .data ;define constant variables (immutable)
; strings, magic numbers, terminating strings ...

section .bss ; reserving space in memory for future data

section .text; actual code
; label - marked address in memory
;   - always has either _start or main at least for executable

; nasm -felf64 -g file.asm > file.o
; linking:
;       ld -m elf_x86_64 -o file file.o
;           - needs `_start`
;
;       gcc
;           - needs `main`

; Registers
; ecx (rcx) - is usually used for counters (e.g. loop)
; eax (rax) - "accumulator" used to store arithmetic results
; esi & edi (rsi, rdi) - primarily used for copying large pieces of data
;                        - esi source & edi destination

; Two pointers to the stack
; esp (rsp) - top (moved as data added / removed from the stack)
; ebp (rbp) - base / bottom - reference to the stack size
;           if esp and ebp point to the same address the stack is empty

; Instructions
; mov dest, src - moving data from src to dest
; movzx eax, 3 - zero rest of the memory that is not used (3 uses only 2 bits)
; movzx eax, byte ptr [ebx] - one byte from address at ebx, however eax is 4bytes, so we zero out thre rest
; [] - dereferencing
; movsx dest, src - signed zeroing

; and dest, src
; or, xor, test (==)
; test eax, eax ; check whether eax == 0

; add eax, ebx ; eax = eax + ebx
; sub eax, 15 ; eax = eax - 15


; mov ax, 15
; mul bx ; dx:ax = ax * bx
; div bx ; ax Rdx = dx:ax / bx

; Flags register
; register with specific meaning bits
; CF = carry (1, 0)
; OF = oveflow flag
; ZF = zero flag, if end of the operation is zero then ZF = 1
; SF = sign flag - negative or positive result / sign change?
; PF = parity (even = 1, odd = 0)

; JUMP instructions
; jmp label - jumps to given lavel
; je label - "jump equal" if previous operation resulted in two things equiling each other (aka ZF = 1)
; jne label - "jump not equal"
; jz - jump zero
; jc - jump carry
; jo - jump oveflow
; jg - jump greater
; js - jump sign flag
; jge - jump greater than equal
; jl - jump less
; ja - jump above
; jae - jump above equal
; jb/jbe - jump below / equal
; Add n to any of these to get the opposite

; CALL instruction
; call label - saves current location in the code, so we can return back to it
;      push rip - pushes current instruction pointer to the stack
;       jmp label
;
; ret - returns to stacked RIP 
;   pop rip - pops value from the stack and saves it rip, rip gets updated after this operation and therefore we return to the saved state + 1

; CMP instruction
; cmp a, b - compare a to b, where a and b can be anything - register, address, value ...
;           - it does eax - ebx, but doesn't save the result, only updates register

; Shifting
; shr eax, 1 - shift right /div 2
; shl eax, 1 - shift left /mul 2
; example:
;   mov eax, 0b11110000
;   shl eax, 1  ; eax is now 0b11100000 and CF = 1
;
; sar eax, 1- signed arithmetic right, keeps the sign
; sal
; examples:
; eax: 11110000
; sar: 11111000
; sal: 11100000
;
; eax: 01000111
; sar: 00100011
; sal: 00001111
;
; ror, rol -> rotate right and left

; Masking
; Example
; mov eax, 10101010101010101010101010101010 ; we want to access the upper 16 bits (the lower is AL)
; and eax, 0xFFFF0000 ; this will result in 10101010101010100000000000000000
; then we can shift for example (I mean we could've shifted already at the first step in this case since shift adds zeroes)
; but extracting e.g. only 8 bits from the middle, we could use 0x000FF000 etc

; System calls
; int 80h - interrupt for the kernel (hardware interrupt vs raising flag)
; the system figures out what to do, based on the state of the registers
; eax is enumerator for syscalls (e.g eax = 1 is sys_exit, etc)
; ebx, ecx, edx, esx, edi are params
; 
; write example:
; mov edx, len  ;.data variable
; mov ecx, msg  ;.data variable
; mov ebx, 1    ; stdout
; mov eax, 4    ; sys_write
; int 0x80      ; interrupt
;
; this works only if there's kernel present

