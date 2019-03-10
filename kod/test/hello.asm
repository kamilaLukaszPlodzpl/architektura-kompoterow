.MODEL SMALL

Data SEGMENT
Zmienna DB " Witaj $"
ENDS

Program SEGMENT
	ASSUME CS:Program, DS:Data, SS:Sztos
	Start:
	;Wyswietlenie Zmienna
	mov ah, 09h
	mov dx, OFFSET Zmienna
	int 21h
	;Zakonczenie
	mov ax, 4C00h
	int 21h
ENDS

Sztos SEGMENT STACK

ENDS

END Start