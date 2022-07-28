include hw.lib
.model small
.stack 100h
.data
start_char db ?
v1 dw ?
digits db 0
multiplicant db 1, 10, 100
msg db "Enter your starting Character: ", '$'
msg1 db "Enter number of characters you want to print: ", '$'
.code
	start:
      main PROC 
    mov ax, @data
	mov ds, ax
    mov DX, offset msg
    mov AH, 09
    int 21h
    mov AH, 01
    int 21h
    mov start_char, al
    mov DL, 10
    mov AH, 02
    int 21h
    mov DX, offset msg1
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
    Chars_print start_char, v1
    mov ah, 4ch
    int 21h
    main endp
    end start
