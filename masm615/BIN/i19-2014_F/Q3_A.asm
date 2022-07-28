.model small
.stack 100h
.data
v1 db ?
v2 db 1
v3 dw 1
.code
	start:
	mov ax, @data
	mov ds, ax
	
	mov AH,07
	int 21H
	
	mov v1, AL
	sub v1, 48
	
	mov DL, 10
	mov AH, 02
	int 21h

    mov CL, v1
    mov CH, 0

    L1:
        push v3
        mov al, v2
        mov AH, 0
        add v3, AX
        inc v2
    loop L1
    
    mov CL, v1
    mov CH, 0

    L2:
        mov BX, CX
        pop DX
        mov DH, 0
        add DL, 48
        L3:
            mov AH, 02
            int 21H
            add DL, 1
        loop L3

        mov DL, 10
        mov AH, 02
        int 21h   

        mov CX, BX
    loop L2

    mov AH, 4CH
    int 21h        

    end start





