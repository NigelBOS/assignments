section .text
	global _start

_start: 
	;push the variables onto stack
	push dword [x]
	push dword [y]
	push dword [z]

	;call my function
	call add3vars

	;deallocate memory from stack
	add esp, 12
	
	;store sum in result
	mov [result], eax
	
	call exit

add3vars:
	;saves the frame pointer, then sets up the frame
	push ebp
	mov ebp, esp

	;grab the variables from the stack and add
	mov eax, [ebp + 8] ;x
	add eax, [ebp + 12] ; x + y
	add eax, [ebp + 16] ; x + y + z

	leave ;deallocates the local stack
	ret


exit:
	;exit procedure
	mov eax, 1
	mov ebx, 0
	int 0x80
	ret

section .data
	;assigning integer values
	x dd 10
	y dd 22
	z dd 54

section .bss
	result resd 1 ;4 bytes for sum
