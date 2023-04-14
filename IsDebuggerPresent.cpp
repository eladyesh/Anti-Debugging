#include <Windows.h>
#include <iostream>

BOOL IsDebuggerPresent() {
    typedef struct _PEB {
        BYTE Reserved1[2];
        BYTE BeingDebugged;
        BYTE Reserved2[21];
    } PEB, *PPEB;

    PPEB peb = (PPEB) __readgsqword(0x60); // Get pointer to PEB from GS segment register

    return peb->BeingDebugged;
}

int main() {
    if (IsDebuggerPresent()) {
        MessageBox(NULL, "Debugger is present", "Warning", MB_OK);
    }
    return 0;
}
