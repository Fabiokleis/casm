; /usr/include/asm/unistd_64.h
BITS 64

%define SYS_exit 60 
%define SYS_write 1 
%define SYS_read 0 
%define SYS_open 2
%define SYS_close 3
%define STDOUT 1 
%define STDIN 0
%define NULL 0

; GPR (Registradores de proposito geral)
; IA-16 -> 16 bits
; E -> extended 32 bits - IA-32
; R -> re-extended 64 bits - x86-64

; Command line Arguments ref 16.0 - x86-64 Assembly Language Programming with ubuntu
; argv -> quadword address vector
; rdi = argc
; rsi = argv

section .text 

print_string:
    push rbp ; coloca na stack o base pointer
    mov rbp, rsp ; coloca o stack pointer no base pointer
    push rbx ; coloca na stack o endereço inicial

    ; conta o numero de caracteres na string
    mov rbx, rdi ; coloca no pointeiro base o endereço de destino - Destination Index
    mov rdx, NULL ; coloca o byte nulo dentro do Data - registrador de data
    call str_count_loop

str_count_loop:
    cmp byte [rbx], NULL ; compara o valor contido no endereço inicial com byte nulo
    je str_count_done ; se for igual pula para o layout que acabou a string
    inc rdx ; incrementa para o proximo byte do registrador data
    inc rbx ; incrementa a posicao do endereço inicial 
    jmp str_count_loop ; volta para o inicio do label até percorrer a string toda

print_loop:
    mov rdi, qword [r13+rbx*8]
    call print_string

    mov rdi, 0xa
    call print_string

    inc rbx
    cmp rbx, r12
    jl print_loop ; se for menor

prt_done:
    pop rbx
    pop rbp
    ret

str_count_done:
    cmp rdx, 0
    je prt_done
    ; print string
    mov rax, SYS_write
    mov rsi, rdi
    mov rdi, STDOUT
    syscall

get_argv_file_name:
    mov rdi, 0xa ; coloca dentro do destination index o byte de quebra de linha 
    call print_string ; chama a funcao para mostrar a string passada via argv
    mov rbx, NULL ; coloca dentro do endereço base o byte nulo


global _start ; definimos um local para o linker chamar o inicio do programa
_start:
    call get_argv_file_name ; pega o nome do arquivo via argv
    mov rax, SYS_write
    mov rdi, STDOUT
    mov rsi, hw
    mov rdx, hw_sz
    syscall

    mov rax, SYS_exit
    xor rdi, rdi ; valor de retorno de sucesso pro shell 0
    syscall

section .data
hw: db "file type: "
hw_sz: equ $-hw
