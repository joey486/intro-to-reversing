; Name: Yossi Heifetz
; ID: 216175398
include 'win32a.inc'
format PE console
entry start

section '.data' data readable writable
    matrix_rows     dd 7
    matrix_cols     dd 7
    border_char     db '#', 0
    player_char     db 'O', 0
    empty_char      db ' ', 0
    fmt_char        db '%c', 0
    prompt          db 'Enter move (w=up, a=left, s=down, d=right, q=quit): ', 0
    input_fmt       db '%c', 0
    player_row      dd 4
    player_col      dd 4
    input_char      db 0
    new_line        db 13, 10, 0
    
    cursor_home     db 27, '[H', 0
    clear_screen_seq db 27, '[2J', 27, '[H', 0

section '.text' code readable executable

start:
    lea     esi, [clear_screen_seq]
    call    print_str
    
game_loop:
    lea     esi, [cursor_home]
    call    print_str
    call    draw_matrix

    push    prompt
    call    [printf]
    add     esp, 4

    lea     eax, [input_char]
    push    eax
    push    input_fmt
    call    [scanf]
    add     esp, 8

    mov     al, [input_char]
    cmp     al, 'q'
    je      exit_game
    cmp     al, 'w'
    je      move_up
    cmp     al, 'a'
    je      move_left
    cmp     al, 's'
    je      move_down
    cmp     al, 'd'
    je      move_right
    jmp     game_loop

move_up:
    mov     eax, [player_row]
    cmp     eax, 2
    jle     game_loop
    dec     dword [player_row]
    jmp     game_loop

move_left:
    mov     eax, [player_col]
    cmp     eax, 2
    jle     game_loop
    dec     dword [player_col]
    jmp     game_loop

move_down:
    mov     eax, [player_row]
    mov     ebx, [matrix_rows]
    dec     ebx
    cmp     eax, ebx
    jge     game_loop
    inc     dword [player_row]
    jmp     game_loop

move_right:
    mov     eax, [player_col]
    mov     ebx, [matrix_cols]
    dec     ebx
    cmp     eax, ebx
    jge     game_loop
    inc     dword [player_col]
    jmp     game_loop

exit_game:
    push    0
    call    [ExitProcess]

draw_matrix:
    mov     ecx, [matrix_rows]
    mov     edi, 1

print_row:
    push    ecx
    mov     ecx, [matrix_cols]
    mov     esi, 1

print_col:
    push    ecx
    push    esi

    mov     eax, [player_row]
    cmp     edi, eax
    jne     check_border
    mov     eax, [player_col]
    cmp     esi, eax
    jne     check_border

    movzx   eax, byte [player_char]
    push    eax
    jmp     do_print

check_border:
    mov     eax, [matrix_rows]
    cmp     edi, 1
    je      print_border
    cmp     edi, eax
    je      print_border
    cmp     esi, 1
    je      print_border
    cmp     esi, [matrix_cols]
    je      print_border

    movzx   eax, byte [empty_char]
    push    eax
    jmp     do_print

print_border:
    movzx   eax, byte [border_char]
    push    eax

do_print:
    push    fmt_char
    call    [printf]
    add     esp, 8

    pop     esi
    inc     esi

    pop     ecx
    dec     ecx
    jnz     print_col

    push    new_line
    call    [printf]
    add     esp, 4

    inc     edi

    pop     ecx
    dec     ecx
    jnz     print_row

    ret

include 'training.inc'