    .386p
    .MODEL SMALL

Data SEGMENT USE16

aTxt    DW 0

ENDS

Prog SEGMENT USE16
    ASSUME CS:Prog, DS:Data, SS:Sta
Start: 
    mov ax, SEG Data
    mov ds, ax

    mov di, OFFSET aTxt
    call ReadNumer

    mov ax, 4C00h
    int 21h

    ReadNumer PROC; Wczytuje liczbe do pamięci pod adresem w di
        call ReadChar
        cmp al, '-'
        je ReadNumer_PierwszyMinusWczytano
        cmp al, '+'
        je ReadNumer_PierwszyPlusWczytano
        cmp al, '0'
        jl ReadNumer_PierwszyInneWczytano
        cmp al, '9'
        jg ReadNumer_PierwszyInneWczytano
        jmp ReadNumer_PierwszyCyfreWczytano
    ReadNumer_PierwszyMinusWczytano:
        mov WORD PTR di, 8000h;Ustawia znak na ujemny
    ReadNumer_PierwszyPlusWczytano:
    ReadNumer_PierwszyCyfreWczytano:
    ReadNumer_PierwszyInneWczytano:
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