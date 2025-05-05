; Name: Yossi Heifetz
; ID: 216175398
include 'win32a.inc'
format PE console
entry start

section '.data' data readable writable
    menu_text db '[1]: read_hex', 13, 10
              db '[2]: input.txt', 13, 10
              db '[3]: input\Assembly\Software\HKC register', 13, 10
              db 'Please choose one (or "q" to quit):', 13, 10, 0
    hex_prompt db 'Enter a hex Big Endien number (0x): ', 0
    file_prompt db 'Number from input.txt: ', 0
    input_char      db 0
    hex_number      db 0
    input_fmt       db '%c', 0
    filename db 'input.txt', 0
    error_msg db 'Error: Could not open file.', 13, 10, 0
    buffer rb 32        ; Reserve bytes for buffer in .data section
    buffer_size equ 32  ; Size of the buffer
    bytes_read dd 0     ; For storing number of bytes read
    fileHandle  dd ?

section '.text' code readable executable

start:
    push menu_text
    call [printf]
    add esp, 4

    lea     eax, [input_char]
    push    eax
    push    input_fmt
    call    [scanf]
    add     esp, 8

    mov     al, [input_char]
    cmp     al, '1'
    je input_hex
    cmp     al, '2'
    je input_txt
    cmp     al, '3'
    je input_assembly
    cmp     al, 'q'
    je exit_program
    ; If the input is not valid, print the menu again
    push menu_text
    call [printf]
    add esp, 4
    jmp start


input_hex:
    mov esi, hex_prompt
    call print_str
    call read_hex

    bswap eax

    call print_eax
    jmp exit_program

input_txt:
    push file_prompt
    call [printf]
    add esp, 4
    
    invoke CreateFile, filename, GENERIC_READ, 0, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
    mov [fileHandle], eax

    cmp eax, INVALID_HANDLE_VALUE
    je file_error

    invoke ReadFile, [fileHandle], buffer, 256, bytes_read, 0


    mov eax, [bytes_read]
    mov byte [buffer + eax], 0    ; add null terminator

    push 16              ; base = 16 (hex)
    push 0               ; endptr = NULL (not used)
    push buffer          ; pointer to the string
    call [strtoul]

    bswap eax

    call print_eax

    ; close file handle
    invoke CloseHandle, [fileHandle]

    ; exit
    invoke ExitProcess, 0

file_error:
    mov esi, error_msg
    call print_str
    invoke ExitProcess, 1



input_assembly:


error_exit:
    push    error_msg
    call    [printf]
    add     esp, 4
    jmp exit_program


exit_program:

include 'training.inc'