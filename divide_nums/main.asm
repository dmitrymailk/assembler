section	.text
   global _start    ;must be declared for using gcc
	
_start:             ;tell linker entry point
  ;  mov	ax,'8'
  ;  sub  ax, '0'
  mov ax, 1

	
  ;  mov 	bl, '2'
  ;  sub  bl, '0'
  mov bl, 1
  div bl
  ; add	ax, '0'
  ; ax - quotient
  ; ah - reminder
  ; 65 is A
  ; 56 is 8
  add ax, '0'
  mov [res], ax
  mov	ecx, msg	
  mov	edx, len
  mov	ebx, 1	;file descriptor (stdout)
  mov	eax, 4	;system call number (sys_write)
  int	0x80	;call kernel

  mov	ecx, res
  mov	edx, 1
  mov	ebx, 1	;file descriptor (stdout)
  mov	eax, 4	;system call number (sys_write)
  int	0x80	;call kernel

  mov	eax,1	;system call number (sys_exit)
  int	0x80	;call kernel
	
section .data
  msg db "The result is:", 0xA,0xD 
  len equ $- msg   
segment .bss
  res resb 1