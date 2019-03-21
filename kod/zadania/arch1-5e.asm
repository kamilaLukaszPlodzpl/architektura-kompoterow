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

Dane            ENDS

Kod             SEGMENT

                ASSUME  DS:Dane, CS:Kod, SS:Stosik

Start:
                mov     ax, SEG Kod
                mov     cx, ax

                mov     si, di
                mov     si, OFFSET Tekst
                xor     cx, cx

Petla1:
                cmp     WORD PTR [cx], '$'
                jne     Sprawdz
                inc     di
                inc     cx
                inc     cx
                jmp     Start

Sprawdz:
                or      cx, cx
                jnz     Kon
                shr     cx, 2
                adc     cx, 0
                dec     di

Petla2:
                mov     [si], al
                mov     bh, [di]
                mov     [bx], ah
                mov     al, [di]
                dec     si
                loop     Petla2
                inc     di

                mov     ah, 09h
                mov     dx, OFFSET Tekst
                int     21h

Kon:
                mov     ax, 4C00h
                int     21h

Kod             ENDS

Stosik          SEGMENT STACK

                DB      100h DUP (?)

Stosik          ENDS

                END Start

