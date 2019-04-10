    .386p
    .MODEL SMALL

Data SEGMENT USE16

a    DW 0

ENDS

Prog SEGMENT USE16
    ASSUME CS:Prog, DS:Data, SS:Sta
Start: 
    mov ax, SEG Data
    mov ds, ax
    push 12345
    call PrintDW
EndProg:
    mov ax, 4C00h
    int 21h
    PrintDW PROC;Wyswietla liczbe U2 z dx
        push bp
        mov bp, sp

        mov dx, [bp+4]
        mov bx, 10
        div bx
        call PrintDigit
        ;bp+4 - second param
        ;bp+6 - firstParam

        pop bp
        ret 2
    ENDP
    PrintDigit MACRO n;Wyswietla cyfre z dl
        mov dl, n
        add dl, '0'
        mov ah, 02h
        int 21h
    ENDM

ENDS

Sta SEGMENT STACK USE16
ENDS
END Start
