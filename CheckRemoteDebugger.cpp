#include <Windows.h>
#include <iostream>

BOOL CheckRemoteDebuggerPresent(HANDLE hProcess, PBOOL pbDebuggerPresent) {
    typedef struct _PEB {
        BYTE Reserved1[2];
        BYTE BeingDebugged;
        BYTE Reserved2[21];
    } PEB, *PPEB;

    PPEB ppeb;
    if (!ReadProcessMemory(hProcess, &NtCurrentTeb()->ProcessEnvironmentBlock, &ppeb, sizeof(PPEB), NULL)) {
        return FALSE;
    }

    *pbDebuggerPresent = ppeb->BeingDebugged;
    return TRUE;
}

int main() {
    HANDLE hProcess = GetCurrentProcess(); // Get handle to current process
    BOOL bDebuggerPresent = FALSE;

    if (CheckRemoteDebuggerPresent(hProcess, &bDebuggerPresent)) {
        if (bDebuggerPresent) {
            MessageBox(NULL, "Debugger is present", "Warning", MB_OK);
        } else {
            MessageBox(NULL, "Debugger is not present", "Information", MB_OK);
        }
    } else {
        MessageBox(NULL, "CheckRemoteDebuggerPresent failed", "Error", MB_OK);
    }

    return 0;
}
