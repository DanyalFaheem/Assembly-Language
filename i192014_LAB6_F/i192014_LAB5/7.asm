.model small
.stack 100h
.data
v1 db 6 dup('$')
key db ?
count db ?
.code
	start:
	mov ax, @data
	mov ds, ax


	mov CX, 6
	mov si, offset v1
	L8:
	
		mov AH,01
		int 21H
		
		sub al, 48
		mov [si], al
		add si, 1
		mov DL, 10
		mov AH, 02
		int 21h
	loop L8	
	
	mov DL, 'k'
	mov AH, 02
	int 21h		
	
	mov AH,01
	int 21H
	sub al, 48
	mov key, al
	
	mov DL, 10
	mov AH, 02
	int 21h
	mov CX, lengthof v1
	mov si, offset v1
	L1:
		mov al, [si]
		cmp key, al
		je swp
		L2:
			inc si
	loop L1
	
	mov DL, 10
	mov AH, 02
	int 21h		 
	mov dl, count
	add dl, 48
	int 21h	 
	jmp ed	 
	 
	swp:
		add count, 1
		jmp L2 
		
		
	ed:	 		
	mov AH, 4CH
	int 21h
	end start	
				
