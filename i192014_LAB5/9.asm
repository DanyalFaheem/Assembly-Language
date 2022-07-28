.model small
.stack 100h
.data
v1 db 8 dup('$')
.code
	start:
	mov ax, @data
	mov ds, ax
	
	mov CX, 4
	mov si, offset v1
	L1:
	
		mov AH,01
		int 21H
		mov di, si
		add di, 1
		sub al, 48
		mov [si], al
		mov bl, [si]
		mul bl
		mov [di], al
		add si, 2
		mov DL, 10
		mov AH, 02
		int 21h
		
	loop L1
	
	mov si, OFFSET v1
	mov CX, 8
	 L5:
	 	mov dl, [si]
	 	add dl, 48
	 	mov ah, 02
	 	int 21h
		mov DL, ','
		mov AH, 02
		int 21h		 	
	 	inc si
	 loop L5
	 
		mov AH, 4CH
	int 21h
	end start	
					
