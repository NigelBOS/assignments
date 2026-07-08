section .text
        global _start

_start:
        ;put code here:
	mov eax, [var1]
	neg eax
	imul eax, 10 ;imul for signed data, eax=eax*10
	mov [result], eax ;store in final result var

	;exit stuff
	mov eax, 1
	mov ebx, 0
	int 0x80

section .data 
        var1 dd 4 
        var2 dd 5
        var3 dd 6
        var4 dd 7

section .bss
	;the uninitialized variable result
	result resd 1
