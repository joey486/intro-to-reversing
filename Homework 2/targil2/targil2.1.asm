; Name: Yossi Heifetz
; ID: 216175398
include 'win32a.inc'
format PE console
entry start

section '.data' data readable writable
    ; Step 1: User input
    hex_prompt db 'Enter a hex Big Endian number (0x): ', 0
    input_prompt db 'Number from terminal: ', 0
    file_prompt db 'Number from input.txt: ', 0
    reg_prompt db 'Number from registry: ', 0
    error_msg    db 'Error', 13, 10, 0

    ; Step 2: Read from file
    filename     db 'input.txt', 0
    buffer       rb 32        
    bytes_read   dd 0     
    fileHandle   dd ?

    ; Step 3: Read from registry
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
    ; Step 1: Read hex input from user
    mov  esi, hex_prompt
    call print_str
    call read_hex
    call convert          ; Convert byte order instead of bswap
    mov esi, input_prompt
    call print_str
    call print_eax

    ; Step 2: Read from input.txt
    mov esi, file_prompt
    call print_str
    
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
    je   error_exit_file

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

    call convert      ; Convert byte order instead of bswap
    call print_eax  

    push [fileHandle] 
    call [CloseHandle]
    jmp  continue_to_registry

error_exit_file:
    push error_msg
    call [printf]
    add  esp, 4
    jmp  continue_to_registry

continue_to_registry:
    ; Step 3: Read from registry
    mov esi, reg_prompt
    call print_str

    ; Open the Registry Key
    push handleKey
    push szKeyPath 
    push HKEY_CURRENT_USER
    call [RegOpenKeyA]
    test eax, eax
    jne  error_exit_registry

    ; Read the Value
    push dwBufferSize      
    push reg_buffer        
    push dwType            
    push 0       
    push szValueName
    push [handleKey]
    call [RegQueryValueExA]
    test eax, eax
    jne  error_exit_registry

    ; Convert and display
    push 16
    push 0
    push reg_buffer
    call [strtoul]
    add  esp, 12      ; Clean up stack after cdecl function
    
    call convert      ; Convert byte order instead of bswap
    call print_eax
    
    ; Close the Registry Key
    push [handleKey]
    call [RegCloseKey]
    jmp  exit_program

error_exit_registry:
    push 0
    push errorCaption
    push errorMessage
    push 0
    call [MessageBoxA]    
    push error_msg
    call [printf]
    add  esp, 4
    jmp  exit_program

; Function to convert Big Endian to Little Endian 
convert:
    push ebx
    mov  ebx, eax          ; Store original value in ebx
    mov  eax, 0            ; Clear eax for result

    ; Extract and swap bytes
    mov  al, bh            ; Move byte 2 to byte 0
    shl  eax, 8            ; Shift left by 8 bits
    mov  al, bl            ; Move byte 1 to byte 0
    shl  eax, 8            ; Shift left by 8 bits
    mov  al, bh            ; Move byte 3 to byte 0 (this will be overwritten in next step)
    shr  ebx, 16           ; Shift right to get upper 16 bits
    mov  al, bl            ; Move byte 3 to byte 0
    shl  eax, 8            ; Shift left by 8 bits
    mov  al, bh            ; Move byte 4 to byte 0
    pop  ebx
    ret

exit_program:
    push 0
    call [ExitProcess]

include 'training.inc'