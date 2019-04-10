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
    mov ax, SEG Sta
    mov ss, ax

    mov ax, -372
    push ax
    call PrintU2DW

EndProg:
    mov ax, 4C00h
    int 21h

    PrintU2DW PROC; Wyświetla liczbe U2
        push bp
        mov bp, sp
        sub sp, 2
        mov cx, [bp+4]
        mov ax, cx
        and ax, 1000000000000000b
        cmp ax, 1000000000000000b
        jne PrintU2DW_notNegative
        mov dl, '-'
        mov ah, 02h
        int 21h
        PrintU2DW_notNegative:
        and cx, 0111111111111111b
        mov ax, 1000000000000000b
        sub ax, cx
        push ax
        call PrintDW
        mov sp, bp
        pop bp
        ret 2
    ENDP 

    PrintDW PROC; Wyświetla liczbe nie U2
        push bp
        mov bp, sp
        sub sp, 2
        mov bx, 10
        mov cx, [bp+4]
        push '$'
    PrintDW_loop:
        mov ax, cx
        xor dx,dx
        div bx
        mov cx, ax
        push dx
        cmp cx, 10
        jge PrintDW_loop
        push cx
    PrintDW_loop_display:
        pop ax
        cmp ax, '$'
        je PrintDW_end
        push ax
        call PrintDigit
        jmp PrintDW_loop_display
    PrintDW_end:
        mov sp, bp
        pop bp
        ret 2
    ENDP

    PrintDigit PROC
        push bp
        mov bp, sp
        sub sp, 2
        mov dx, [bp+4]
        add dl, '0'        
        mov ah, 02h
        int 21h
        mov sp, bp
        pop bp
        ret 2
    ENDP

ENDS

Sta SEGMENT STACK USE16

    DW 1024 DUP (?)

ENDS

END Start
