; Get the timestamp counter
rdtsc
; Initialize counter ecx to 0
xor ecx, ecx
; Add the timestamp counter value to counter ecx
add ecx, eax
; Get the timestamp counter again
rdtsc
; Subtract the previous timestamp counter value from the current value to get the difference
sub eax, ecx
; Compare the difference with 0xFFF
cmp eax, 0xFFF
; Jump to NoDebuggerDetected if the difference is less than or equal to 0xFFF
jb NoDebuggerDetected
; Get the timestamp counter again
rdtsc
; Push the timestamp counter value onto the stack
push eax
; Return from the function
ret
