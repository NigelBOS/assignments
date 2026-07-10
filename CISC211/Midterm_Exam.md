# Midterm Exam CISC 211
Nigel Boswell

## Question 1:
```asm
SYS_EXIT  equ 1
SYS_WRITE equ 4
STDOUT    equ 1

section .text
        global _start

_start:
        ; PART a
        ; var1 = 8, var2 = 3, var3 = 5

        ; numerator var1 + 2
        mov eax, [var1]
        add eax, 2

        ; denominator var3 - var2
        mov ebx, [var3]
        sub ebx, [var2]

        ; divide
        cdq                 ; sign extend
        idiv ebx            

        ; store quotient in result
        mov [result], eax

        ;PART b
        add eax, '0'        
        mov [msgResult], al

        ; output
        mov eax, SYS_WRITE
        mov ebx, STDOUT
        mov ecx, msgResult  
        mov edx, lenResult 
        int 0x80

        ;exit stuff
        mov eax, SYS_EXIT
        mov ebx, 0
        int 0x80

section .data
        var1 dd 8
        var2 dd 3
        var3 dd 5

        msgResult db 0
        lenResult equ $ - msgResult

section .bss
        result resd 1
```
| Register Name | Value |
| :--- | :--- |
| `EAX` | `5` |
| `EDX` | `0` |

<img width="622" height="874" alt="image" src="https://github.com/user-attachments/assets/bb046b27-d12e-494e-a18d-6049a7b7bd74" />

## Question 2

### K-Map Grid

| | b' (0) | b (1) |
| :---: | :---: | :---: |
| **a' (0)** | 0 | 1 |
| **a (1)** | 1 | 1 |

## Question 3
```asm
section .text
	global _start

_start:
;code here
        ;Xor
	mov eax, [zeroVar]
	xor eax, eax
	mov [result1], eax

        ;odd/even test
	mov eax, [testVar]
	mov ebx, 2
	cdq         ;sign extend
	idiv ebx        ;divide
	
	cmp edx, 0 ;compares remainder to 0
	jz .even        ; checks if even, if so it jumps to even section skipp ing the following between

        ;display odd number msg
	mov eax, 4        ;sys_write        
	mov ebx, 1        ;stdout
	mov ecx, msg_odd
	mov edx, len_odd
	int 0x80

	mov dword [result2], 1         ;set to 1 for odd
	jmp .exit

.even:
        ;if even sotres 0
        ;display even number msg
	mov eax, 4
	mov ebx, 1
	mov ecx, msg_even
	mov edx, len_even
	int 0x80

	mov dword [result2], 0
	
.exit:
	mov eax, 1
	mov ebx, 0 
	int 0x80

segment .bss
	result1 resd 1        ;for xor
	result2 resd 1        ;for odd/even

section .data
	testVar dd 5
	zeroVar dd 20

	msg_odd  db 'odd number', 0xA
	len_odd  equ $ - msg_odd

	msg_even db 'even number', 0xA
	len_even equ $ - msg_even
```
