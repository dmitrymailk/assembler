section	.text
  global _start        ;must be declared for using gcc
	
_start:	                ;tell linker entry point
  mov rcx, 10
  mov rax, '0'
	
l1:
  mov [num], rax ; move to num rax
  mov rax, 4 ; snippet code
  mov ebx, 1 ; snippet code
  push rcx ; writing it to the stack

  mov rcx, num ; move num value to rcx
  mov edx, 1 ; 
  int 0x80   ; system check value on rax register

  mov rax, [num]
  sub rax, '0'
  inc rax
  add rax, '0'
  pop rcx ; restoring whatever is on top of the stack into a register
  loop l1

  mov rax,1             ;system call number (sys_exit)
  int 0x80              ;call kernel

section	.bss
  num resb 1