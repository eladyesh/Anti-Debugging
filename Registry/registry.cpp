#include <Windows.h>
#include <iostream>
using namespace std;

int main() {
    HKEY hKey;
    LONG res = RegOpenKeyEx(HKEY_LOCAL_MACHINE, "SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\AeDebug", 0, KEY_READ, &hKey);
    if (res != ERROR_SUCCESS) {
        cout << "Failed to open registry key. Error code: " << res << endl;
        return 1;
    }

    char value[256];
    DWORD valueLen = sizeof(value);
    res = RegQueryValueEx(hKey, "Debugger", NULL, NULL, (LPBYTE)value, &valueLen);
    if (res == ERROR_SUCCESS && strcmp(value, "Dr.Watson") == 0) {
        cout << "Dr.Watson is set as the default debugger." << endl;
    } else {
        cout << "Debugger is not set to Dr.Watson." << endl;
    }

    RegCloseKey(hKey);
    return 0;
}
