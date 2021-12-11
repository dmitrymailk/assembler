; y = 3 * a + b ^ 2


section	.text
  global _start        ;must be declared for using gcc

_start:	                 
  mov	edx, len ;message length
  mov	ecx, msg ;message to write
  call print

  ; mov ecx, number_a_len
  ; mov esi, 0

  ; mov bx, 0
  ; mov [decimal_num], bx

  ; mov bx, 9
  ; mov [digit], bx
  ; call print_digit

; char_to_decimal:
;   mov [i], ecx
;   call power_10

;   ; mov ax, [number_a + esi]
;   ; sub ax, '0'
;   ; inc esi
;   ; mov [num], ecx
;   ; mov ax, [num]
;   call print_digit
;   mov ecx, [i]
;   loop char_to_decimal

  call print_num


  call exit

exit:
  mov	eax, 1
  int	0x80
  ret

power_10:
  mov ecx, 1
  mov ax, 1
  mov bx, 10
  cmp ecx, [number_len]  ; compare length with 1, because we can output one digit 
  je power_end ; if we have only one number we'll skip
  ; je power_end ; if we have only one number we'll skip
  power_loop:
    mul bx
    inc ecx
    cmp ecx, [number_len]
    jl power_loop
  power_end:
  call dec_number_len
ret

; power_end:
;   call print_debug
; ret

dec_number_len:
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
  mov ax, [digit]
  add ax, '0'
  mov [digit], ax
  mov ecx, digit
  mov edx, 1
  call print
  call print_newline
  ret

print_newline:
  mov ax, 35
  mov [digit], ax
  mov ecx, digit
  mov edx, 1
  call print
  ret

print_debug:
  mov ax, 64
  mov [digit], ax
  mov ecx, digit
  mov edx, 1
  call print
  ret


; program doesn't work for digits, it's only for numbers 
print_num:  
  mov bx, [number_len]
  cmp bx, 1
  je print_num_end
  call power_10
  mov [temp], ax
  mov bx, [temp]
  mov ax, [number]
  div bx
  mov [number], dx
  mov [digit], ax
  call print_digit
  mov dx, [number_len]
  cmp dx, 1
  jg print_num
  ; print last digit
print_num_end:
  mov ax, [number]
  mov [digit], ax
  call print_digit
  ret

section	.data
  msg db 'Start program', 0xa	
  len equ $ - msg		

  number_a db '1234'
  number_a_len equ $ - number_a		


  number dw 4
  number_len db 1

segment .bss
  digit resb 5
  decimal_num resb 5
  i resb 1
  temp resb 5


  