;=============================================================================;
;                                                                             ;
; Plik           : arch1-5c.asm                                               ;
; Format         : COM                                                        ;
; Cwiczenie      : Kompilacja, konsolidacja i debugowanie programow           ;
;                  asemblerowych                                              ;
; Autorzy        : Kamila Kossyn, Łukasz Narloch, grupa 1, czw., 16:00-17:30  ;
; Data zaliczenia: 28.03.2019                                                 ;
; Uwagi          : Program obliczajacy wzor: (a*b+c*d)/(a-d)                  ;
;                                                                             ;
;=============================================================================;

                .MODEL  TINY;Model mówiący o tym że kod bedzie składał się z jednego segmentu

Kod             SEGMENT

                ;Program w formacie COM wymaga przesunięcia o 256 bajtów
                ORG     100h
                ASSUME  CS: Kod, DS: Kod, SS:Kod

Start:
                ;Wymagany skok do reszty rozkazów ze względu na to że
                ;trzeba pominąć obszar pamięci zawierający dane a nie rozkazy
                je      Poczotek

a               DB      20;Bajt z liczba 20
b               EQU     10;Stała
c               DW      5;Word 2 bajty z liczba 5
d               =       3
Wynik           DB      ?;Bajt

Poczotek:
                ;Mnożenie a*b wynik do ax
                mov al, a
                mov ah, b
                mul ah

                ;Obliczone a*b przesuwamy do bx by zwolnić ax
                ;którego porzebujemy dalej w naszym programie
                mov     bx, ax

                ;Mnożenie c*d wynik do ax
                mov     ax, d
                mov     cx, ax
                mov     ax, c
                mul     cx
                
                ;Dodanie a*b+c*d wynik do bx
                add     bx, ax

                ;Odjęcie a-d wynik do ax
                xor     ax, ax;Zerowanie ax
                mov     al, a
                sub     al, d

                ;Dzielenie 2 liczb wynik do ax
                mov     cx, ax;
                mov     ax, bx;
                div     cx


                mov     al, Wynik;Ustawiamy exit code na nasz wynik

                mov     ah, 4Ch;Ustawia wywolanie systemowe na wywolanie zwaracajace kontrole procesowi rodzicowi
                int     21h;Przerwanie 21h, uruchamia wywolanie systemowe

Kod            ENDS
                
                
                END Start

