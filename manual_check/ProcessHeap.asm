mov eax, large fs:30h   ; Move the value of the FS segment register at offset 30h (the PEB pointer) into the eax register
mov eax, dword ptr [eax+18h] ; Move the value of the ProcessEnvironmentBlock (PEB) pointer (at offset 18h from the TEB pointer) into the eax register
cmp dword ptr ds:[eax+10h], 0 ; Compare the value of the BeingDebugged flag (at offset 10h from the PEB pointer) with 0
jne DebuggerDetected    ; Jump to the DebuggerDetected label if the BeingDebugged flag is not equal to 0 (i.e. a debugger is present)

; Offset 0x68 for NtGlobalFlag

mov eax, large fs:30h
cmp dword ptr ds:[eax+68h], 70h
jz DebuggerDetected
