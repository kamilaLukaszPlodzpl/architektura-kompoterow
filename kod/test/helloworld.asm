.MODEL TINY

Kod        SEGMENT
            
            ORG 100h
            ASSUME      DS: Kod, CS: Kod, SS: Kod
            
Start:      
            jmp skok


Napis       DB "Hello World$"

skok:   
            mov ah, 09h
            mov dx, OFFSET Napis
            INT 21h
            mov ax, 4C00h
            INT 21h

Kod         ENDS

            END Start