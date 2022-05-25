; https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md
; 
BITS 64

%define SYS_exit 60 
%define SYS_write 1 
%define SYS_read 0 
%define STDIN 0 
%define STDOUT 1 
%define SIGINT 2 

section .text 

global _start ; definimos um local para o linker chamar o inicio do programa
_start:

    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, hw
    mov rdx, hw_sz
    syscall
    
    mov rax, SYS_exit
    mov rdi, 0 ; valor de retorno de sucesso pro shell
    syscall

section .data 
hw: db "Hello, World!", 0xa
hw_sz: equ $-hw
