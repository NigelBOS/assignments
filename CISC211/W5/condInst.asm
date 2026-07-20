section .text
        global _start

_start:
	;Task 1
        mov eax, 2 ;the initial number, 2 for even
	;create the sequence of 20 even numbers
.loop_even:
        mov [currEven], eax
        
        add eax, 2
        cmp eax, 20
        jle .loop_even
      
	;Task 2
	;Find the largest number among the five integer values
        mov eax, [num1]

        cmp eax, [num2]
        jg .check_num3
        mov eax, [num2] 	;updates if num2 is larger

.check_num3:
        cmp eax, [num3]
        jg .check_num4
        mov eax, [num3]		;updates if num 3 is larger

.check_num4:
        cmp eax, [num4]
        jg .check_num5
        mov eax, [num4]		;updates if num 4 is larger

.check_num5:
        cmp eax, [num5]
        jg .save_largest
        mov eax, [num5]		;updates if num 5 is larger

.save_largest:
        mov [largest], eax	;store in largest variable
	
	;exit
        mov eax, 1
        mov ebx, 0
        int 0x80

section .data
        num1 dd 64
        num2 dd 40
        num3 dd 14
        num4 dd 81
        num5 dd 78

segment .bss
        currEven resd 1
        largest   resd 1
