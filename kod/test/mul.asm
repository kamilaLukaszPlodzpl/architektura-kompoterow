;Mnozenie kodow asci
; i wyswietlenie ich
; nie wiem czy do konca dziala

.MODEL SMALL

Data SEGMENT
    Podaj_liczbe DB 10,13,"Podaj liczbe",10,13,"$"
    Wczytano DB 10,13,"Wczytano: ",10,13,"$"
    Mnozenie DB 10,13,"Mnozenie",10,13,"$"
ENDS

Program SEGMENT
	ASSUME CS:Program, DS:Data, SS:Sztos
Start:
    ;Wypisanie komunikatu
    mov ax, SEG Data
    mov ds, ax
    mov ah, 09h
    mov dx, OFFSET Podaj_liczbe
    int 21h
    ;Wczytanie klawisza do al
    mov ah, 01h
    int 21h
    mov bl, al
    ;Wypisanie komunikatu
    mov ax, SEG Data
    mov ds, ax
    mov ah, 09h
    mov dx, OFFSET Wczytano
    int 21h
    ;Wypisanie Wczytanej liczby
    mov ah, 02h
    mov dl, bl
    int 21h

    ;Wypisanie komunikatu
    mov ax, SEG Data
    mov ds, ax
    mov ah, 09h
    mov dx, OFFSET Podaj_liczbe
    int 21h
    ;Wczytanie klawisza do al
    mov ah, 01h
    int 21h
    mov bh, al
    ;Wypisanie komunikatu
    mov ax, SEG Data
    mov ds, ax
    mov ah, 09h
    mov dx, OFFSET Wczytano
    int 21h
    ;Wypisanie Wczytanej liczby
    mov ah, 02h
    mov dl, bh
    int 21h

    
    ;Wypisanie komunikatu o mnozeniu
    mov ax, SEG Data
    mov ds, ax
    mov ah, 09h
    mov dx, OFFSET Mnozenie
    int 21h
    ;Mnozenie
    mov al, bl
    mul bh
    mov cx, ax
    ;Wypisanie wyniku
    mov ah, 02h
    mov dl, cl
    int 21h
    
    mov ah, 02h
    mov dl, ch
    int 21h


    ;Zakonczenie
    mov ax, 4C00h
    int 21h
ENDS

Sztos SEGMENT STACK

ENDS

END Start