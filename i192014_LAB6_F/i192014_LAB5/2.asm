.model small
.stack 100h
.data
v1 db 10 dup('$')
min db 9
max db 0
.code
	start:
	mov ax, @data
	mov ds, ax
	
	mov CX, 10
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
	
	mov CX, 10
	mov si, offset v1
	L2:
		mov al, [si]
		cmp al, max
		ja swp1
		cmp min, al
		ja swp2
		temp:
			inc si
	loop L2
	jmp ed
	swp1:
		mov max, al
		jmp temp
		
		
		
	swp2:				
		mov min, al
		jmp temp
		
	ed:
	mov DL, 10
	mov AH, 02
	int 21h
	mov DL, min
	add Dl, 48
	mov AH, 02
	int 21h
	mov DL, ','
	mov AH, 02
	int 21h	
	mov DL, max
	add Dl, 48
	mov AH, 02
	int 21h
	mov AH, 4CH
	int 21h
	
	end start 		
