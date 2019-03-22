
                .MODEL  TINY

Kod             SEGMENT

                ORG     100h

                ASSUME  CS: Kod, DS: Kod, SS:Kod

Start:
                jmp      Poczotek

a               DB      20
b               EQU     10
c               DW      5
d               =       3
Wynik           DB      ?

Poczotek:           

                mov     ax, OFFSET Wynik
                mov     di, ax

                mov     ah, a
                mov     bh, ah
                mov     ah, b 
                mul     bh
                mov     bx, ax

                mov     ax, c
                mov     cx, ax
                mov     ax, d 
                mul     cx

                add     bx, ax 

                mov     ah, a
                mov     ch, ah
                mov     ah, d
                sub     ch, ah

                mov     ax, bx

                div     ch

                mov     di, ax

                mov     ax, 4C25h
                int     21h

Kod            ENDS

                END Start

