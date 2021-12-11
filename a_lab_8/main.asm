; y = 3 * a + b ^ 2


section	.text
  global _start        ;must be declared for using gcc

_start:	                 
  mov	edx, len ;message length
  mov	ecx, msg ;message to write
  call print

; program doesn't work for digits, it's only for numbers 
print_num:  
  call power_10
  mov bx, ax
  mov ax, [number]
  div bx
  mov [number], dx
  call print_digit
  mov dx, [number_len]
  cmp dx, 1
  jne print_num

  mov ax, [number]
  call print_digit

  mov	eax, 1
  int	0x80

power_10:
  mov ecx, 1
  mov ax, 1
  mov bx, 10
  cmp ecx, [number_len]
  je power_end
  power_loop:
    mul bx
    inc ecx
    cmp ecx, [number_len]
    jl power_loop
  mov bx, [number_len]
  dec bx
  mov [number_len], bx
  power_end:
  ret


print:
  mov	ebx, 1 ;file descriptor (stdout)
  mov	eax, 4 ;system call number (sys_write)
  int	0x80 ;call kernel
  ret

print_digit:
  ; mov eax, 6
  add ax, '0'
  mov [num], ax
  mov ecx, num
  mov edx, 1
  mov	ebx, 1 ;file descriptor (stdout)
  mov	eax, 4 ;system call number (sys_write)
  int	0x80 ;call kernel
  ret



section	.data
  msg db 'Start program', 0xa	
  len equ $ - msg		

  number dw 21
  number_len db 2

segment .bss
  num resb 5


  