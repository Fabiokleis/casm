# Casm
Uma "`implementação`" simples em assembly do comando cat do linux.
Para mais informações sobre o comando cat

```
man cat
```

# Help
Para gerar o arquivo objeto foi utilizado o montador [nasm](https://www.nasm.us).
O binário esta sendo linkado com [gcc](https://gcc.gnu.org).

### Para gerar o binário
```
make
```

### Rodar
O casm aceita múltiplos argumentos, podendo passar uma lista de arquivos separados por espaco via argv, 
ou rodar vazio. Se o argumento passado não possuir um arquivo correspondente, simplesmente é mostrado
na tela o argumento.

```
./out/casm 

./out/casm /etc/passwd 

./out/casm Makefile ./src/casm.asm # quantos quiser
```


# Referências

### x86-64 Assembly Language Programming with Ubuntu
http://www.egr.unlv.edu/%7Eed/assembly64.pdf

### Gitbook de fundamentos do assembly x86-64 com nasm do portal [mente binaria](https://www.mentebinaria.com.br)
https://mentebinaria.gitbook.io/assembly/

### Referência rápida do nasm 
https://www.cs.uaf.edu/2017/fall/cs301/reference/x86_64.html

### Linux Programmer's Manual - syscall(2)
https://man7.org/linux/man-pages/man2/syscall.2.html#NOTES

### Entendendo syscalls
https://mentebinaria.gitbook.io/assembly/a-base/syscall-no-linux

### Procure por syscalls neste site
https://filippo.io/linux-syscall-table/

### Como tutorial de como ler arquivos (além de ter também no livro)
https://fasterthanli.me/series/reading-files-the-hard-way/part-2
