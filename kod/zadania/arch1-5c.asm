;=============================================================================;
;                                                                             ;
; Plik           : arch1-5c.asm                                               ;
; Format         : COM                                                        ;
; Cwiczenie      : Kompilacja, konsolidacja i debugowanie programow           ;
;                  asemblerowych                                              ;
; Autorzy        : Kamila Kossyn, Łukasz Narloch, grupa 1, czw., 16:00-17:30  ;
; Data zaliczenia: DD.03.2019                                                 ;
; Uwagi          : Program obliczajacy wzor: (a*b+c*d)/(a-d)                  ;
;                                                                             ;
;=============================================================================;

                .MODEL  TINY

Kod             SEGMENT

                ORG     100h
                ASSUME  CS: Kod, DS: Kod, SS:Kod

Start:
                je      Poczotek

a               DB      20
b               EQU     10
c               DW      5
d               =       3
Wynik           DB      ?

Poczotek:
                ;Mnożenie a*b wynik do ax
                mov al, a
                mov ah, b
                mul ah

                mov     bx, ax
                ;Mnożenie c*d wynik do ax
                mov     ax, d
                mov     cx, ax
                mov     ax, c
                mul     cx
                
                ;Dodanie a*b+c*d
                add     bx, ax

                ;Odjęcie a-d wynik do ax
                xor     ax, ax
                mov     al, a
                sub     al, d

                mov     cx, ax;Dzielinik
                mov     ax, bx
                div     cx

                mov     al, Wynik

                mov     ax, 4C25h
                int     21h

Kod            ENDS

                END Start

