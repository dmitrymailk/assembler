; aaa instruction https://docs.oracle.com/cd/E19455-01/806-3773/instructionset-52/index.html

section	.text
  global _start        ;must be declared for using gcc

_start:	                ;tell linker entry point

  mov esi, 4 ;pointing to the rightmost digit
  mov ecx, 5 ;num of digits
  clc ; clear CF flag
add_loop:  
  mov 	ax, [num1 + esi] ; set ax by num[esi] number
  adc 	ax, [num2 + esi] ; Destination = Destination + Source + CF;
  aaa ; checking decimal overflow, add 1 to ah if overflow and set CF = 1 else CF = 0, doesn't work on x86
  pushf
  or 	ax, 30h
  popf

  mov	[sum + esi], ax
  dec	esi
  loop	add_loop

  mov	edx, len ;message length
  mov	ecx, msg ;message to write
  mov	ebx, 1 ;file descriptor (stdout)
  mov	eax, 4 ;system caxl number (sys_write)
  int	0x80 ;caxl kernel

  mov	edx,5	        ;message length
  mov	ecx,sum	        ;message to write
  mov	ebx,1	        ;file descriptor (stdout)
  mov	eax,4	        ;system caxl number (sys_write)
  int	0x80	        ;caxl kernel

  mov	eax,1	        ;system caxl number (sys_exit)
  int	0x80	        ;caxl kernel

section	.data
  msg db 'The Sum is:',0xa	
  len equ $ - msg			
  num1 db '12345'
  num2 db '23456'
  sum db '     '