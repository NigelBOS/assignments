section .text
    global _start

_start:
 	;put code here:
  	mov eax, [var1] ;put var1 in eax
	add eax, [var2] ;add var2
	add eax, [var3] ;add var 3
	add eax, [var4] ;add var 4
	mov [result], eax ;store final sum in result var

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
