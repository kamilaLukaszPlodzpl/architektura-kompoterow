.MODEL SMALL

Dane        SEGMENT

Napis      DB "napisXs$"

Dane        ENDS

Kod         SEGMENT

            ASSUME CS: Kod, DS: Dane, SS: Sztos

Start:      
            mov ax, SEG Dane
            mov ds, ax

            mov ah, 09h
            mov dx, OFFSET Napis
            INT 21h

            mov ax, OFFSET Napis
            mov di, ax
            mov si, ax
Liczenie:   
            mov ah, [di]
            inc di
            cmp ah, '$' 
            jnz Liczenie

            dec di ;koniec napisu
            dec di
Zamien:
            mov ah, [si] ;prypisanie pierwszej litery do ah
            mov al, [di] ;ostaniej do al
            mov [si], al ;ostatnia litera na pierwszze miejsce
            mov [di], ah ; pierwsza na ostatnie
            inc si
            dec di
            cmp si, di
            jng Zamien

            mov ah, 09h
            mov dx, OFFSET Napis
            INT 21h

            mov ax, 4C00h
            INT 21h

Kod         ENDS

Sztos       SEGMENT STACK

            DB 100h DUP (?)

Sztos       ENDS

            END Start
