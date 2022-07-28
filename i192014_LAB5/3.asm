.model small
.stack 100h
.data
v1 db 5 dup('$')
v2 db 5 dup('$')
.code
	start:
	mov ax, @data
	mov ds, ax
	
	mov CX, 5
	mov si, offset v1
	L1:
	
		mov AH,01
		int 21H
		
		sub al, 48
		mov [si], al
		add si, 1
		mov DL, 10
		mov AH, 02
		int 21h
	loop L1
	mov si, offset v1
	add si, 4
	mov di, offset v2
	mov CX, 5
	L2:
		mov al, [si]
		mov [di], al
		dec si
		mov dl, [di]
		add dl, 48
		mov AH, 02
		int 21h
		inc di
		mov DL, ','
		mov AH, 02
		int 21h		
	loop L2		
	
	mov AH, 4CH
	int 21h
	
	end start 		
