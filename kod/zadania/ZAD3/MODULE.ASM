;=============================================================================;
;                                                                             ;
; Plik           : MODULE.ASM                                                 ;
; Format         : EXE                                                        ;
; Cwiczenie      : Ćwiczenie 3. Program hybrydowy                             ;
; Autorzy        : Kamila Kossyn, Łukasz Narloch, grupa 1, czw., 16:00-17:30  ;
; Data zaliczenia: DD.MM.YYYY                                                 ;
; Uwagi          :                                                            ;
;                                                                             ;
;=============================================================================;

;
; Zrobic alokowanie w ramce stosu 
; Korzystac z przynajmniej jednej zmiennej lokalnej
;
    .MODEL SMALL, C
    .CODE

    PUBLIC arrayAvg
    PUBLIC countChar

arrayAvg PROC
    push bp
    mov bp, sp
    ;;;;;;;;;;;;;
    mov cx, [bp+6]; Ustawienie licznika petli na iosc elementow w tablicy

    ;Wczytanie pierwszego elementu tablicy
    dec cx
    mov bx, [bp+4]; Offset na pierwszy element tablicy
    fld qword ptr [bx]; Push na coprocesor
    add bx, 8;Przesuniecie o 8 bajtow

    arrayAvg_SumLoop:;Petla dodajaca sumujaca kolejne liczby
    fadd qword ptr [bx]
    add bx, 8
    loop arrayAvg_SumLoop

    fidiv word ptr[bp+6]; Podzelenie sumy przez ilosc liczb w tablicy
    ;;;;;;;;;;;;;
    mov sp, bp
    pop bp
    ret
arrayAvg ENDP

countChar PROC
    push bp
    mov bp, sp
    ;;;;;;;;;;;;;
    mov cx, [bp+6]; Szukany znak w cl
    mov bx, [bp+4]; Offset na 1 element tablicy
    mov ax, 0; Wyzerowanie zwracanej liczby
    countChar_loop:
    mov dx, [bx]
    add bx, 1
    cmp dl, 0
    je countChar_end
    cmp dl, cl
    jne countChar_loop
    inc ax
    jmp countChar_loop
    countChar_end:
    ;;;;;;;;;;;;;
    mov sp, bp
    pop bp
    ret
countChar ENDP

    .STACK 100h
    END