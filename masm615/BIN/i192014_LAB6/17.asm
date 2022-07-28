.model small
.stack 100h
.data
v1 db ? 
v2 db ?
v3 db ?
v4 db ?
.code
	start:
	mov ax, @data
	mov ds, ax

    mov AH,01
    int 21H
    
    mov v1, al
    sub v1, 48
    inc si
    
    mov DL, 10
    mov AH, 02
    int 21h

    mov AH,01
    int 21H
    
    mov v2, al
    sub v2, 48
    inc si
    
    mov DL, 10
    mov AH, 02
    int 21h

    mov AH,01
    int 21H
    
    mov v3, al
    sub v3, 48
    inc si
    
    mov DL, 10
    mov AH, 02
    int 21h

    mov AH,01
    int 21H
    
    mov v4, al
    sub v4, 48
    inc si
    
    mov DL, 10
    mov AH, 02
    int 21h
	mov CX, 7
	L1:
		
		mov al, v1
		cmp al, v2
		ja skp1

		mov al, v2
		cmp al, v3
		ja skp2
		mov al, v3
		cmp al, v4
		ja skp13

		skp1:
			mov al, v1
			mov bl, v2
			mov v1, bl
			mov v2, al
			cmp al, v3
			ja skp2
			mov al, v3
			cmp al, v4
			ja skp13
			jmp temp

		skp2:
			mov al, v2
			mov bl, v3
			mov v2, bl
			mov v3, al
			cmp al, v4
			ja skp13
			jmp temp

		skp13:
			mov al, v3
			mov bl, v4
			mov v3, bl
			mov v4, al

		temp:

	loop L1		
   
    ed:
    mov DL, 10
    mov AH, 02
    int 21h

    mov DL, v1
    add DL, 48
    mov AH, 02
    int 21H

	mov DL, ','
    mov AH, 02
    int 21h

    mov DL, v2
    add DL, 48
    mov AH, 02
    int 21H

	mov DL, ','
    mov AH, 02
    int 21h

    mov DL, v3
    add DL, 48
    mov AH, 02
    int 21H

	mov DL, ','
    mov AH, 02
    int 21h

    mov DL, v4
    add DL, 48
    mov AH, 02
    int 21H

    mov AH, 4CH
    int 21H
    end start




