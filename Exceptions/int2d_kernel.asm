; Push the address of "continue" label onto the stack
push offset continue
; Push the value of dword at the address pointed by fs:[0] onto the stack
push dword fs:[0]
; Move the current stack pointer to the location pointed by fs:[0]
mov fs:[0], esp
; Trigger a breakpoint interrupt (int 3)
int 0x2D

; The code above checks if the program is being debugged
; If it is, the breakpoint interrupt will cause the debugger to stop the program
