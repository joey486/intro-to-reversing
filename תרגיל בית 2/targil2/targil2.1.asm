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

    input_char   db 0
    input_fmt    db '%c', 0

    filename     db 'input.txt', 0
    error_msg    db 'Error', 13, 10, 0
    buffer       rb 32        
    bytes_read   dd 0     
    fileHandle   dd ?

    szKeyPath    db 'Software\Assembly', 0  
    handleKey    dd 0
    szValueName  db 'input',0
    reg_buffer   rb 256
    
    dwType       dd 0                    ; To store the type of the value
    dwBufferSize dd 256                  ; Size of the buffer

    errorMessage  db 'Error accessing registry', 0
    errorCaption  db 'Error', 0

section '.text' code readable executable
start:
    push menu_text
    call [printf]
    add esp, 4

    lea  eax, [input_char]
    push eax
    push input_fmt
    call [scanf]
    add  esp, 8

    mov  al, [input_char]
    cmp  al, '1'
    je   input_hex
    cmp  al, '2'
    je   input_txt
    cmp  al, '3'
    je   input_registry
    cmp  al, 'q'
    je   exit_program
    jmp  start

input_hex:
    mov  esi, hex_prompt
    call print_str
    call read_hex
    bswap eax
    call print_eax
    jmp  exit_program

input_txt:
    push file_prompt
    call [printf]
    add  esp, 4
    
    ; CreateFile(filename, GENERIC_READ, 0, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0)
    push 0         
    push FILE_ATTRIBUTE_NORMAL
    push OPEN_EXISTING       
    push 0
    push 0
    push GENERIC_READ
    push filename
    call [CreateFile]
    mov  [fileHandle], eax

    cmp  eax, INVALID_HANDLE_VALUE
    je   error_exit

    ; ReadFile(fileHandle, buffer, 256, bytes_read, 0)
    push 0
    push bytes_read
    push 256
    push buffer
    push [fileHandle]
    call [ReadFile]

    mov  eax, [bytes_read]
    mov  byte [buffer + eax], 0

    push 16     
    push 0   
    push buffer     
    call [strtoul]
    add  esp, 12      ; Clean up stack after cdecl function

    bswap eax   
    call print_eax  

    push [fileHandle] 
    call [CloseHandle]
    jmp  exit_program

input_registry:
    ; Open the Registry Key
    push handleKey
    push szKeyPath 
    push HKEY_CURRENT_USER
    call [RegOpenKeyA]
    test eax, eax
    jne  error

    ; Read the Value
    push dwBufferSize      
    push reg_buffer        
    push dwType            
    push 0       
    push szValueName
    push [handleKey]
    call [RegQueryValueExA]
    test eax, eax
    jne  error

    ; Convert and display
    push 16
    push 0
    push reg_buffer
    call [strtoul]
    add  esp, 12      ; Clean up stack after cdecl function
    
    bswap eax
    call print_eax
    
    ; Close the Registry Key
    push [handleKey]
    call [RegCloseKey]
    jmp  exit_program

error:
    push 0
    push errorCaption
    push errorMessage
    push 0
    call [MessageBoxA]    

error_exit:
    push error_msg
    call [printf]
    add  esp, 4
    jmp  exit_program

exit_program:
    push 0
    call [ExitProcess]

include 'training.inc'