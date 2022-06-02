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

section .data
hw: db "file type: "
hw_sz: equ $-hw
new_line: db 0xa, NULL

section .text 

global main:
main:
    mov r12, rdi ; salva o argc
    mov r13, rsi ; salva o argv
   
print_argvs:
    mov rdi, new_line ; coloca dentro do destination index o quebra linha e o byte nulo 
    call print_string ; chama a funcao para mostrar a string passada via argv 
    mov rbx, 0
print_loop:
    mov rdi, qword [r13+rbx*8] ; vai para o proximo endereço de rdi que contem a argv
    call print_string 
    mov rdi, new_line 
    call print_string
    inc rbx ; icrementa o rbx para o proximo arg, pois no inicio printamos o argv 0
    cmp rbx, r12 ; compara o argc com o valor contido em rbx para verificar se acabou
    jl print_loop ; se for menor ele volta 
example_done:
    mov rax, SYS_exit
    mov rdi, 0
    syscall

; rotina para mostrar na tela uma determinada string
global print_string:
print_string:
    push rbp ; coloca na stack o base pointer
    mov rbp, rsp ; coloca o stack pointer no base pointer
    push rbx ; coloca na stack o endereço inicial

    ; conta o numero de caracteres na string
    mov rbx, rdi ; coloca no pointeiro base o endereço de destino - Destination Index
    mov rdx, 0
str_count_loop:
    cmp byte [rbx], NULL; compara o valor contido no endereço inicial com byte nulo
    je str_count_done ; se for igual pula para o layout que acabou a string
    inc rdx ; incrementa para o proximo byte do registrador data
    inc rbx ; incrementa a posicao do endereço inicial 
    jmp str_count_loop ; volta para o inicio do label até percorrer a string toda
str_count_done:
    cmp rdx, 0 ; verfica se o valor contido no registrador data é 0
    je prt_done ; se for igual vai para o final, se nao ele mostra na tela
    ; print string
    mov rax, SYS_write ; syscall write do linux
    mov rsi, rdi ; escreve a string no registrador source index
    mov rdi, STDOUT ; file descriptor para escrever na tela 
    syscall
prt_done:
    pop rbx
    pop rbp
    ret
