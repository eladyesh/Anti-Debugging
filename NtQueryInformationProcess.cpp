#include <Windows.h>
#include <iostream>

BOOL CheckRemoteDebuggerPresent(HANDLE hProcess, PBOOL pbDebuggerPresent) {
    typedef struct _PEB {
        BYTE Reserved1[2];
        BYTE BeingDebugged;
        BYTE Reserved2[21];
    } PEB, *PPEB;

    typedef NTSTATUS (NTAPI *PNtQueryInformationProcess)(HANDLE, ULONG, PVOID, ULONG, PULONG);

    PNtQueryInformationProcess pNtQueryInformationProcess = 
        (PNtQueryInformationProcess)GetProcAddress(GetModuleHandle("ntdll.dll"), "NtQueryInformationProcess");

    PROCESS_BASIC_INFORMATION pbi;
    ULONG ulSize;
    NTSTATUS status;

    status = pNtQueryInformationProcess(hProcess, ProcessBasicInformation, &pbi, sizeof(pbi), &ulSize);
    if (status == STATUS_SUCCESS) {
        PPEB ppeb;
        if (ReadProcessMemory(hProcess, &pbi.PebBaseAddress, &ppeb, sizeof(ppeb), NULL)) {
            *pbDebuggerPresent = ppeb->BeingDebugged;
            return TRUE;
        }
    }

    return FALSE;
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
