;=============================================================================;
;                                                                             ;
; Plik           : arch1-5e.asm                                               ;
; Format         : EXE                                                        ;
; Cwiczenie      : Kompilacja, konsolidacja i debugowanie program�w          ;
;                  asemblerowych                                              ;
; Autorzy        : Kamila Kossyn, Łukasz Narloch, grupa 1, czw., 16:00-17:30  ;
; Data zaliczenia: DD.03.2019                                                 ;
; Uwagi          : Program dokonujacy odbicia lustrzanego tekstu o nieznanej  ;
;                  dlugosci                                                   ;
;                                                                             ;
;=============================================================================;

                .MODEL SMALL

Dane            SEGMENT

Napis           DB "Jakis napis$"

Dane            ENDS

Kod             SEGMENT

                ASSUME CS: Kod, DS: Dane, SS: Sztos

Start:      
                mov     ax, SEG Dane
                mov     ds, ax

                ;wypisywanie napisu przed rozpoczeciem
                mov     ah, 09h
                mov     dx, OFFSET Napis
                int     21h

                ;ustawienie wskaznikow 
                mov     ax, OFFSET Napis
                mov     di, ax
                mov     si, ax
Liczenie:   
                ;poszukiwanie wskaznika na koniec napisu
                mov     ah, [di]
                inc     di
                cmp     ah, '$' 
                jnz     Liczenie
                dec     di 
                dec     di ; pominiecie znaku konca linii
Zamien:
                ;Zamiana liter miejscami w napisie
                mov     ah, [si] ;prypisanie pierwszej litery do ah
                mov     al, [di] ;ostaniej do al
                mov     [si], al ;ostatnia litera na pierwszze miejsce
                mov     [di], ah ; pierwsza na ostatnie
                inc     si ;przesuniecie na nastepne miejsce
                dec     di
                cmp     si, di ;sprawdzenie czy jestesmy na srodku napisu 
                jng     Zamien 

Kon:        
                ;wyswietlanie napisu po zakonczeniu
                mov     ah, 09h
                mov     dx, OFFSET Napis
                int     21h

                ;zakonczenie programu
                mov     ax, 4C00h
                int     21h

Kod             ENDS

Sztos           SEGMENT STACK

                DB 100h DUP (?)

Sztos           ENDS

                END Start
