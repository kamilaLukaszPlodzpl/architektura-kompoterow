;=============================================================================;
;                                                                             ;
; Plik           : arch1-5e.asm                                               ;
; Format         : EXE                                                        ;
; Cwiczenie      : Kompilacja, konsolidacja i debugowanie program�w          ;
;                  asemblerowych                                              ;
; Autorzy        : Kamila Kossyn, Łukasz Narloch, grupa 1, czw., 16:00-17:30  ;
; Data zaliczenia: 28.03.2019                                                 ;
; Uwagi          : Program dokonujacy odbicia lustrzanego tekstu o nieznanej  ;
;                  dlugosci                                                   ;
;                                                                             ;
;=============================================================================;
                .MODEL SMALL                ;może być po jednym segmencie: kodu, danych, stosu

Dane            SEGMENT

Napis           DB "Jakis napis$"

Dane            ENDS

Kod             SEGMENT

                ASSUME CS: Kod, DS: Dane, SS: Sztos

Start:      
                mov     ax, SEG Dane        ;pobranie adresu w pamięci początku segmentu danych
                mov     ds, ax              ;samo assume nie ustanawia automatycznie początku segmentu danych

                ;wypisywanie napisu przed rozpoczeciem
                mov     ah, 09h             ;ustawia wywołanie systemowe - wyświetlanie ciągu znaków
                mov     dx, OFFSET Napis    ;co ma być wypisane(09h "szuka" w dx)
                int     21h                 ;przerwanie systemowe 21h może uruchomić wywołanie systemowe

                ;ustawienie wskaznikow 
                mov     ax, OFFSET Napis    ;pobranie adresu na początek napisu
                mov     di, ax              ;ustawienie wskaźnika na pierwszy znak, potrzebne do znalezienia ostatniego znaku
                mov     si, ax              ;wskaźnik na pierwszy znak
Liczenie:   
                ;poszukiwanie wskaznika na koniec napisu
                mov     ah, [di]            ;pobieranie wartości pod wskaźnikiem di do rejestru ah
                inc     di                  ;zwiększanie wskaźnika - następny znak
                cmp     ah, '$'             ;sprawdź czy już jest koniec napisu (flaga ZF = 1 jeśli równe)
                jnz     Liczenie            ;powrót do etykiety jeśli ZF = 0;

                ;pomninięcie znaku końca linii
                dec     di                  ;wskaźnik zwiększono przed porównaniem, a po pobraniu wartości, di wskazuje teraz na miejsce po za znakiem końca
                dec     di                  ;dlatego zmniejszamy dwa razy
Zamien:
                ;Zamiana znaków miejscami w napisie
                mov     ah, [si]            ;przypisanie pierwszej litery do ah
                mov     al, [di]            ;ostaniej do al
                mov     [si], al            ;ostatnia litera na pierwszze miejsce
                mov     [di], ah            ;pierwsza na ostatnie
                inc     si                  ;przesuniecie na nastepne miejsce
                dec     di
                cmp     si, di              ;sprawdzenie czy jestesmy na srodku napisu 
                jng     Zamien              ;jeśli wskaźnik si nie jest większy niż di -pętla

Kon:        
                ;wyswietlanie napisu po zakonczeniu
                mov     ah, 09h
                mov     dx, OFFSET Napis
                int     21h

                ;zakonczenie programu
                mov     ax, 4C00h           ;odpowiada za zamknięcie programu i przekazania kontroli systemowi
                int     21h                 ;przerwanie systemowe 21h

Kod             ENDS

Sztos           SEGMENT STACK

                DB 100h DUP (?)

Sztos           ENDS

                END Start
