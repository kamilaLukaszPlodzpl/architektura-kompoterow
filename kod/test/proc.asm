    .386p
    .MODEL SMALL

Data SEGMENT USE16

aTxt    DW 0
toNieJestCyfraNapis DB "To nie jest cyfra!$"

ENDS

Prog SEGMENT USE16
    ASSUME CS:Prog, DS:Data, SS:Sta
Start: 
    mov ax, SEG Data
    mov ds, ax

    mov di, OFFSET aTxt
    mov [di], 3039h
    
EndProg:
    mov ax, 4C00h
    int 21h

    ReadNumer PROC
        ;Wczytuje liczbe do pamięci pod adresem w di
        ;di - adres na Word
        ;dl = 1 liczba ujemna
        ;dl = 0 liczba dodatnia
        ;al - wczytana litera
        mov WORD PTR [di], 0
        mov ah, 01h
        int 21h
        cmp al, '-'
        je ReadNumer_PierwszyMinusWczytano
        cmp al, '+'
        je ReadNumer_PierwszyPlusWczytano
        cmp al, '0'
        jl ReadNumer_InneWczytano
        cmp al, '9'
        jg ReadNumer_InneWczytano
        jmp ReadNumer_PierwszyCyfreWczytano
    ReadNumer_PierwszyMinusWczytano:
        mov dl, 1;Zapisuje info o znaku
        mov cx, 5;Pozostalo do wczytania 5 cyfr
        jmp ReadNumer_ReadDigit
    ReadNumer_PierwszyPlusWczytano:
        mov dl, 0;Zapisuje info o znaku
        mov cx, 5;
        jmp ReadNumer_ReadDigit
    ReadNumer_PierwszyCyfreWczytano:
        mov dl, 0;Zapisuje info o znaku
        mov cx, 4
        ;bl - wczytana cyfra
        ;Kod ascii lirery - '0' jako kod ascii
        mov bl, al
        mov bh, '0'
        sub bl, bh
        xor bh, bh
        ;Dopisanie cyfry
        mov dl, '+'
        call PrintChar
        
        add WORD PTR [di],bx
        jmp ReadNumer_ReadDigit
    ReadNumer_InneWczytano:
        mov ah, 09h
        mov dx, OFFSET toNieJestCyfraNapis
        int 21h
        mov ax, 4C00h
        int 21h

    ReadNumer_ReadDigit:
        ;ax - zmienia sie
        ;Przesunięcie na kolejne miejsce
        
        mov dl, '*'
        call PrintChar
        mov ax,[di]
        mov bl, 10
        mul bl
        mov [di], ax
        ;Wczytanie kolejnej cyfry
        mov ah, 01h
        int 21h
        cmp al, '0'
        jl ReadNumer_InneWczytano
        cmp al, '9'
        jg ReadNumer_InneWczytano
        mov bl, '0'
        sub al, bl
        xor ah, ah
        mov dl, '+'
        call PrintChar
        add WORD PTR [di], ax
        loop ReadNumer_ReadDigit


    ReadNumer_end:
        ret
    ENDP
    
    PrintChar PROC ;Wypisz znak z dl
        mov ah, 02h
        int 21h
        ret
    ENDP

    ReadChar PROC ;Wczytaj kolejny znak do al
        mov ah, 01h
        int 21h
        ret
    ENDP


ENDS

Sta SEGMENT STACK USE16
ENDS
END Start