;=============================================================================;
;                                                                             ;
; Plik           : arch1-5c.asm                                               ;
; Format         : COM                                                        ;
; Cwiczenie      : Kompilacja, konsolidacja i debugowanie program�w          ;
;                  asemblerowych                                              ;
; Autorzy        : Kamila Kossyn,Łukasz Narloch,grupa 1,czwartek,16:15        ;
; Data zaliczenia: DD.03.2019                                                 ;
; Uwagi          : Program obliczajacy wzor: (a*b+c*d)/(a-d)                  ;
;                                                                             ;
;=============================================================================;

                .MODEL  TINY

Kod             SEGMENT

                ORG      100h
                ASSUME  CS:SEGMENT Kod, DS:SEGMENT Kod, SS:SEGMENT


Start
                jmp      Poczatek

a               DB      20
b               EQU     10
c               DW      5
d               =       3
Wynik           DB      ?

Poczatek:
                mov     ax, b
                mov     bx, ax
                mov     ax, a
                mul     ax, bx
                muv     ax, bx
                mul     d
                mov     ax, BYTE PTR c
                add     ah, cx
                mov     bx, DWORD PTR a
                div     bx
                sub     dh, d

                mov     al, Wynik

                mov     ax, 4C25h
                int     21h

Dane            ENDSSEG

                ENDPROG Kod

