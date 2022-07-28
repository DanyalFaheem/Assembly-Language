.model small
.stack 100h
.data
v1 dw ?
v11 dw ?
v2 db 10
counter db 0
result dw 0
v3 dw ?
result2 dw 0
digits db 0
multiplicant db 1, 10, 100
msg db "Enter your number: ", '$'
armstrong db "The number is an armstrong number", '$'
armstrongn db "The number is not an armstrong number", '$'
.code
	start:
	mov ax, @data
	mov ds, ax
    mov DX, offset msg
    mov AH, 09
    int 21h
	mov di, offset multiplicant
    input:
        mov AH, 01
        int 21h
        cmp al, 13
        je done
		sub al, 48
        add digits, 1
        mov AH, 0
        push ax
        jmp input
    done:
        mov CL, digits
        mov CH, 0
        combine:     
            pop BX
            mov DL, BL
            mov AL, [di]
            mov AH, 0
            mul BL
            add v1, AX
			inc di
        loop combine 
    mov AX, v1
    mov v11, AX

    L1:
        cmp v11, 0
        jbe ot
        mov AX, v11
        div v2
        mov BL, AH
        mov BH, 0
        push BX
        mov CL, AL
        mov CH, 0
        mov v11, CX
        add counter, 1
        jmp L1

    ot:
    mov CL, counter
    mov CH, 0

    
    L2:
        pop v3
        mov v11, CX
        mov CL, counter
        mov CH, 0
        sub CL, 1
        mov DX, v3
        mov result, DX
        L3:
            mov AX, DX
            mov DX, 0
            mul result
            mov DX, AX
        loop L3
        mov BX, AX
        add result2, BX
        mov CX, v11
    loop L2


    mov AX, result2
    cmp AX, v1
    je ed
    mov DX, offset armstrongn
    mov AH, 09
    int 21h
    jmp edd


    ed:
    mov DX, offset armstrong
    mov AH, 09
    int 21h


   edd:
    mov AH, 4Ch
    int 21h
end start   