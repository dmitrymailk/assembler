section	.text
  global _start        ;must be declared for using gcc
	
_start:	                ;tell linker entry point
  mov rcx, 10
  mov rax, '0'
	
l1:
  mov [num], rax ; move to num rax
  mov rax, 4 ; the system interprets 4 as "write"
  mov ebx, 1 ; standard output (print to terminal)
  push rcx ; writing it to the stack

  mov rcx, num ; move num value to rcx, pointer to the value being passed
  mov edx, 1 ; length of value that have passed
  int 0x80 ; system check value on rax register, call kernel

  mov rax, [num] ; moving num to rax register
  ; convertion ascii to number data type, 
  ; example '2' have 32 number, to convert it to real number
  ; we need to substruct 30 or '0' symbol notation
  sub rax, '0' 
  inc rax ; increment rax by 1
  add rax, '0' ; returning to ascci code number 
  pop rcx ; restoring whatever is on top of the stack into a register
  loop l1 ; looping until we will get zero in rcx register

  mov rax, 1 ;system call number (sys_exit)
  int 0x80 ;call kernel

section	.bss
  num resb 1