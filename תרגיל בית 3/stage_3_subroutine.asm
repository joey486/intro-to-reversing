.text:00401430 ; =============== S U B R O U T I N E =======================================
.text:00401430
.text:00401430 ; Attributes: bp-based frame
.text:00401430
.text:00401430 sub_401430      proc near               ; CODE XREF: sub_401E00:loc_401E2F↓p
.text:00401430
.text:00401430 var_18          = byte ptr -18h
.text:00401430 var_8           = dword ptr -8
.text:00401430 var_4           = dword ptr -4
.text:00401430
.text:00401430                 push    ebp
.text:00401431                 mov     ebp, esp
.text:00401433                 sub     esp, 18h
.text:00401436                 push    offset aWaitCanYouHelp ; "..Wait! Can you help me first with some"...
.text:0040143B                 call    sub_401DC0
.text:00401440                 add     esp, 4
.text:00401443
.text:00401443 loc_401443:                             ; CODE XREF: sub_401430+84↓j
.text:00401443                                         ; sub_401430+A3↓j ...
.text:00401443                 mov     eax, 1
.text:00401448                 test    eax, eax
.text:0040144A                 jz      loc_4014EC
.text:00401450                 mov     [ebp+var_8], 0
.text:00401457                 mov     [ebp+var_4], 0
.text:0040145E                 jmp     short loc_401469
.text:00401460 ; ---------------------------------------------------------------------------
.text:00401460
.text:00401460 loc_401460:                             ; CODE XREF: sub_401430:loc_4014AC↓j
.text:00401460                 mov     ecx, [ebp+var_4]
.text:00401463                 add     ecx, 1
.text:00401466                 mov     [ebp+var_4], ecx
.text:00401469
.text:00401469 loc_401469:                             ; CODE XREF: sub_401430+2E↑j
.text:00401469                 cmp     [ebp+var_4], 8
.text:0040146D                 jge     short loc_4014AE
.text:0040146F                 mov     edx, [ebp+var_4]
.text:00401472                 lea     eax, [ebp+edx*2+var_18]
.text:00401476                 push    eax             ; char
.text:00401477                 push    offset aHu      ; " %hu"
.text:0040147C                 call    sub_401EB0
.text:00401481                 add     esp, 8
.text:00401484                 cmp     eax, 1
.text:00401487                 jnz     short loc_401496
.text:00401489                 mov     ecx, [ebp+var_4]
.text:0040148C                 movzx   edx, word ptr [ebp+ecx*2+var_18]
.text:00401491                 cmp     edx, 8
.text:00401494                 jb      short loc_4014AC
.text:00401496
.text:00401496 loc_401496:                             ; CODE XREF: sub_401430+57↑j
.text:00401496                 push    offset aBadOrInvalidNu ; "Bad or invalid numbers! Try again from "...
.text:0040149B                 call    sub_401DC0
.text:004014A0                 add     esp, 4
.text:004014A3                 mov     [ebp+var_8], 1
.text:004014AA                 jmp     short loc_4014AE
.text:004014AC ; ---------------------------------------------------------------------------
.text:004014AC
.text:004014AC loc_4014AC:                             ; CODE XREF: sub_401430+64↑j
.text:004014AC                 jmp     short loc_401460
.text:004014AE ; ---------------------------------------------------------------------------
.text:004014AE
.text:004014AE loc_4014AE:                             ; CODE XREF: sub_401430+3D↑j
.text:004014AE                                         ; sub_401430+7A↑j
.text:004014AE                 cmp     [ebp+var_8], 1
.text:004014B2                 jnz     short loc_4014B6
.text:004014B4                 jmp     short loc_401443
.text:004014B6 ; ---------------------------------------------------------------------------
.text:004014B6
.text:004014B6 loc_4014B6:                             ; CODE XREF: sub_401430+82↑j
.text:004014B6                 lea     eax, [ebp+var_18]
.text:004014B9                 push    eax
.text:004014BA                 call    sub_4014F0
.text:004014BF                 add     esp, 4
.text:004014C2                 test    eax, eax
.text:004014C4                 jnz     short loc_4014D8
.text:004014C6                 push    offset aWrongTryAgain_0 ; "Wrong! Try again.\r\n"
.text:004014CB                 call    sub_401DC0
.text:004014D0                 add     esp, 4
.text:004014D3                 jmp     loc_401443
.text:004014D8 ; ---------------------------------------------------------------------------
.text:004014D8
.text:004014D8 loc_4014D8:                             ; CODE XREF: sub_401430+94↑j
.text:004014D8                 push    offset aThanksForTheHe ; "Thanks for the help! You may enter now."...
.text:004014DD                 call    sub_401DC0
.text:004014E2                 add     esp, 4
.text:004014E5                 jmp     short loc_4014EC
.text:004014E7 ; ---------------------------------------------------------------------------
.text:004014E7                 jmp     loc_401443
.text:004014EC ; ---------------------------------------------------------------------------
.text:004014EC
.text:004014EC loc_4014EC:                             ; CODE XREF: sub_401430+1A↑j
.text:004014EC                                         ; sub_401430+B5↑j
.text:004014EC                 mov     esp, ebp
.text:004014EE                 pop     ebp
.text:004014EF                 retn
.text:004014EF sub_401430      endp
.text:004014EF