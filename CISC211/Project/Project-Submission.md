#Class Project: Encryption and Decryption
Nigel Boswell

## Flowchart:
![General thought process](./project_flowchart.pdf)

## Explanation Video:


## Assebly Files:
### encrypt.asm:
[encrypt.asm](./encrypt.asm)
```asm

```

    mov eax, 5			;sys_open, 
    mov ebx, filename		;sets file name "output.txt"
    mov ecx, 2          ;read and write
    mov edx, 0711o		;permission, all read/write
    int 0x80

    cmp eax, 0
    jl create_file    ;if eax is negative, we then create a file

    mov [fd_out], eax		;save the returned file descriptor
    jmp write_file

create_file:
