section	.text
   global _start    ;must be declared for using gcc
	
_start:             ;tell linker entry point

   mov  al, 5h
   ; sub  al, '0'
   ; add  al, '0'
	
   mov 	bl, '2'
   sub  bl, '0'

   ; mul 	bl ; multiply by al register target register and store result at al, mov bl => al = al * bl
   add al, bl
   add al, '0'
	
   mov 	[res], al
   mov	ecx, msg	
   mov	edx, len
   mov	ebx, 1	;file descriptor (stdout)
   mov	eax, 4	;system call number (sys_write)
   int	0x80	;call kernel
	
   mov	ecx, res
   mov	edx, 2
   mov	ebx, 1	;file descriptor (stdout)
   mov	eax, 4	;system call number (sys_write)
   int	0x80	;call kernel
   mov	eax, 1	;system call number (sys_exit)
   int	0x80	;call kernel

section .data
   msg db "The result is:", 0xA
   len equ $- msg   
   
segment .bss
   res resb 2