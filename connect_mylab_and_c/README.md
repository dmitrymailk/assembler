```
nasm -felf64 calc_numbers.asm && gcc -no-pie test.c calc_numbers.o && ./a.out
```

```
nasm -felf64 calc_numbers.asm && ld calc_numbers.o -o calc_numbers.out && ./calc_numbers.out
```
