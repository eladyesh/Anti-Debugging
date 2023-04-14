mov eax, dword ptr fs:[30h] ; Load the PEB (Process Environment Block) pointer into eax
mov ebx, byte ptr [eax+2]   ; Load the value of the BeingDebugged flag from the PEB (Process Environment Block) at offset 2 from the TEB pointer into ebx
test ebx, ebx               ; Test the value of the BeingDebugged flag (0 if no debugger is present, non-zero otherwise)
jz NoDebuggerDetected       ; Jump to NoDebuggerDetected label if the flag is 0 (no debugger is present)

