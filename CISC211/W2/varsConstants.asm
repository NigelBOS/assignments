section .text
        global _start

_start:
        ; use this space for the main body of your program
        ; ======== write your code below ===========
	; make var1 value 10 using eax
	mov eax, [var1]
	
	; now adding var2 value to the eax
	add eax, [var2]

	; move the sum into result, from eax to result mem location
	mov [result], eax

        ; ======== write your code above ===========

        mov eax,1      ; set eax register to 1 (do not remove this line)
        int 0x80       ; interrupt 0x80 (do not remove this line)

segment .bss
        ; use this space for uninitialized variable (result)
	result resd 1	

segment .data
        ; use this space for initialized variables (var1 and var2)
	var1 dd 10
	var2 dd 15
