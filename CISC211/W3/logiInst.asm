section .text
	global _start

_start:
	;code here:
	
	; XOR
	mov eax, [zeroVar] ;put it in eax
	xor eax, eax ;XORing itself to set to 0
	mov [result1], eax ;stores it, will be 0

	; Odd/Even test
	mov eax, [testVar]
	test eax, 1 ;bitwise AND w/ 1 to check lowest bit
	;will compare 1st bit and 1, if 0, even and if 1, odd and res stored in flags register
	
	jz .even ;evaluates if test is even, if so jumps ahead

	;not even:
	mov dword [result2], 1 ;set to 1 for odd
	jmp .exit

.even:
	;if even, stores 0
	mov dword [result2], 0 ;set to 0 for even
	
.exit:
	;exit stuff here:
	mov eax, 1
	mov ebx, 0 
	int 0x80 ;kernal

segment .bss
	result1 resd 1 ;its the result var for xor
	result2 resd 1 ;will hold odd/even result

section .data
	;test variable
	testVar dd 5

	;variable for xor to 0
	zeroVar dd 20
