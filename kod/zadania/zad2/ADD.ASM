;=============================================================================;
;                                                                             ;
; Plik           : ADD.ASM                                                    ;
; Format         : COM                                                        ;
; Cwiczenie      : Cwiczenie 2. Kod uzupelnieniowy do dwoch                   ;
; Autorzy        : Kamila Kossyn, Łukasz Narloch, grupa 1, czw., 16:00-17:30  ;
; Data zaliczenia:                                                            ;
; Uwagi          : Program obliczający sume 2 liczb 16-bit U2                 ;
;                                                                             ;
;=============================================================================;

	.386p
	.MODEL TINY

Prog SEGMENT USE16

	ORG     100h;Program w formacie COM wymaga przesunięcia o 256 bajtów
	ASSUME  CS: Prog, DS: Prog, SS: Prog

	Start: 
    
    jmp SkipData
PodajLiczbe1Tekst DB "Podaj liczbe nr 1$"
PodajLiczbe2Tekst DB "Podaj liczbe nr 2$"
WynikTekst DB "Wynik$"
c   DD ? ;Miejsce na wynik
    SkipData:

    ;Zerowanie
    xor eax, eax
    xor ebx, ebx
    ;
    mov dx, OFFSET PodajLiczbe1Tekst
    call PrintString

    call ReadWord
    call ConvertWordToDoubleWord
    call PrintNewLine

    mov eax, ebx

    mov dx, OFFSET PodajLiczbe2Tekst
    call PrintString

    call ReadWord
    call ConvertWordToDoubleWord
    call PrintNewLine

    add ebx, eax

    mov dx, OFFSET WynikTekst
    call PrintString

    call PrintDoubleWord
    call PrintNewLine

EndProg:
    mov ax, 4C00h
    int 21h

ConvertWordToDoubleWord:
    push ax
    push cx
    push dx
    push bp
    push si
    push di

    mov ax, bx
    xor ebx, ebx

    mov dx, 8000h
    and dx, ax
    cmp dx, 8000h
    jne ConvertWordToDoubleWord_Positive
    mov ebx, 11111111111111111111111111111111b
    ConvertWordToDoubleWord_Positive:
    mov bx, ax

    pop di
    pop si
    pop bp
    pop dx
    pop cx
    pop ax
    ret


PrintString:
    push ax
    mov ah, 09h
    int 21h
    pop ax
    call PrintNewLine
    ret

PrintNewLine:
    pusha
    mov ah, 02h
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    popa
    ret

ReadWord:;Wczytuje liczbe do bx
    push ax
    push cx
    push dx
    push bp
    push si
    push di
    mov ah, 01h
    int 21h
    cmp al, '-'
    je ReadWord_firstMinus
    cmp al, '0'
    jl ReadWord_firstOther
    cmp al, '9'
    jg ReadWord_firstOther
    jmp ReadWord_firstDgit
    ReadWord_firstMinus:
    mov dx, 1111h
    push dx
    mov ah, 01h
    int 21h
    jmp ReadWord_readNumbers
    ReadWord_firstDgit:
    mov dx, 0000h
    push dx
    ReadWord_readNumbers:
    mov cx, 4
    xor bx,bx
    ReadWord_readNumbersLoop:
    mov ah, 0
    sub al, '0'
    add ax, bx
    mov bx, 10
    mul bx
    mov bx, ax
    mov ah, 01h
    int 21h
    cmp al, '0'
    jl ReadWord_other
    cmp al, '9'
    jg ReadWord_other
    loop ReadWord_readNumbersLoop;
    mov ah, 0
    sub al, '0'
    add bx, ax

    jmp ReadWord_endOther
    ReadWord_other:
	mov ax, bx
	mov bx, 10
	div bx
	mov bx, ax
	ReadWord_endOther:

    pop dx
    cmp dx, 0000h

    je ReadWord_notChangeSign
    neg bx
    ReadWord_notChangeSign:
    pop di
    pop si
    pop bp
    pop dx
    pop cx
    pop ax
    ret
    ReadWord_firstOther:
    mov ax, 4C00h
    int 21h

PrintDoubleWord:;Wyswietla liczbe z ebx
    pusha
    mov ecx, ebx
    and ecx, 10000000000000000000000000000000b
    cmp ecx, 10000000000000000000000000000000b
    jne PrintDoubleWord_GenerateLetter
    ;liczba ujemna
    mov ah, 02h
    mov dl, '-'
    int 21h
    neg ebx
    PrintDoubleWord_GenerateLetter:
    push '$'
    PrintDoubleWord_GenerateLetter_loop:
    mov eax, ebx
    mov ecx, 10
    xor edx, edx
    div ecx
    mov ebx, eax
    add dx, '0'
    push dx
    cmp ebx, 10
    jge PrintDoubleWord_GenerateLetter_loop
    mov edx, ebx
    add dx, '0'
    push dx
    mov ah, 02h
    PrintDoubleWord_Display:
    pop dx
    cmp dx, '$'
    je PrintDoubleWord_End
    int 21h
    jmp PrintDoubleWord_Display
    PrintDoubleWord_End:


    popa
    ret

PrintWord:;Wyswietla liczbe z bx
    pusha
    mov cx, bx
    and cx, 1000000000000000b
    cmp cx, 1000000000000000b
    jne PrintWord_GenerateLetter
    ;liczba ujemna
    mov ah, 02h
    mov dl, '-'
    int 21h
    neg bx
    PrintWord_GenerateLetter:
    push '$'
    PrintWord_GenerateLetter_loop:
    mov ax, bx
    mov cx, 10
    xor dx, dx
    div cx
    mov bx, ax
    add dx, '0'
    ;append
    push dx
    cmp bx, 10
    jge PrintWord_GenerateLetter_loop
    mov dx, bx
    add dx, '0'
    ;append
    push dx
    mov ah, 02h
    PrintWord_Display:
    pop dx
    cmp dx, '$'
    je PrintWord_End
    int 21h
    jmp PrintWord_Display
    PrintWord_End:
    popa
    ret

ENDS

END Start

