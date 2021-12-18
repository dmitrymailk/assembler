; y = 3 * a + b ^ 2


section	.text
  global _start        ;must be declared for using gcc

_start:	                 
  mov	edx, len ;message length
  mov	ecx, msg ;message to write
  call print

  mov esi, 0

  mov bx, 0
  mov [decimal_num], bx

  ; mov ecx, number_a_len
  ; mov [digit], ecx
  ; call print_digit
  ; call print_newline

;--- convert first number start ---
  mov bx, number_a_len
  mov [number_len], bx
  mov esi, 0
  char_to_decimal:
    mov [i], ebx
    ;--- number to decimal convertion 
    mov bl, [number_a + esi]
    sub bl, '0'
    ;--- method one start
    mov eax, [decimal_num]
    mov ecx, 10
    mul ecx
    add eax, ebx
    mov [decimal_num], eax

    mov ebx, [i]
    dec ebx
    inc esi
    mov [i], ebx
    cmp ebx, 1
    jge char_to_decimal

  mov ebx, [decimal_num]
  mov [number_1], ebx
  mov ebx, 0
  mov [decimal_num], ebx
;--- convert first number end---

;--- print first num start---
  mov ebx, [number_1]
  mov [number], ebx
  call print_num_v2
;--- print first num end---

;--- convert second number start ---
  mov bx, number_b_len
  mov [number_len], bx
  mov esi, 0
  char_to_decimal_2:
    mov [i], ebx
    ;--- number to decimal convertion 
    mov bl, [number_b + esi]
    sub bl, '0'
    ;--- method one start
    mov eax, [decimal_num]
    mov ecx, 10
    mul ecx
    add eax, ebx
    mov [decimal_num], eax

    mov ebx, [i]
    dec ebx
    inc esi
    mov [i], ebx
    cmp ebx, 1
    jge char_to_decimal_2

  mov ebx, [decimal_num]
  mov [number_2], ebx
;--- convert second number end---
  
;--- print first num start---
  mov ebx, [number_2]
  mov [number], ebx
  call print_num_v2
;--- print first num end---

;--- arithmetic operations start ---  
;--- y = 3 * a + b ^ 2
; a = number_1
; b = number_2 
  mov eax, [number_1]
  mov ebx, 3
  mul ebx
  mov [result], eax

  mov eax, [number_2]
  mul eax
  add [result], eax
;--- arithmetic operations end ---  

;--- print result start ---  
  mov ebx, [result]
  mov [number], ebx
  call print_num_v2
;--- print result end ---  
; 1234 * 3 + 4321^2=18674743
  call exit

exit:
  call print_newline
  mov	eax, 1
  mov ebx, 0
  int	0x80
  ret

print_num_v2:
  mov eax, [number]
  mov ecx, 0
  mov ebx, 10    
  mov edi, number
  .divideLoop:
    mov edx, 0          
    div ebx           
    add edx, '0'         
    push edx             
    inc ecx             
    cmp eax, 0        
    jnz .divideLoop      
  mov [i], ecx

  .reverse:
    pop eax
    mov [edi], eax
    inc edi
    dec ecx
    cmp ecx, 0
    jnz .reverse
    mov byte [edi], 0
    mov byte [edi+1], 0xa
  
  mov ecx, number
  mov edx, [i]
  call print
  ; we need to empty stack before returning
  ; amount of pushes must equals to pops
  call print_newline
  ; call clear
  mov ebx, 0
  mov [number], ebx
  ret

clear:
  mov ecx, [i]
  mov edi, number
  mov eax, 0
  .clear_number:
    mov [edi], eax
    dec edi
    dec ecx
    cmp ecx, 0
    jnz .clear_number
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
  call print_delim
  ret

print_delim:
  mov ax, 35
  mov [digit], ax
  mov ecx, digit
  mov edx, 1
  call print
  ret

print_newline:
  mov ax, 10
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

  number_b db '4321'
  number_b_len equ $ - number_b		

  number dw 5678
  number_len db 3

  buff db 0x00

segment .bss
  digit resb 5
  decimal_num resd 5
  i resb 1
  temp resb 5
  num resb 1
  
  number_1 resb 5
  number_2 resb 5
  result resb 5




  