section .text
        global _start

_start:
        ;put code here:
      	mov ebx, [var2] ;denominator
	sub ebx, 3

	mov eax, [var1] ; numerator
	imul eax, 2
	
	cdq ;sing-extends eax into EDX:EAX
	idiv ebx ;divides edx:eax by ebx
        mov [result], eax ;store in result

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
