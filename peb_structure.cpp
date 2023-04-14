typedef struct _PEB {
 BYTE Reserved1[2];
 BYTE BeingDebugged;
354 Chapter 16
 BYTE Reserved2[1];
 PVOID Reserved3[2];
 PPEB_LDR_DATA Ldr;
 PRTL_USER_PROCESS_PARAMETERS ProcessParameters;
 BYTE Reserved4[104];
 PVOID Reserved5[52];
 PPS_POST_PROCESS_INIT_ROUTINE PostProcessInitRoutine;
 BYTE Reserved6[128];
 PVOID Reserved7[1];
 ULONG SessionId;
} PEB, *PPEB;
