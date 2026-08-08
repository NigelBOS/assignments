section .text
    global _start

_start:
    ;Initial Prompt and reading plain text input
    mov eax, 4		;sys_write
    mov ebx, 1		;stdout
    mov ecx, plain1    	;"Plain text: "
    mov edx, plain1_len	
    int 0x80

    mov eax, 3		;sys_read
    mov ebx, 0		;stdin
    mov ecx, msg_buf	;destination for sys_read
    mov edx, 128	;max number of bytes for stdin
    int 0x80

    dec eax		;subtract 1 to ignore the \n
    mov [msg_len], eax	;saves the true length of the msg into msg_len

    ;Key prompt and read input
    mov eax, 4		;sys_write
    mov ebx, 1		;stdout
    mov ecx, key1	;"Key: "
    mov edx, key1_len
    int 0x80

    mov eax, 3		;sys_read
    mov ebx, 0		;stdin
    mov ecx, key_buf	;destination for sys_read
    mov edx, 128	;max number of bytes for stdin
    int 0x80

    dec eax		;subtracts 1 to ignore \n
    mov [key2_len], eax	;saves the true length of the key into key_len

    ;prevent division by 0, edge case
    cmp dword [key2_len], 0
    je exit

    ;The Encryption loop
    mov dword [idx], 0	;reset index to 0
encrypt_loop:
    mov eax, [idx]	
    cmp eax, [msg_len]	;compares index to the input plain text word length
    jge start_decrypt	;if done, goes to decrypt step

    ;calculates key index through mod, edx = idx % key_len
    mov eax, [idx]
    mov edx, 0		;clears and prepares edx for division
    mov ecx, [key2_len]	;ecx = key length
    div ecx		;division operation, eax/ecx remainder goes to edx

    ;prepare char bytes and perform raw xor
    mov eax, [idx]		;restore the idx offest, goes to correct char
    mov bl, [msg_buf + eax]	;the plain text byte
    mov cl, [key_buf + edx]	;the key byte from the mod operation 
    xor bl, cl			;raw xor
    mov [enc_msg1 + eax], bl	;save the encrypted msg

    ;make printable ASCII range [32,126]
printable:
    cmp bl, 32    ;compares bl to 32
    jb add_32     ;if bl < 32, jump, add 32, unsigned jump

    cmp bl, 126    ;compares bl to 126
    ja sub_32      ;if bl > 126, jump, sub 32, unsigned jump
    jmp store_printable
add_32:
    add bl, 32     ;after adding, should be in print range
    jmp printable  ;go back and check again
sub_32:
    sub bl, 32     ;after subtracting should be in print range
    jmp printable  ;go back and check again

store_printable:
    mov [enc_msg2 + eax], bl  ;save printable byte

    inc dword [idx]		;increment the index for the loop
    jmp encrypt_loop		;repeat loop

    ;The Decryption loop
start_decrypt:
    mov dword [idx], 0	;reset index to 0

decrypt_loop:
    mov eax, [idx]	;eax to current index
    cmp eax, [msg_len]	;compares index to the length of the msg
    jge write_output_file	;if loop is done, continue to next step

    ;calculates key index through mod, edx = idx % key_len
    mov eax, [idx]	;restore the idx offset
    mov edx, 0		;clears edx for divison
    mov ecx, [key2_len]	;ecx = key length  
    div ecx		;divide eax by ecx, remainder goes to edx

    ;prepares char bytes and performs xor
    mov eax, [idx]		;eax to current index
    mov bl, [enc_msg1 + eax]	;encrypted msg bytes
    mov cl, [key_buf + edx]	;key bytes from prior mod operation
    xor bl, cl			;xor, undoing original xor
    mov [dec_msg + eax], bl	;save the decrypted msg 

    inc dword [idx]		;increment the index for the loop
    jmp decrypt_loop		;repeat loop

    ;The output.txt file
write_output_file:
    mov eax, 8    ;sys_creat
    mov ebx, filename    ;"same as before, set to "output.txt"
    mov ecx, 0711o    ;permission, all read/write
    int 0x80
    mov [fd_out], eax ;save file descriptor

    ;Write results to the file
write_file:
    ;Write "Plain text: " + input word \n	
    ;To output.txt
    ;"Plain text: "
    mov eax, 4
    mov ebx, [fd_out]
    mov ecx, plain1
    mov edx, plain1_len
    int 0x80

    ;input word
    mov eax, 4
    mov ebx, [fd_out]
    mov ecx, msg_buf
    mov edx, [msg_len]
    int 0x80

    ;new line
    mov eax, 4
    mov ebx, [fd_out]
    mov ecx, newline
    mov edx, 1
    int 0x80

    ;Write "Key: " + input key word \n
    ;"Key: "
    mov eax, 4
    mov ebx, [fd_out]
    mov ecx, key1
    mov edx, key1_len
    int 0x80

    ;input key word
    mov eax, 4
    mov ebx, [fd_out]
    mov ecx, key_buf
    mov edx, [key2_len]
    int 0x80

    ;new line
    mov eax, 4
    mov ebx, [fd_out]
    mov ecx, newline
    mov edx, 1
    int 0x80

    ;Write "Encrypted text: " + encryption result \n
    ;"Encrypted text: "
    mov eax, 4
    mov ebx, [fd_out]
    mov ecx, encry
    mov edx, encry_len
    int 0x80

    ;encryption result
    mov eax, 4
    mov ebx, [fd_out]
    mov ecx, enc_msg2
    mov edx, [msg_len]
    int 0x80

    ;new line
    mov eax, 4
    mov ebx, [fd_out]
    mov ecx, newline
    mov edx, 1
    int 0x80

    ;again but to terminal
    mov eax, 4
    mov ebx, 1          ;stdout
    mov ecx, encry
    mov edx, encry_len
    int 0x80

    mov eax, 4
    mov ebx, 1          ;stdout
    mov ecx, enc_msg2
    mov edx, [msg_len]
    int 0x80

    mov eax, 4
    mov ebx, 1          ;stdout
    mov ecx, newline
    mov edx, 1
    int 0x80

    ;Write "Decrypted text: " + decryption result \n
    ;"Decrypted text: "
    mov eax, 4
    mov ebx, [fd_out]
    mov ecx, decry
    mov edx, decry_len
    int 0x80

    ;decryption result
    mov eax, 4
    mov ebx, [fd_out]
    mov ecx, dec_msg
    mov edx, [msg_len]
    int 0x80

    ;new line
    mov eax, 4
    mov ebx, [fd_out]
    mov ecx, newline
    mov edx, 1
    int 0x80

    ;again but to terminal
    mov eax, 4
    mov ebx, 1          ;stdout
    mov ecx, decry
    mov edx, decry_len
    int 0x80

    mov eax, 4
    mov ebx, 1          ;stdout
    mov ecx, dec_msg
    mov edx, [msg_len]
    int 0x80

    mov eax, 4
    mov ebx, 1          ;stdout
    mov ecx, newline
    mov edx, 1
    int 0x80

    ;Close file
    mov eax, 6		;sys_close
    mov ebx, [fd_out]
    int 0x80

    ;Exit
exit:
    mov eax, 1		;sys_exit
    mov ebx, 0
    int 0x80

section .data
    plain1       db  "Plain text: "
    plain1_len   equ $ - plain1
    
    key1     db  "Key: "
    key1_len equ $ - key1
    
    encry     db  "Encrypted text: "
    encry_len equ $ - encry
    
    decry     db  "Decrypted text: "
    decry_len equ $ - decry
    
    newline     db  0x0A

    filename    db  "output.txt", 0

section .bss
    msg_buf     resb 128
    key_buf     resb 128
    enc_msg1    resb 128    ;raw xor message
    enc_msg2    resb 128    ;Printable encrypted msg
    dec_msg     resb 128
    
    msg_len     resd 1
    key2_len     resd 1
    idx         resd 1    ; index for loop
    fd_out      resd 1
