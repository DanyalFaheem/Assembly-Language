.model small
.stack 100h
.data
msg db "Enter your string: ",'$'
str1 db 50 dup('$')
count db 0
count2 dw 0
.code
	start:
	mov ax, @data
	mov ds, ax
	
	mov DX, offset msg
	mov AH,09
	int 21h
	
	mov DX, offset str1
	mov AH, 3FH
	int 21h

   
    mov bl, 'a'
    mov cl, 'A'
    L1:     
     mov si, offset str1
    mov al, [si]
        mov count, 0
        L2:
            mov al, [si]
            cmp al, 13
            je print
            cmp al, bl
            je add_count
            cmp al, cl
            je add_count
            temp:
                inc si
            jmp L2  
        print:
            mov dl, bl
            mov ah, 02
            int 21h
            mov dl, ':'
            mov ah, 02
            int 21h
            mov dl, count
            add dl, 48
            mov ah, 02
            int 21h
            mov dl, ' '
            mov ah, 02
            int 21h
        cmp bl, 122
        je ed
        inc bl
        inc cl
        jmp L1

        add_count:
            add count, 1
            jmp temp

     ed:
        mov ah, 4ch
        int 21h
        end start



            



