=============== S U B R O U T I N E =======================================
.text:00401330
.text:00401330 ; Attributes: bp-based frame
.text:00401330
.text:00401330 sub_401330      proc near               ; CODE XREF: sub_401E00:loc_401E28↓p
.text:00401330
.text:00401330 Buffer          = byte ptr -40Ch
.text:00401330 var_C           = dword ptr -0Ch
.text:00401330 Str             = dword ptr -8
.text:00401330 var_4           = dword ptr -4
.text:00401330
.text:00401330                 push    ebp
.text:00401331                 mov     ebp, esp
.text:00401333                 sub     esp, 40Ch
.text:00401339                 push    offset aYouKnowWhatTha ; "You know what? That was too easy. *Now*"...
.text:0040133E                 call    sub_401DC0
.text:00401343                 add     esp, 4
.text:00401346
.text:00401346 loc_401346:                             ; CODE XREF: sub_401330+DE↓j
.text:00401346                                         ; sub_401330+F2↓j
.text:00401346                 mov     eax, 1
.text:0040134B                 test    eax, eax
.text:0040134D                 jz      loc_401427
.text:00401353                 push    400h            ; Size
.text:00401358                 push    0               ; Val
.text:0040135A                 lea     ecx, [ebp+Buffer]
.text:00401360                 push    ecx             ; void *
.text:00401361                 call    memset
.text:00401366                 add     esp, 0Ch
.text:00401369                 push    0               ; Ix
.text:0040136B                 call    ds:__acrt_iob_func
.text:00401371                 add     esp, 4
.text:00401374                 push    eax             ; Stream
.text:00401375                 push    3FFh            ; MaxCount
.text:0040137A                 lea     edx, [ebp+Buffer]
.text:00401380                 push    edx             ; Buffer
.text:00401381                 call    ds:fgets
.text:00401387                 add     esp, 0Ch
.text:0040138A                 lea     eax, [ebp+Buffer]
.text:00401390                 push    eax             ; Str
.text:00401391                 call    strlen
.text:00401396                 add     esp, 4
.text:00401399                 mov     [ebp+var_C], eax
.text:0040139C                 mov     [ebp+var_4], 0
.text:004013A3                 jmp     short loc_4013AE
.text:004013A5 ; ---------------------------------------------------------------------------
.text:004013A5
.text:004013A5 loc_4013A5:                             ; CODE XREF: sub_401330+A3↓j
.text:004013A5                 mov     ecx, [ebp+var_4]
.text:004013A8                 add     ecx, 4
.text:004013AB                 mov     [ebp+var_4], ecx
.text:004013AE
.text:004013AE loc_4013AE:                             ; CODE XREF: sub_401330+73↑j
.text:004013AE                 mov     edx, [ebp+var_4]
.text:004013B1                 add     edx, 3
.text:004013B4                 cmp     edx, [ebp+var_C]
.text:004013B7                 jnb     short loc_4013D5
.text:004013B9                 mov     eax, [ebp+var_4]
.text:004013BC                 mov     ecx, dword ptr [ebp+eax+Buffer]
.text:004013C3                 xor     ecx, 41524241h
.text:004013C9                 mov     edx, [ebp+var_4]
.text:004013CC                 mov     dword ptr [ebp+edx+Buffer], ecx
.text:004013D3                 jmp     short loc_4013A5
.text:004013D5 ; ---------------------------------------------------------------------------
.text:004013D5
.text:004013D5 loc_4013D5:                             ; CODE XREF: sub_401330+87↑j
.text:004013D5                 mov     [ebp+Str], offset aIntoTheRabbitH_0 ; "into the rabbit hole"
.text:004013DC                 mov     eax, [ebp+Str]
.text:004013DF                 push    eax             ; Str
.text:004013E0                 call    strlen
.text:004013E5                 add     esp, 4
.text:004013E8                 push    eax             ; MaxCount
.text:004013E9                 mov     ecx, [ebp+Str]
.text:004013EC                 push    ecx             ; Str2
.text:004013ED                 lea     edx, [ebp+Buffer]
.text:004013F3                 push    edx             ; Str1
.text:004013F4                 call    ds:strncmp
.text:004013FA                 add     esp, 0Ch
.text:004013FD                 test    eax, eax
.text:004013FF                 jz      short loc_401413
.text:00401401                 push    offset aWrongPassword_0 ; "Wrong password!\r\n"
.text:00401406                 call    sub_401DC0
.text:0040140B                 add     esp, 4
.text:0040140E                 jmp     loc_401346
.text:00401413 ; ---------------------------------------------------------------------------
.text:00401413
.text:00401413 loc_401413:                             ; CODE XREF: sub_401330+CF↑j
.text:00401413                 push    offset aCorrectYouMayE_0 ; "Correct! you may enter..\r\n"
.text:00401418                 call    sub_401DC0
.text:0040141D                 add     esp, 4
.text:00401420                 jmp     short loc_401427
.text:00401422 ; ---------------------------------------------------------------------------
.text:00401422                 jmp     loc_401346
.text:00401427 ; ---------------------------------------------------------------------------
.text:00401427
.text:00401427 loc_401427:                             ; CODE XREF: sub_401330+1D↑j
.text:00401427                                         ; sub_401330+F0↑j
.text:00401427                 mov     esp, ebp
.text:00401429                 pop     ebp
.text:0040142A                 retn
.text:0040142A sub_401330      endp
.text:0040142A
.text:0040142A ; ---------------------------------------------------------------------------
.text:0040142B                 align 10h
.text:00401430