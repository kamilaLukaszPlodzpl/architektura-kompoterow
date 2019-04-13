	.386p
	.MODEL TINY

Prog SEGMENT USE16

	ORG     100h;Program w formacie COM wymaga przesunięcia o 256 bajtów
	ASSUME  CS: Prog, DS: Prog, SS: Prog

	Start: 

	mov bx, 1231
	call ReadWord
    mov ax , bx
    call ReadWord

    add ebx, eax

    call PrintDWord
	
EndProg:
    mov ax, 4C00h
    int 21h



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

PrintDWord: ;wyświetla liczbę z ebx
    push eax
    push ecx
    push ebx
    push edx
    mov ecx, ebx
    and ecx, 1000000000000000b
    cmp ecx, 1000000000000000b
    jne PrintDWord_GenerateLetter
    ;liczba ujemna
    mov ah, 02h
    mov dl, '-'
    int 21h
    neg ebx
    PrintDWord_GenerateLetter:
    push '$'
    PrintDWord_GenerateLetter_loop:
    mov eax, ebx
    mov ecx, 10
    xor edx, edx
    idiv ecx
    mov ebx, eax
    add edx, '0'
    ;append
    push edx
    cmp ebx, 10
    jge PrintDWord_GenerateLetter_loop
    mov edx, ebx
    add edx, '0'
    ;append
    push edx
    mov ah, 02h
    PrintDWord_Display:
    pop edx
    cmp edx, '$'
    je PrintDWord_End
    int 21h
    jmp PrintDWord_Display
    PrintDWord_End:
    pop eax
    pop edx
    pop ebx
    pop ecx
    ret

ENDS

END Start

