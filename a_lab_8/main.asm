; y = 3 * a + b ^ 2


section	.text
  global _start        ;must be declared for using gcc

_start:	                 
  mov	edx, len ;message length
  mov	ecx, msg ;message to write
  mov	ebx, 1 ;file descriptor (stdout)
  mov	eax, 4 ;system call number (sys_write)
  int	0x80 ;call kernel


  mov ecx, a_len
  mov eax, 3

  mov eax, temp
  mov ebx, 10
  div ebx
  add eax, '0'
  ; mov esi, 0 
  ; dec esi

l1:
  ;---
  ; mov	eax, [a+esi]
  ; inc esi
  ;---

  ; sub ax, '0'

  ; mov bl, '2'
  ; sub bl, '0'
  ; div bl
  ;---

  mov [num], eax
  mov eax, 4
  mov ebx, 1
  push ecx ; save counter

  mov ecx, num        
  mov edx, 1        
  int 0x80 ; print 'num'

  ; mov eax, [num]
  ; sub eax, '0'
  ; inc eax
  ; add eax, '0'
  pop ecx ; return counter
  loop l1


  mov	eax, 1	        ;system call number (sys_exit)
  int	0x80	        ;call kernel


print_num:
  mov	edx, 1 ;message length
  mov	ecx, [num] ;message to write
  mov	ebx, 1 ;file descriptor (stdout)
  mov	eax, 4 ;system call number (sys_write)
  int	0x80 ;call kernel
  ret

section	.data
  msg db 'Start program',0xa	
  len equ $ - msg		

  a db '56'
  a_len equ $ - a

  b db '15'
  b_len equ $ - b
  temp db 123

segment .bss
  num resb 1


  