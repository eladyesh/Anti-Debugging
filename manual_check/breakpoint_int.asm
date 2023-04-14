call $+5      ; push address of next instruction onto stack and jump 5 bytes ahead
pop edi       ; pop address of current instruction into edi register
sub edi, 5    ; adjust edi to point to beginning of call instruction
mov ecx, 400h ; set the number of bytes to search for breakpoint
mov eax, 0CCh ; set the breakpoint opcode
repne scasb   ; search for the breakpoint opcode (0xCC) in memory
jz DebuggerDetected ; jump to DebuggerDetected if the breakpoint is found
