.model small
.stack 100h
.data
v1 db 6 dup('$')
.code
	start:
	mov ax, @data
	mov ds, ax
	
	mov CX, 5
	mov si, offset v1
	L1:
	
		mov AH,01
		int 21H
		
		mov [si], al
		add si, 1
		mov DL, 10
		mov AH, 02
		int 21h
	loop L1
	
	mov si, offset v1
	mov CX, lengthof v1
	dec CX
	L2:
		mov DL, [si]
		mov AH, 02
		int 21h
		mov DL, ','
		mov AH, 02
		int 21h
		inc si
	loop L2
	
	mov AH, 4CH
	int 21h
	
	end start 		
