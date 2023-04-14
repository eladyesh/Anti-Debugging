section .data

    ; buffer to be checked for the 0xCC opcode
    buffer db 0x90, 0x33, 0xC0, 0xCC, 0xC3

    ; pre-computed CRC32 lookup table
    crc32_table dd 0, 0xEDB88320, 0x1D834FDC, 0x3B8349EC, 0x26B89FB0, 0x4AB842C4, 0x356B1F62, 0x5B358FD6, \
                 0x13BABAFC, 0x7D3A9322, 0x67D0D7B8, 0x09D05866, 0x6E5AD6E0, 0x107AEAF4, 0x0A900E6E, 0x64B0521A

section .text

    global _start

    ; compute the CRC32 checksum of the buffer
    _start:
        ; initialize the CRC32 value to 0xFFFFFFFF
        mov ebx, 0xFFFFFFFF

        ; loop through each byte of the buffer
        mov ecx, 5
        mov esi, buffer
    loop:
        ; load the current byte into eax
        mov al, [esi]

        ; update the CRC32 value using the lookup table
        xor edx, edx
        mov edx, ebx
        shr edx, 24
        xor edx, al
        and edx, 0xFF
        mov eax, crc32_table[edx * 4]
        xor eax, ebx
        mov ebx, eax
        shr ebx, 8
        xor eax, crc32_table[ebx * 4]
        mov ebx, eax
        shr ebx, 8
        xor eax, crc32_table[ebx * 4]
        mov ebx, eax
        shr ebx, 8
        xor eax, crc32_table[ebx * 4]

        ; move to the next byte of the buffer
        inc esi
        loop loop

        ; negate the final CRC32 value and store it in ebx
        not ebx

        ; check if the checksum matches the expected value (0x91E0459D for the given buffer)
        cmp ebx, 0x91E0459D
        jne NotFound

        ; the buffer contains the 0xCC opcode
        ; do something here
        jmp Done

    ; the buffer does not contain the 0xCC opcode
    NotFound:
        ; do something else here
        jmp Done

    ; exit the program
    Done:
        xor eax, eax
        ret
