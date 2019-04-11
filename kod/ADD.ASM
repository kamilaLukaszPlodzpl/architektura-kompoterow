    .386p
    .MODEL SMALL

Data SEGMENT USE16

a    DW 0

ENDS

Prog SEGMENT USE16
    ASSUME CS:Prog, DS:Data, SS:Sta
Start: 
    mov ax, SEG Data
    mov ds, ax
    
    mov bx, 456
    mov cl, 'l'
    mov ch, 'h'

    call ReadWord

    mov ah, 02h
    mov dl, ch
    int 21h
    mov dl, cl
    int 21h
    


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
    loop ReadWord_readNumbersLoop;
    mov ah, 0
    sub al, '0'
    add bx, ax
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

    PrintNewLine:
    pusha
    mov ah, 02h
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h
    popa
    ret

ENDS

Sta SEGMENT STACK USE16

    DW 1024 DUP (?)

ENDS

END Start
