section .text
    global _start   ;must be declared for linker (ld)

    _start:             ;tells linker entry point
        mov edx, len    ;message length
        mov ecx, msg    ;message to write
        mov ebx, 1      ;file descriptor (stdout)
        mov eax, 4      ;system call number (sys_write)
        int 0x80        ;call kernel

        mov eax, 1      ;system call number (sys_exit)
        int 0x80        ;call kernel

section .data
    ;string to be printed
    msg db 'Across the Great Wall we can reach every corner in the world.', 0xa
    ;length of the string
    len equ $ - msg
