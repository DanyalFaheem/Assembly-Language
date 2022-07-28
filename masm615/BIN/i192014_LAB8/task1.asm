.model small
.stack 100h
.data
v1 dw ?
arr dw 10 dup('$')
count db 2
digits db 0
multiplicant db 1, 10, 100
count1 db 0
msg db "Enter your number: ", '$'
.code
	start:
	mov ax, @data
	mov ds, ax
     main PROC 
     ;mov bp, sp
     mov si, offset arr
     mov CX, 10
    inp: 
    mov v1, 0
    mov DX, offset msg
    mov AH, 09
    int 21h
	mov di, offset multiplicant
    mov DX, CX
    mov digits, 0
    input:
        mov AH, 01
        int 21h
        cmp al, 13
        je done
        add digits, 1
		sub al, 48
        mov AH, 0
        push ax
        jmp input
    done:
        mov CL, digits
        mov CH, 0
        combine:     
            pop BX
            ;mov DL, BL
            mov AL, [di]
            mov AH, 0
            mul BL
            add v1, AX
			inc di
        loop combine 
    mov AX, v1
    push AX
    mov [si], AX
    inc si
    mov CX, DX
    loop inp 
    mov CX, 10
    print: 
    mov BX, CX 
    pop v1
    mov count1, 0
     L1:
        cmp v1, 0
        jbe display
        mov AX, v1
        mov DL, 10
        mov DH, 0
        div DL
        mov DL, AH
        mov DH, 0
        push DX
        inc count1
        ;mov BL, AH
        ;mov BH, 0
        ;push BX
        mov CL, AL
        mov CH, 0
        mov v1, CX
        jmp L1
    display:
        cmp count1, 0
        jbe ot
        pop DX
        add DL, 48
        mov AH, 02
        int 21h
        dec count1
        jmp display
    ot: 
    add count, 2
    mov DL, 10
    mov AH, 02
    int 21h
    mov CX, BX
    loop print
         
     main ENDP

     ed:
     mov AH, 4ch
     int 21h
     end start
   