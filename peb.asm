; Define the PEB structure
_PEB STRUCT
    Reserved1   db  2 dup (?) ; 2 bytes
    BeingDebugged   db  1   ; 1 byte
    Reserved2   db  1 dup (?) ; 1 byte
    Reserved3   dq  2 dup (?) ; 16 bytes
    Ldr     dq  ?   ; 8 bytes (assuming 64-bit architecture)
    ProcessParameters  dq  ?   ; 8 bytes (assuming 64-bit architecture)
    Reserved4   db  104 dup (?) ; 104 bytes
    Reserved5   dq  52 dup (?) ; 416 bytes
    PostProcessInitRoutine  dq  ?   ; 8 bytes (assuming 64-bit architecture)
    Reserved6   db  128 dup (?) ; 128 bytes
    Reserved7   dq  1 dup (?) ; 8 bytes (assuming 64-bit architecture)
    SessionId   dd  ?   ; 4 bytes
_PEB ENDS

; Define the PPEB type
PPEB    typedef PTR _PEB


; Set FS segment register to point to the PEB
mov eax, fs:[30h] ; 30h is the offset of the PEB in the TIB (Thread Information Block)

; Access fields in the PEB
mov ebx, [eax+0Ch] ; offset 0Ch is the ProcessParameters field in the PEB
mov ecx, [ebx+10h] ; offset 10h is the CommandLine field in the ProcessParameters
