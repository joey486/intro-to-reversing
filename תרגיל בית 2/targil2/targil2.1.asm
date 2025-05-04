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
    input_char      db 0
    hex_number      db 0
    input_fmt       db '%c', 0

section '.text' code readable executable

start:
    ; Print the menu text
    push menu_text
    call [printf]
    add esp, 4

    ; Read user input
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
    push hex_prompt
    call [printf]
    add esp, 4

    
    lea     eax, [hex_number]
    push    eax
    push    input_fmt
    call    [scanf]
    add     esp, 8


input_txt:


input_assembly:

exit_program:

include 'training.inc'