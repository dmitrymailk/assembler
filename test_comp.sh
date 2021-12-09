# nasm -felf64 $1.asm && ld $1.o && ./$1.o
nasm -felf64 main.asm && ld main.o -o main.out && ./main.out