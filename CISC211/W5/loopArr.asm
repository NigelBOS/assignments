section .text
        global _start

_start:
       
        ;task 1: Counter using EBX (Optimized version)
       
        mov ecx, 10             ;loop count to 10
        mov ebx, 0              ;counter initialized at 0

.counter_loop:
        inc ebx                 ;increment
        loop .counter_loop      ;decrements ECX and loops until ECX == 0

        mov [task1_ebx], ebx    ;compares loop result


        ;task 2: 10th Fibonacci num starting from 0
        mov eax, 0              ;1st
        mov ebx, 1              ;2nd
        mov ecx, 10             ;steps to take, 10

.fib_loop:
        mov edx, eax            ;temp
        add edx, ebx            ;next  Fibonacci number = current + previous
        mov eax, ebx            ;shift down
        mov ebx, edx            ;shift down
        dec ecx                 ;decrement counter
        jnz .fib_loop           ;loop until counter hits 0

        mov [fib_result], ebx   ;store result should be 55


        ;task 3
        mov eax, 3              ;array length count
        mov ecx, array          ;beginning
        mov ebx, [ecx]         

.array_loop:
        cmp [ecx], ebx          ;cmp current num and current largest
        jle .next_elem          ;skips if lower
        mov ebx, [ecx]          ;update if current element is larger

.next_elem:
        add ecx, 4              ;go to next 4-byte element
        dec eax                 ;decrement count
        jnz .array_loop         

        mov [largest], ebx      ;store largest


        ;exit
        mov eax, 1
        mov ebx, 0
        int 0x80

section .data
        ;task 3: Int array of length 3
        array dd 15, 82, 43

segment .bss
        ;for gdb
        task1_ebx  resd 1
        fib_result resd 1
        largest    resd 1
