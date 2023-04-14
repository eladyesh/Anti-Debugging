#include <Windows.h>
#include <iostream>

BOOL CheckRemoteDebuggerPresent(HANDLE hProcess, PBOOL pbDebuggerPresent) {
    *pbDebuggerPresent = FALSE;
    OutputDebugString("Test");

    if (GetLastError() == ERROR_SUCCESS) {
        *pbDebuggerPresent = TRUE;
    }

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
