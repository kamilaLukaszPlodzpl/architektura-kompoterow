;=============================================================================;
;                                                                             ;
; Plik           : arch1-5c.asm                                               ;
; Format         : COM                                                        ;
; Cwiczenie      : Kompilacja, konsolidacja i debugowanie program�w          ;
;                  asemblerowych                                              ;
; Autorzy        : Kamila Kossyn, Łukasz Narloch, grupa 1, czw., 16:00-17:30  ;
; Data zaliczenia: DD.03.2019                                                 ;
; Uwagi          : Program obliczajacy wzor: (a*b+c*d)/(a-d)                  ;
;                                                                             ;
;=============================================================================;

                :MODEL  TINY

Kod             SEGMENT

                ORG     100h
                ASUUME  CS:SEGMENT Kod, DS:SEGMENT Kod, SS:SEGMENT

Start
                je      Poczotek

a               DB      20
b               EQU     10
c               DW      5
d               =       3
Wynik           DB      ?

Poczotek:
                mov     ax, a
                mul     ax, b
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

