; y = 3 * a + b ^ 2


section	.text
  global _start        ;must be declared for using gcc

_start:	                 
  mov	edx, len ;message length
  mov	ecx, msg ;message to write
  call print

  ; mov bx, [number_len]
  ; dec bx
  ; mov [number_len], bx
  mov bx, [number]
print_num:  
  ; pop bx
  call power_10 
  mov bx, ax
  mov ax, [number]
  div bx
  mov [number], dx
  ; mov ax, dx
  call print_digit
  mov dx, [number_len]
  cmp dx, 0
  jne print_num



  mov	eax, 1
  int	0x80

power_10:
  mov ecx, 1
  mov ax, 1
  mov bx, 10
  power_loop:
    mul bx
    inc ecx
    cmp ecx, [number_len]
    jl power_loop
  mov bx, [number_len]
  dec bx
  mov [number_len], bx
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

  number dw 4523
  number_len db 4

segment .bss
  num resb 5


  