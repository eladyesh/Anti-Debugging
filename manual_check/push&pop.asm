push dword ptr fs:[30h] ; Push the PEB (Process Environment Block) pointer onto the stack
pop edx                ; Pop the PEB pointer from the stack into the edx register
cmp byte ptr [edx+2], 1 ; Compare the value of the BeingDebugged flag (at offset 2 from the TEB pointer) with 1
je DebuggerDetected     ; Jump to the DebuggerDetected label if the BeingDebugged flag is equal to 1 (i.e. a debugger is present)
