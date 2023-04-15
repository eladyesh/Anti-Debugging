section .text
global _start

_start:
    ; Perform some initialization here
    ; ...

    ; Insert the IceBP instruction at a specific point in the code
    int 1CE

    ; Perform some more processing here
    ; ...

    ; Terminate the program
    mov eax, 1
    xor ebx, ebx
    int 80h
