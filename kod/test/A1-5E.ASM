; Napisane na czysto
; Nie do zgloszenia jako odpowiedz
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

                .MODEL  SMALL

Dane            SEGMENT

Tekst           DB      "Jakis napis$"

                ENDS

Kod             SEGMENT

                ASSUME  DS:Dane, CS:Kod, SS:Stosik

Start:
                mov     ax, SEG Dane
                mov     ds, ax

                ;Wypisanie orginanego tekstu 
                mov     ah, 09h
                mov     dx, OFFSET Tekst
                int     21h

                ;Szukanie wskaznika na ostania litere napisu
                mov     si, OFFSET Tekst
ZliczLiteryPetla:
                cmp     BYTE PTR [si], '$'
                je     Zamieniaj
                inc     si
                jmp     ZliczLiteryPetla


                ;Zamienia litery
Zamieniaj:
                mov di, si
                dec di
                mov si, OFFSET Tekst
ZamieniajPetla:
                cmp si, di
                jnl Kon
                mov bh, BYTE PTR[si]
                mov bl, BYTE PTR[di]
                mov BYTE PTR[si], bl
                mov BYTE PTR[di], bh
                dec di
                inc si
                jmp ZamieniajPetla

Kon:            
                ;Wypisanie po zakonczeniu programu    
                mov     ah, 09h
                mov     dx, OFFSET Tekst
                int     21h
                ;Zakonczenie programu
                mov     ax, 4C00h
                int     21h

                ENDS

Stosik          SEGMENT STACK

                DB      100h DUP (?)
                ENDS

                END Start

