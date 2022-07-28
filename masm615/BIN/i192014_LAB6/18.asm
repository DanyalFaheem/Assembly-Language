.model small
.stack 100h
.data
.code
start:
    mov ax, @data
    mov ds, ax

    cmp bx, ax
    ja ed

    cmp dx, cx
    ja assign
    jmp ed

    assign:
        mov ax, 5
        mov dx, 6

    ed:
        mov AH, 4CH
        int 21h
        end start    