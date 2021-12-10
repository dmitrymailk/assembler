; y = 3 * a + b ^ 2


section	.text
  global _start        ;must be declared for using gcc

_start:	                 
  mov	edx, len ;message length
  mov	ecx, msg ;message to write
  call print

  mov bx, [number]
  push bx
  call power_10 
  mov bx, ax
  pop ax
  div bx


  call print_num



  mov	eax, 1
  int	0x80

power_10:
  mov ecx, [number_len]
  dec ecx
  mov ax, 1
  mov bx, 10
  cmp ecx, 0
  jle zero_code
  
  power_loop:
    mul bx
  loop power_loop
  
  zero_code:
  ret

print:
  mov	ebx, 1 ;file descriptor (stdout)
  mov	eax, 4 ;system call number (sys_write)
  int	0x80 ;call kernel
  ret

print_num:
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

  number dw 401
  number_len db 3

segment .bss
  num resb 5


  