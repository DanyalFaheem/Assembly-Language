.model small
.stack 100h
.data
v1 dw ?
sum1 dw 0
arr dw 5 dup('$')
count1 db 0
digits db 0
multiplicant db 1, 10, 100
msg db "Enter your number: ", '$'
msgsum db "The sum is: ", '$'
.code
	start:
	mov ax, @data
	mov ds, ax
    mov CX, 5
    mov si, offset arr
    push sum1
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
    call sum
    pop sum1
    mov DX, offset msgsum
    mov AH, 09
    int 21h
    mov AX, sum1
    mov v1, AX
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
    mov AH, 4ch
    int 21h
      sum PROC 
     mov bp, sp
     mov si, offset arr
     
    mov CX, 5 
    summer:
    add bp, 2
    mov AX, [bp]
    add sum1, ax
    loop summer
    add bp, 2
    mov AX, sum1
    mov [bp], AX
        RET 10
     sum ENDP
     end start